$sourceFolder = "C:\Path\to\source\folder"
$destinationFolder = "C:\Path\to\destination\folder"

# Get all files in the source folder
$files = Get-ChildItem -Path $sourceFolder -File

# Move each file to the destination folder
foreach ($file in $files) {
    Move-Item -Path $file.FullName -Destination $destinationFolder
}

# Make sure to replace "C:\Path\to\source\folder" with the actual path 
# to your source folder, and "C:\Path\to\destination\folder" with the 
# actual path to your destination folder.

# Save the script with a .ps1 extension (e.g., move_files.ps1), and then 
# you can run it by opening PowerShell and executing the script using the 
# following command:

# .\move_files.ps1

# Note that you may need to adjust your PowerShell execution policy to allow 
# running scripts. You can do this by opening PowerShell as an administrator 
# and running the following command:

# Set-ExecutionPolicy RemoteSigned
# This will allow running locally created scripts.