function ConnectTo-Reflexion 
{
    <#
    .SYNOPSIS
      Connect to the Reflexion API

    .DESCRIPTION
      Create an authentication token which is required to pass in the headers of any RESTful web request per Reflexion documentation.

    .PARAMETER ServiceKey
      Pass the API service key located in the reflexion portal next to your API enabled user.

    .EXAMPLE
      ConnectTo-Reflexion 
    
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
    $global:headers = @{
        "service_key" = $ServiceKey;
        "content-type" = "application/json";
        "accept" = "application/json"
    }

    # Generate the auth token and store it in the headers
    $session = Invoke-RestMethod -Uri $api_auth_url -Method Post -Body ($creds | ConvertTo-Json) -Headers $headers
    $auth_token = $session.auth_token
    $global:headers["auth_token"] = $auth_token

}
