# Career Tracker - Backend with MySQL (requires MySQL80 running)
$ErrorActionPreference = "Stop"

$service = Get-Service MySQL80 -ErrorAction SilentlyContinue
if ($service -and $service.Status -ne 'Running') {
    Write-Host "Starting MySQL80 (requires Administrator)..."
    Start-Process net -ArgumentList "start","MySQL80" -Verb RunAs -Wait
}

$mvn = "$env:TEMP\apache-maven-3.9.6\bin\mvn.cmd"
if (-not (Test-Path $mvn)) {
    Write-Host "Maven not found. Install Maven or download to $env:TEMP\apache-maven-3.9.6"
    exit 1
}

$env:MAVEN_OPTS = "-Xmx512m -Xms256m"
Set-Location "$PSScriptRoot\backend"
& $mvn spring-boot:run "-Dspring-boot.run.jvmArguments=-Xmx512m -Xms256m"
