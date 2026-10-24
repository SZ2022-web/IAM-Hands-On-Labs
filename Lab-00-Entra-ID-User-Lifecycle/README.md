# Microsoft Entra ID — User Lifecycle Lab

## Overview
This hands-on IAM lab simulates an employee joining a company, changing departments, and leaving. I created a test user, updated their profile, disabled their account, and checked audit and sign-in logs.

## Tools
- Microsoft Entra admin center
- Personal Microsoft Entra tenant
- Audit logs and sign-in logs
- Fictional employee account: Sara Test

## 1. Joiner — Create the User
Created a cloud user named Sara Test with:
- Department: HR
- Job title: HR Assistant
- Account enabled: Yes

![User created](01-user-created.png)

![Original HR profile](02-original-HR-profile.png)

## 2. Mover — Update the Profile
Simulated a department transfer by changing:
- Department: HR → IT
- Job title: HR Assistant → IT Support Assistant

This step updated profile information only. It did not change application access or group membership.

![Updated IT profile](03-updated-IT-profile.png)

## 3. Leaver — Disable the Account
Disabled the test account to simulate an employee leaving.

![Account disabled](04-account-disabled.png)

## 4. Validate the Changes
Reviewed audit logs showing successful user creation, profile updates, and account disabling.

![Audit logs](05-audit-logs.png)

The disable event showed the AccountEnabled property changing from true to false.

![AccountEnabled change](06-account-enabled-change.png)

## 5. Verify the Blocked Sign-in
Attempted to sign in with the disabled account and reviewed its sign-in log.

Observed:
- Status: Failure
- Error code: 50057
- Failure reason: The user account is disabled.

![Disabled account sign-in log](07-disabled-sign-in-log.png)

## Troubleshooting
During testing, I temporarily enabled the account to reset its password, then disabled it again before attempting the final sign-in.

## Skills Practiced
- Cloud user creation
- User profile administration
- Account disabling
- Audit log review
- Sign-in failure investigation
- Documenting IAM changes and evidence

## Scope
This was a manual lab using a fictional user. Disabling an account is one part of offboarding. This project did not include session revocation, group or application access removal, license removal, or automated provisioning.
