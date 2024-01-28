$folderPath = "C:\Data\Powershell"
$files = Get-ChildItem $folderPath

foreach ($file in $files) {
$newName = "new_" + $file.Name # You can modify the `$newName` variable to suit your renaming requirements
$newPath = Join-Path -Path $folderPath -ChildPath $newName
Rename-Item -Path $file.FullName -NewName $newName
}

# Remember to change $folderPath or create a c:\data\powershell location on your PC, otherwise script won't work