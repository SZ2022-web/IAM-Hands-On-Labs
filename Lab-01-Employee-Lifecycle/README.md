# Lab 01: Employee Identity Lifecycle in Microsoft Entra ID

Personal hands-on lab completed October 22, 2026.

## Scenario

I used an existing test account, Sara Test, to simulate an employee joining HR, transferring to Finance, and leaving a fictional company.

## Environment

Microsoft Entra ID Free, the Entra admin center, one test employee, and two manually assigned security groups: LAB-HR and LAB-Finance.

## Work performed

1. Enabled the previously disabled test account.
2. Entered HR employee attributes (HR Assistant; HR).
3. Created the department security groups and added Sara to LAB-HR.
4. Completed a successful sign-in as Sara after authentication setup.
5. Simulated the transfer by updating employee information and manually replacing LAB-HR membership with LAB-Finance membership.
6. Simulated offboarding by removing remaining membership, disabling the account, and revoking sign-in sessions.
7. Attempted access again and investigated the failed sign-in event.

## Verified results

| Check | Result |
|---|---|
| HR membership | Sara appeared in LAB-HR |
| User sign-in before offboarding | Successful account page and successful log events |
| Transfer membership | Only LAB-Finance appeared |
| Offboarding | Account disabled; no group memberships; session revocation confirmation |
| Sign-in after offboarding | Failed; error 50057; “The user account is disabled.” |

## Evidence

See [the screenshot index](SCREENSHOT-INDEX.md) for all 13 images in order.

## Lessons learned and scope

Assigned group memberships require manual updates; changing the Department field alone does not update these groups. Sign-in logs distinguish an earlier expired flow-token failure (50089) from the disabled-account failure (50057).

This lab demonstrates manual account and group lifecycle administration. No business application permissions, automated provisioning, or SSO integration were configured or tested. The session-revocation operation succeeded; immediate termination of every existing application session was not separately tested. Employee attribute changes were performed during the exercise; the supplied transfer screenshot verifies membership rather than the updated Finance profile fields. Audit-log change events have not yet been included.

## Before publishing

Screenshots have personal account details and visible identifiers redacted, with red outlines highlighting relevant evidence.
