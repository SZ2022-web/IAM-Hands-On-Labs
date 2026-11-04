# IAM Hands-On Labs

Practical Identity and Access Management (IAM) projects using Microsoft Entra ID and Microsoft Graph PowerShell.

This portfolio documents my hands-on practice with user lifecycle management, password administration, security groups, directory roles, authentication, single sign-on, audit logs, and PowerShell automation. Each lab includes explanations and screenshots documenting the work performed.

## Lab Directory

| Lab | Project | Skills Practiced |
| --- | --- | --- |
| 00 | [Entra ID User Lifecycle](./Lab-00-Entra-ID-User-Lifecycle/) | User account administration and lifecycle fundamentals |
| 01 | [Employee Lifecycle](./Lab-01-Employee-Lifecycle/) | Onboarding, department transfers, group membership, offboarding, and sign-in validation |
| 02 | [Password Reset](./Lab-02-Password-Reset/) | Administrator password reset, user password change, and audit verification |
| 03 | [Group Management and RBAC](./Lab-03-Group-Management-and-RBAC/) | Security groups, Directory Readers role assignment, permission observations, and role removal |
| 04 | [MFA and Sign-in Evidence](./Lab-04-MFA/) | Authentication methods, security defaults, and interpretation of sign-in evidence |
| 05 | [SAML Single Sign-On](./Lab-05-SAML-SSO/) | SAML-based single sign-on configuration and testing |
| 06 | [User Provisioning and Deprovisioning](./Lab-06-Entra-ID-Provisioning-Deprovisioning/) | Manual user creation, group assignment, Authenticator registration, account disabling, session revocation, group removal, and audit review |
| 07 | [PowerShell IAM Automation](./Lab-07-PowerShell-IAM-Automation/) | CSV-based user provisioning, group assignment, account disabling, session-revocation requests, group removal, and read-back validation using Microsoft Graph PowerShell |

## Skills Demonstrated

- Creating and managing test user accounts
- Updating departments and job titles
- Managing security group memberships
- Assigning and removing directory roles
- Performing password administration
- Registering authentication methods and reviewing sign-in evidence
- Configuring and testing SAML-based single sign-on
- Performing manual user provisioning and deprovisioning
- Automating bulk identity tasks with Microsoft Graph PowerShell
- Processing CSV input and exporting result reports
- Handling errors in PowerShell workflows
- Verifying account state and group membership through separate queries
- Reviewing audit logs and documenting evidence limitations

## Featured Lab: PowerShell IAM Automation

In Lab 07, I used Microsoft Graph PowerShell to perform an identity lifecycle workflow for two fictional employees.

### Provisioning

- Imported employee information from a CSV file
- Created two test accounts with Finance department attributes
- Verified that both accounts were enabled
- Added both users to the LAB-Finance security group
- Independently verified their group memberships
- Exported provisioning and group-assignment results

### Offboarding

- Disabled both test accounts
- Requested revocation of their sign-in sessions
- Removed their LAB-Finance group memberships
- Exported offboarding and group-removal results
- Queried the directory again to verify the final state

### Verified Results

| Test User | Account Disabled | LAB-Finance Membership Removed |
| --- | --- | --- |
| LAB07 Jamie Lee | Yes | Yes |
| LAB07 Taylor Reed | Yes | Yes |

Microsoft Entra admin center screenshots also showed both accounts as **Disabled**, with **0 group memberships**.

The session-revocation API returned successful responses. This confirms the requests completed; termination of an active test-user session was not observed.

[View Lab 07 documentation, script, and screenshots](./Lab-07-PowerShell-IAM-Automation/)

## Tools and Technologies

- Microsoft Entra admin center
- Microsoft Graph PowerShell SDK
- PowerShell 7
- CSV input and reporting
- Microsoft Authenticator
- SAML single sign-on
- Audit and sign-in logs
- GitHub documentation

## About This Portfolio

These projects were completed in a personal lab using test accounts. They demonstrate hands-on learning and do not represent production employment experience.

Each lab documents its scope, observed results, and validation limitations. Public screenshots have personal account details redacted.

Lab 07 demonstrates an operator-run PowerShell workflow. It does not implement SCIM, HR integration, scheduling, or unattended authentication.
