# Adapted from the commands demonstrated in this lab. Requires PowerShell 7.
# Run one stage at a time in a test tenant. The packaged script has not been live-run.
#Requires -Version 7.0
[CmdletBinding()]
param(
 [Parameter(Mandatory)][ValidateSet('Provision','AssignGroup','Offboard','RemoveGroup','Validate')][string]$Stage,
 [Parameter(Mandatory)][guid]$TenantId,
 [Parameter(Mandatory)][string]$Domain,
 [Parameter(Mandatory)][guid]$GroupId
)
$ErrorActionPreference = 'Stop'
if ($Domain -notmatch '^[a-zA-Z0-9.-]+$') { throw 'Supply a verified tenant domain.' }
Connect-MgGraph -TenantId $TenantId -Scopes 'User.ReadWrite.All','GroupMember.ReadWrite.All','User.RevokeSessions.All' -ContextScope Process -NoWelcome
if ((Get-MgContext).TenantId -ne $TenantId.ToString()) { throw 'Wrong tenant.' }
$group = Get-MgGroup -GroupId $GroupId -Property Id,DisplayName,SecurityEnabled,GroupTypes,IsAssignableToRole
if ($group.DisplayName -ne 'LAB-Finance' -or !$group.SecurityEnabled -or $group.IsAssignableToRole -or $group.GroupTypes -contains 'DynamicMembership') {
 throw 'Expected the static LAB-Finance security group without role assignment.'
}
$allowed = @('lab07.jamie.lee','lab07.taylor.reed')
$rows = @(Import-Csv (Join-Path $PSScriptRoot 'new-users.csv'))
if ($rows.Count -ne 2 -or @($rows.MailNickname | Sort-Object -Unique).Count -ne 2) { throw 'Expected exactly two distinct lab users.' }
foreach ($row in $rows) { if ($row.MailNickname -notin $allowed -or $row.DisplayName -notlike 'LAB07 *') { throw 'Unexpected user in CSV.' } }
$results = foreach ($row in $rows) {
 $upn = "$($row.MailNickname)@$Domain"
 try {
  if ($Stage -eq 'Provision') {
   $existing = @(Get-MgUser -Filter "userPrincipalName eq '$upn'")
   if ($existing.Count) { $result = 'Already exists; unchanged' }
   else {
    $password = 'Aa1!' + [Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(24))
    try {
     $body = @{accountEnabled=$true;displayName=$row.DisplayName;mailNickname=$row.MailNickname;userPrincipalName=$upn;department=$row.Department;jobTitle=$row.JobTitle;passwordProfile=@{password=$password;forceChangePasswordNextSignIn=$true}}
     New-MgUser -BodyParameter $body | Out-Null
     $result = 'Created'
    } finally { $password=$null; $body=$null }
   }
  } else {
   $user = Get-MgUser -UserId $upn -Property Id,DisplayName,UserPrincipalName,AccountEnabled
   if ($user.DisplayName -ne $row.DisplayName) { throw 'User display name differs from CSV; stopping this user.' }
   switch ($Stage) {
    'AssignGroup' {
     $ids = @(Get-MgGroupMember -GroupId $GroupId -All | Select-Object -ExpandProperty Id)
     if ($user.Id -in $ids) { $result='Already a member' }
     else { New-MgGroupMemberByRef -GroupId $GroupId -BodyParameter @{'@odata.id'="https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"}; $result='Added' }
    }
    'Offboard' {
     $disabled='Not verified'; $revocation='Not requested'
     try {
      Update-MgUser -UserId $user.Id -AccountEnabled:$false
      $check=Get-MgUser -UserId $user.Id -Property AccountEnabled
      $disabled=if ($check.AccountEnabled -eq $false) {'Verified disabled'} else {'Not yet verified'}
     } catch { $disabled="Failed: $($_.Exception.Message)" }
     try { $response=Revoke-MgUserSignInSession -UserId $user.Id; $revocation="Request completed: $($response.Value)" }
     catch { $revocation="Failed: $($_.Exception.Message)" }
     $result="Account: $disabled; session revocation: $revocation"
    }
    'RemoveGroup' {
     $ids=@(Get-MgGroupMember -GroupId $GroupId -All | Select-Object -ExpandProperty Id)
     if ($user.Id -in $ids) { Remove-MgGroupMemberDirectoryObjectByRef -GroupId $GroupId -DirectoryObjectId $user.Id }
     $ids=@(Get-MgGroupMember -GroupId $GroupId -All | Select-Object -ExpandProperty Id)
     $result=if ($user.Id -notin $ids) {'Verified not a member'} else {'Removal not yet verified'}
    }
    'Validate' {
     $ids=@(Get-MgGroupMember -GroupId $GroupId -All | Select-Object -ExpandProperty Id)
     [pscustomobject]@{User=$row.DisplayName;AccountDisabled=($user.AccountEnabled -eq $false);FinanceMembershipRemoved=($user.Id -notin $ids)}
     continue
    }
   }
  }
  if ($Stage -ne 'Validate') { [pscustomobject]@{User=$row.DisplayName;Stage=$Stage;Result=$result} }
 } catch { [pscustomobject]@{User=$row.DisplayName;Stage=$Stage;Result="Failed: $($_.Exception.Message)"} }
}
$results | Export-Csv (Join-Path $PSScriptRoot "$Stage-results.csv") -NoTypeInformation
$results | Format-Table -Wrap
# Disconnect-MgGraph after completing the desired stages.
