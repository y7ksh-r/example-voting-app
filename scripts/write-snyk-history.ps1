param(
    [Parameter(Mandatory = $true)]
    [string]$JsonFilePath,

    [Parameter(Mandatory = $true)]
    [string]$HistoryLogPath,

    [Parameter(Mandatory = $true)]
    [string]$ServiceName
)

# Load JSON
$report = Get-Content $JsonFilePath | ConvertFrom-Json

# Timestamp
$timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
"==== SNYK SCAN ($ServiceName) $timestamp ====" | Out-File -Append $HistoryLogPath

# No vulnerabilities
if ($report.vulnerabilities.Count -eq 0) {
    "Issues Found: 0" | Out-File -Append $HistoryLogPath
    "" | Out-File -Append $HistoryLogPath
    exit
}

# Vulnerability summary
"Issues Found: $($report.vulnerabilities.Count)" | Out-File -Append $HistoryLogPath

foreach ($v in $report.vulnerabilities) {
    "" | Out-File -Append $HistoryLogPath
    "Title: $($v.title)" | Out-File -Append $HistoryLogPath
    "Severity: $($v.severity)" | Out-File -Append $HistoryLogPath
    "Package: $($v.packageName)" | Out-File -Append $HistoryLogPath
    "Version: $($v.version)" | Out-File -Append $HistoryLogPath
    "CVE: $($v.identifiers.CVE)" | Out-File -Append $HistoryLogPath
    "From: $($v.from -join ' -> ')" | Out-File -Append $HistoryLogPath
    "Description: $($v.description)" | Out-File -Append $HistoryLogPath
}
"" | Out-File -Append $HistoryLogPath
