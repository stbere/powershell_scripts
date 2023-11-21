# Import required module
Install-Module AzureAD
Import-Module AzureAD

# Connect to the AzureAD service
Connect-AzureAD

# Access tokens using the Power BI service principle from Azure AD
$clientId = "MyClientID"
$tenantId = "MyTenantID"
$clientSecret = "MyClientSecret"
$resource = "https://analysis.windows.net/powerbi/api"
$authority = "https://login.microsoftonline.com/$tenantId"
$tokenUrl = "$authority/oauth2/token"

# Create variable for access tokens
$body = @{
    "resource" = "$resource";
    "client_id" = "$clientId";
    "client_secret" = "$clientSecret";
    "grant_type" = "client_credentials"
}

# Pass PBI token thru API service
$tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method POST -Body $body

$workspacesUrl = "https://api.powerbi.com/v1.0/myorg/groups"
$header = @{
    "Authorization" = "Bearer $($tokenResponse.access_token)"
}

$workspacesResponse = Invoke-RestMethod -Uri $workspacesUrl -Method GET -Headers $header

# Checking to see if workspaces are v1 classic or v2 modern
$workspaceVersions = $workspacesResponse.value | Select id, name, @{n='version';e={if ($_.isOnDedicatedCapacity) {'v1'} else {'v2'}}}

# Export results to local computer - change "c:\
$workspaceVersions | Export-Csv -Path "c:\data\PowerShellExports\workspacesAll-110723.csv" -NoTypeInformation