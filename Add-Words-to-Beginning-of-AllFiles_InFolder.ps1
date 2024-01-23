$folderPath = "C:\Data\Powershell\TestFiles"
$files = Get-ChildItem $folderPath

foreach ($file in $files) {
$newName = "new_" + $file.Name
$newPath = Join-Path -Path $file.Directory.FullName -ChildPath $newName
Rename-Item -Path $file.FullName -NewName $newName
}