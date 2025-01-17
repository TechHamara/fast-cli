# Update scripts for Windows
$zipUrl = "https://github.com/jewelshkjony/fast-cli/releases/download/v2.2.0/update.zip"

# Check if FAST_HOME environment variable exists and use it, otherwise fallback to LOCALAPPDATA\Fast
if ($env:FAST_HOME) {
    $destinationDir = $env:FAST_HOME
} else {
    $destinationDir = "$env:LOCALAPPDATA\Fast"
}

# Define the path for the downloaded zip file
$zipLocation = "$destinationDir\Fast.zip"

# Check if the destination directory exists, if not, exit with an error
if (-not (Test-Path -Path $destinationDir)) {
    Write-Output "Fast is not installed! Please install it first."
    exit 1
}

# GitHub requires TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download the new ZIP file to the specified location
Write-Output "Downloading the update for Fast tool..."
Invoke-WebRequest -Uri $zipUrl -OutFile $zipLocation -UseBasicParsing

# Check if the ZIP file was downloaded successfully
if (-not (Test-Path -Path $zipLocation)) {
    Write-Output "Error: Failed to download the update!"
    exit 1
}

# Extract the ZIP file, replacing the existing files
Write-Output "Updating Fast tool..."
if (Get-Command Expand-Archive -ErrorAction SilentlyContinue) {
    Expand-Archive -Path $zipLocation -DestinationPath $destinationDir -Force
}
else {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [IO.Compression.ZipFile]::ExtractToDirectory($zipLocation, $destinationDir)
}

# Remove the downloaded ZIP file
Remove-Item $zipLocation

Write-Output "Fast has been successfully updated to v2.2.0 05.01.25.20.51"
