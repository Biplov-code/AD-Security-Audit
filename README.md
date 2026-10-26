# Active Directory Security Audit

PowerShell-based security automation project for reviewing Active Directory account hygiene and privileged access in a controlled Windows Server lab.

## What this project demonstrates

- Identity and Access Management (IAM)
- Active Directory administration
- Privileged access review
- Least-privilege principles
- Account lifecycle management
- PowerShell security automation
- CSV-based security reporting

## What the script checks

The audit script reviews domain users and highlights:

- Disabled accounts
- Accounts that have not logged on within a configurable number of days
- Accounts configured with passwords that never expire
- Password last-set dates
- Membership in privileged groups such as Domain Admins, Enterprise Admins, and Administrators

## Repository structure

```text
AD-Security-Audit/
├── AD-Security-Audit.ps1
├── README.md
└── sample-output/
    ├── AD-Security-Audit-Sample.csv
    └── Privileged-Accounts-Sample.csv
```

## Usage

Run the script from a Windows system with the Active Directory PowerShell module installed and appropriate read permissions.

```powershell
.\AD-Security-Audit.ps1
```

The script creates two CSV reports in the current directory:

- `AD-Security-Audit-Results.csv`
- `Privileged-Accounts.csv`

## Security value

Automating recurring identity reviews reduces manual effort and makes it easier to identify stale accounts, risky password settings, and unnecessary privileged access. These findings can support access reviews and remediation workflows.

## Lab note

This project is documented using sanitized sample data. No employer, production, credential, or sensitive user information is included.
