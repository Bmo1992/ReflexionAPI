Function Get-ReflexionCustomer
{
    <#
        .SYNOPSIS
          Return information about a Reflexion customer under a given enterprise. By default information on all customers is returned.    

        .DESCRIPTION

        .PARAMETER EnterpriseId
          Specify the enterprise id of the API users enterprise.  This can be found with the Get-ReflexionApiUser function.

        .EXAMPLE
          Get-ReflexionCustomer -EnterpriseId "1234"

          Returns information on all customers for the enterprise with an ID of 1234. 

        .NOTES
          NAME    : Get-ReflexionCustomer
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992 
          CREATED : January 28, 2019
    #>
    # The enterprise ID is a required parameter and can be found with the Get-ReflexionApiUser function.
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$EnterpriseId
    )
    
    Try
    {
        Invoke-RestMethod -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$EnterpriseId/customers" -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again"
    }
}
