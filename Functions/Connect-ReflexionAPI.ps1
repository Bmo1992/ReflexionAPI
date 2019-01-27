function Connect-ReflexionAPI 
{
    <#
    .SYNOPSIS
      Connect to the Reflexion API

    .DESCRIPTION
      Create an authentication token which is required to pass in the headers of any RESTful web request per Reflexion documentation. The headers are then exported to the global environment to be accessable to the other module functions.  The auth token has a 30 minute timeout, after that Connect-ReflexionAPI will need to be run again to generate a new token.

    .PARAMETER ServiceKey
      Pass the API service key located in the reflexion portal next to your API enabled user.

    .EXAMPLE
      Connect-ReflexionAPI -ServiceKey <API Key>

      Authenticate to the Reflexion API generating a authentication token that can be used for subsequent API calls. 
    
    .NOTES
      NAME    : ConnectTo-Reflexion
      AUTHOR  : BMO
      EMAIL   : brandonseahorse@gmail.com
      GITHUB  : github.com/Bmo1992
      CREATED : January 18, 2019
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$ServiceKey
    )
    
    #### VARIABLES ####

    # url for the generating an authentication token
    $api_auth_url = "https://api.reflexion.net/rfx-rest-api/auth"

    # Prompt for the API enabled user credentials and store them as ps objects in the creds table
    $ps_cred = Get-Credential -Message "Enter Credentials for you API Enabled Reflexion User"
    $creds = @{
        "username" = $ps_cred.username
        "password" = $ps_cred.GetNetworkCredential().password
    }
   
    # Create the headers required for API authentication per the Reflexion documentation. The headers need to be global
    # in order to be accessable to the other functions in the module
    $global:reflexion_headers = @{
        "service_key" = $ServiceKey;
        "content-type" = "application/json";
        "accept" = "application/json"
    }

    # Generate the auth token and store it in the headers
    $session = Invoke-RestMethod -Uri $api_auth_url -Method Post -Body ($creds | ConvertTo-Json) -Headers $reflexion_headers
    $auth_token = $session.auth_token
    $global:reflexion_headers["auth_token"] = $auth_token

    # Send the userId to stdout, this will be required to make further API calls
    Write-Host "Authentication Succesfull. The following is your user ID: $($session.userId)"
    Write-Host $null
}
