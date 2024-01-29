# If applicable, connect to VPN
$folderPath = "C:\Data\Powershell\TestFiles" # Create this location or change it to 1 of your own
$newOwner = "MyUserName@domain.com" # Use the account you want to change ownership to

# Get the current security descriptor of the folder
$folderACL = Get-Acl -Path $folderPath

# Create a new owner identity reference
$newOwnerIdentity = New-Object System.Security.Principal.NTAccount($newOwner)

# Set the new owner for the folder
$folderACL.SetOwner($newOwnerIdentity)

# Apply the modified security descriptor to the folder
Set-Acl -Path $folderPath -AclObject $folderACL