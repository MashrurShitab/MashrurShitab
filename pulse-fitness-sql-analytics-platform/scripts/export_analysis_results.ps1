<#
Pulse Fitness SQL Analytics Platform
Exports the 12 analysis queries to results/*.csv without sharing a MySQL password with Codex.

Usage examples:
  powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User root
  powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User pulse_runner
  powershell -ExecutionPolicy Bypass -File scripts/export_analysis_results.ps1 -User root -RunSetup

Use -RunSetup only if you want this script to run the schema/data scripts before exporting.
#>

param(
    [string]$MysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    [string]$User = "root",
    [switch]$RunSetup
)

$ErrorActionPreference = "Stop"
$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$PasswordSecure = Read-Host "MySQL password for user '$User'" -AsSecureString
$PasswordPtr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($PasswordSecure)
$Password = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($PasswordPtr)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($PasswordPtr)

if (-not (Test-Path -LiteralPath $MysqlPath)) {
    throw "mysql.exe was not found at '$MysqlPath'. Pass -MysqlPath with the correct path."
}

function Invoke-MysqlSource {
    param([string]$SqlFile)
    $FullPath = (Resolve-Path (Join-Path $ProjectRoot $SqlFile)).Path.Replace("\", "/")
    Write-Host "Running $SqlFile"
    & $MysqlPath "--user=$User" "--password=$Password" "--execute=source $FullPath"
    if ($LASTEXITCODE -ne 0) {
        throw "MySQL failed while running $SqlFile"
    }
}

function Convert-TsvLinesToCsv {
    param(
        [string[]]$Lines,
        [string]$OutputPath
    )

    function Escape-CsvField([string]$Value) {
        if ($null -eq $Value) { return "" }
        $Value = $Value -replace "`r", " " -replace "`n", " "
        if ($Value.Contains('"') -or $Value.Contains(',') -or $Value.Contains(' ')) {
            return '"' + ($Value -replace '"', '""') + '"'
        }
        return $Value
    }

    $CsvLines = @()
    foreach ($Line in $Lines) {
        if ([string]::IsNullOrWhiteSpace($Line)) { continue }
        if ($Line -like "mysql: [Warning]*") { continue }
        $Fields = $Line -split "`t", -1
        $CsvLines += (($Fields | ForEach-Object { Escape-CsvField $_ }) -join ",")
    }

    if ($CsvLines.Count -eq 0) {
        throw "No output returned for $OutputPath"
    }

    Set-Content -LiteralPath $OutputPath -Value $CsvLines -Encoding UTF8
}

if ($RunSetup) {
    $SetupFiles = @(
        "schema/01_create_database.sql",
        "schema/02_create_tables_v2.sql",
        "schema/03_constraints_indexes.sql",
        "data/01_insert_static_data.sql",
        "data/02_insert_dummy_members_trainers.sql",
        "data/03_insert_dummy_activity_payments.sql",
        "data/04_insert_dummy_attendance.sql"
    )

    foreach ($File in $SetupFiles) {
        Invoke-MysqlSource -SqlFile $File
    }
}

$Exports = @(
    @{ Sql = "analysis/01_membership_revenue.sql"; Csv = "results/01_membership_revenue.csv" },
    @{ Sql = "analysis/02_revenue_by_location.sql"; Csv = "results/02_revenue_by_location.csv" },
    @{ Sql = "analysis/03_payment_failure_analysis.sql"; Csv = "results/03_payment_failure_analysis.csv" },
    @{ Sql = "analysis/04_peak_usage_hours.sql"; Csv = "results/04_peak_usage_hours.csv" },
    @{ Sql = "analysis/05_class_attendance_rate.sql"; Csv = "results/05_class_attendance_rate.csv" },
    @{ Sql = "analysis/06_trainer_utilisation.sql"; Csv = "results/06_trainer_utilisation.csv" },
    @{ Sql = "analysis/07_underutilised_members.sql"; Csv = "results/07_underutilised_members.csv" },
    @{ Sql = "analysis/08_member_segmentation.sql"; Csv = "results/08_member_segmentation.csv" },
    @{ Sql = "analysis/09_churn_risk_ranking.sql"; Csv = "results/09_churn_risk_ranking.csv" },
    @{ Sql = "analysis/10_customer_lifetime_value.sql"; Csv = "results/10_customer_lifetime_value.csv" },
    @{ Sql = "analysis/11_upgrade_opportunity.sql"; Csv = "results/11_upgrade_opportunity.csv" },
    @{ Sql = "analysis/12_location_efficiency_scorecard.sql"; Csv = "results/12_location_efficiency_scorecard.csv" }
)

foreach ($Export in $Exports) {
    $SqlPath = (Resolve-Path (Join-Path $ProjectRoot $Export.Sql)).Path.Replace("\", "/")
    $CsvPath = Join-Path $ProjectRoot $Export.Csv
    Write-Host "Exporting $($Export.Sql) -> $($Export.Csv)"

    $Output = & $MysqlPath "--user=$User" "--password=$Password" "--batch" "--raw" "--default-character-set=utf8mb4" "--execute=source $SqlPath" 2>&1
    if ($LASTEXITCODE -ne 0) {
        $Output | ForEach-Object { Write-Host $_ }
        throw "MySQL failed while exporting $($Export.Sql)"
    }

    Convert-TsvLinesToCsv -Lines $Output -OutputPath $CsvPath
}

Write-Host "All analysis CSV exports completed."
Write-Host "Next: run python scripts/update_recommendations_from_results.py"
