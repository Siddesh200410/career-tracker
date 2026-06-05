# Career Tracker - Frontend static server
Set-Location "$PSScriptRoot\frontend"
Write-Host "Open http://localhost:5500 in your browser"

if (Get-Command python -ErrorAction SilentlyContinue) {
    python -m http.server 5500
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    py -m http.server 5500
} elseif (Get-Command node -ErrorAction SilentlyContinue) {
    $env:NODE_OPTIONS = "--max-old-space-size=128"
    npx --yes serve . -l 5500
} else {
    Write-Host "No Python or Node found. Open frontend\index.html directly (API calls may be blocked by CORS)."
    Start-Process "$PSScriptRoot\frontend\index.html"
}
