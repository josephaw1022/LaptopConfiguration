# PowerShell script to import Winget packages from winget-config.json

# Define the path to the winget-config.json file
$wingetConfigPath = "windows-11\winget-config.json"

# Check if the winget-config.json file exists
if (Test-Path $wingetConfigPath) {
    Write-Host "Importing packages from winget-config.json..."
    
    # Run the winget import command
    winget import --file $wingetConfigPath

    Write-Host "Import complete. Verify the installation by running 'winget list'."
} else {
    Write-Host "The winget-config.json file could not be found at $wingetConfigPath. Please check the file path."
    exit 1
}