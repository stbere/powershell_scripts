# Install AzureAD module if not already installed
if (-not (Get-Module -Name AzureAD -ListAvailable)) {
    Install-Module -Name AzureAD -Force -Scope CurrentUser
}

# Import the AzureAD module
Import-Module AzureAD -Force

# Specify your app ID and client secret
$clientId = "MyClientID"
$tenantId = "MyTenant"
$clientSecret = "MySecret"
$resource = "https://analysis.windows.net/powerbi/api"
$authority = "UseTheLogin.Microsoft.Com Here"
$tokenUrl = "MyURL"

# Create variable for access tokens
$body = @{
    "resource" = "$resource";
    "client_id" = "$appId";
    "client_secret" = "$clientSecret";
    "grant_type" = "client_credentials"
}

# Pass PBI token thru API service
$tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method POST -Body $body

# Specify your Power BI username or email as the new owner
$newOwner = "ablasisa@hpinc.com"

# Connect to Power BI service using the obtained token and credentials
Connect-PowerBIServiceAccount -ServicePrincipal -Credential $credential -TenantId $tenantId -ErrorAction Stop

# Get all workspaces
$allWorkspaces = Get-PowerBIWorkspace -Scope Individual

# Specify the workspace names you want to change ownership for
$workspaceNames = "Analyze Popular Stocks with Power BI"

foreach ($workspaceName in $workspaceNames) {
    # Find the workspace by name
    $workspace = $allWorkspaces | Where-Object { $_.Name -eq $workspaceName }

    if ($workspace -ne $null) {
        # Change the owner of the workspace
        Set-PowerBIWorkspace -Id $workspace.Id -UserPrincipalName $newOwner
        Write-Host "Ownership changed for workspace: $($workspace.Name)"
    } else {
        Write-Host "Workspace '$workspaceName' not found."
    }
}
