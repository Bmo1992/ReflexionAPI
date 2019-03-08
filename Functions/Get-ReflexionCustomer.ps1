Function Get-ReflexionCustomer
{
    <#
        .SYNOPSIS
          Return information about a Reflexion customer under a given enterprise. By default information on all customers is returned.    

        .DESCRIPTION
          Queries the Reflexion api for all customers under a specific enterprise id.  The value returns as a PS Customer Object. A 
          specific customer can be queried for by specifying their customer id or full name.

        .PARAMETER EnterpriseId
          Specify the enterprise id of the API users enterprise.  This can be found with the Get-ReflexionApiUser function.

        .PARAMETER CustomerEnterpriseId
          Pull information for a specific customer by specifying their Reflexion EnterpriseId.

        .PARAMETER CustomerName
          Pull information for a specific customer by spcifying their enterprise Name.

        .EXAMPLE
          Get-ReflexionCustomer -EnterpriseId "1234"

          Returns information on all customers for the enterprise with an ID of 1234. 

        .EXAMPLE
          Get-ReflexionCustomer -EnterpriseId "1234" -CustomerId "5678"

          Returns the information for the customer the customer of enterprise 1234 when the customers enterprise id 5678

        .EXAMPLE
          Get-ReflexionCustomer -EnterpriseId "1234" -CustomerName "Big Corp" 

          Returns information for the customer of the enterprise with id 1234 named "Big Corp" 

        .NOTES
          NAME    : Get-ReflexionCustomer
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992 
          CREATED : January 28, 2019
    #>
    # The enterprise id the API user belongs too is required. A specific user can be queried with the CustomerId or CustomerName
    # parameter (these can not be used together). 
    [CmdletBinding(DefaultParameterSetName='EnterpriseId')]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$EnterpriseId,
        [Parameter(
            ParameterSetName='CustomerId',
            Mandatory=$False
        )]
        [string]$CustomerEnterpriseId,
        [Parameter(
            ParameterSetName='CustomerName',
            Mandatory=$False
        )]
        [string]$CustomerName
    )
    
    Try
    {
        $all_reflexion_customers = Invoke-RestMethod -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$EnterpriseId/customers" `
        -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again"
    }

    if($CustomerEnterpriseId)
    {
        $all_reflexion_customers | Where `
        {
            $_.enterpriseId -eq $CustomerEnterpriseId
        }
    }
    elseif($CustomerName)
    {
        $all_reflexion_customers | Where `
        {
            $_.Name -eq $CustomerName
        }
    }
    else
    {
        $all_reflexion_customers
    }
}
