# Career Tracker - Backend (uses H2 if MySQL is not running)
$ErrorActionPreference = "Stop"

$mvn = "$env:TEMP\apache-maven-3.9.6\bin\mvn.cmd"
if (-not (Test-Path $mvn)) {
    Write-Host "Maven not found. Install Maven or download to $env:TEMP\apache-maven-3.9.6"
    exit 1
}

try {
    $null = Invoke-WebRequest -Uri "http://localhost:8080/api/dashboard/stats" -UseBasicParsing -TimeoutSec 2
    Write-Host "Backend already running at http://localhost:8080"
    exit 0
} catch {}

$env:MAVEN_OPTS = "-Xmx128m -Xms64m -XX:+UseSerialGC"
Set-Location "$PSScriptRoot\backend"

# Use dev profile (H2 file DB) - no MySQL required
& $mvn spring-boot:run `
    "-Dspring-boot.run.jvmArguments=-Xmx256m -Xms128m -XX:+UseSerialGC" `
    "-Dspring-boot.run.arguments=--spring.profiles.active=dev"
