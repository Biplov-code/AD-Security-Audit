Import-Module ActiveDirectory

$InactiveDays = 90
$CutoffDate = (Get-Date).AddDays(-$InactiveDays)

Write-Host "Starting Active Directory security audit..."

$Users = Get-ADUser -Filter * -Properties Enabled, LastLogonDate, PasswordLastSet, PasswordNeverExpires

$AuditResults = foreach ($User in $Users) {
    $SecurityStatus = "Normal"

    if (-not $User.Enabled) {
        $SecurityStatus = "Disabled Account"
    }
    elseif ($User.LastLogonDate -and $User.LastLogonDate -lt $CutoffDate) {
        $SecurityStatus = "Inactive Account"
    }
    elseif ($User.PasswordNeverExpires) {
        $SecurityStatus = "Password Never Expires"
    }

    [PSCustomObject]@{
        Username             = $User.SamAccountName
        Enabled              = $User.Enabled
        LastLogonDate        = $User.LastLogonDate
        PasswordLastSet      = $User.PasswordLastSet
        PasswordNeverExpires = $User.PasswordNeverExpires
        SecurityStatus       = $SecurityStatus
    }
}

$AuditResults | Export-Csv -Path ".\AD-Security-Audit-Results.csv" -NoTypeInformation

$PrivilegedGroups = @(
    "Domain Admins",
    "Enterprise Admins",
    "Administrators"
)

$PrivilegedResults = foreach ($Group in $PrivilegedGroups) {
    try {
        Get-ADGroupMember $Group | ForEach-Object {
            [PSCustomObject]@{
                Group       = $Group
                Name        = $_.Name
                AccountName = $_.SamAccountName
                ObjectType  = $_.ObjectClass
            }
        }
    }
    catch {
        Write-Warning "Unable to query group: $Group"
    }
}

$PrivilegedResults | Export-Csv -Path ".\Privileged-Accounts.csv" -NoTypeInformation

Write-Host "Audit complete. CSV reports have been generated."
