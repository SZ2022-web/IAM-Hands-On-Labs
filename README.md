# IAM Hands-On Labs

Practical Identity and Access Management (IAM) projects using Microsoft Entra ID.

This portfolio documents my hands-on practice with user lifecycle management, password administration, security groups, directory roles, authentication, and audit logs. Each lab includes explanations and screenshots documenting the work performed.

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

## Skills Demonstrated

- Creating and managing test user accounts
- Managing security group memberships
- Assigning and removing directory roles
- Resetting passwords and reviewing audit records
- Registering authentication methods
- Configuring and testing SAML single sign-on
- Performing manual user provisioning and deprovisioning
- Reviewing audit and sign-in evidence
- Documenting procedures, results, and validation limitations

## Featured Project: User Provisioning and Deprovisioning

Lab 06 follows a fictional employee, Alex Morgan, through onboarding and offboarding in Microsoft Entra ID.

### Onboarding

- Created the test user account.
- Added the user to the LAB-Finance security group.
- Registered Microsoft Authenticator.
- Confirmed group membership and reviewed audit records.

### Offboarding

- Disabled the user account.
- Revoked sign-in sessions.
- Removed the LAB-Finance group membership.
- Confirmed that no group memberships remained.
- Observed a blocked account message during a subsequent sign-in attempt.

### Scope and Validation

This lab demonstrates manual administration. Automated provisioning, SCIM, and HR integrations were outside its scope.

Group membership does not establish access to a Finance application, and Authenticator registration alone does not prove MFA enforcement. A failed sign-in log was not captured, so the exact sign-in rejection reason was not confirmed through logs.

## About This Portfolio

These projects were completed in a personal lab using test accounts. They represent hands-on learning rather than production employment experience.

Each lab documents its scope, observed results, and evidence limitations. Personal account details are redacted from public screenshots. Individual lab notes explain any additional image processing.
