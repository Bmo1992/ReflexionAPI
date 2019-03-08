Function Get-ReflexionCustomerUser
{
    <#
        .SYNOPSIS
          Get the Reflexion information for users of a specific customer under your enterprise.

        .DESCRIPTION
          Get the information of all users under a specific customer tied to your enterprise. The customer's enterprise ID is a required field in order to pull information from that customer.  

        .PARAMETER CustomerEnterpriseId
          Specify the customer's enterprise id. This field is required.

        .PARAMETER UserId
          Specify a specify user by their user id.

        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345
   
          Pulls all the uesrs from the customer with an enterprise ID of 12345.

        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345 -UserId 3131

          Pulls the information for the user with an ID of 3131 from the enterprise with an ID of 12345.

        .NOTES
          NAME    : Get-ReflexionCustomerUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 28, 2019

          REMAINING WORK:
            1. Query for specific users by their id, name, or primary smtp address
            2. Implement support for 
    #>
    [CmdletBinding(DefaultParameterSetName='CustomerId')]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$CustomerEnterpriseId,
        [Parameter(
            ParameterSetName='UserId',
            Mandatory=$False
        )]
        [string]$UserId
    )

    Try
    {
        $reflexion_customer_users = Invoke-RestMethod `
        -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$CustomerEnterpriseId/users" -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again."
    }

    if($UserId)
    {
        Try
        {
            $reflexion_customer_users | ?{ $_.userId -eq $UserId }
        }
        Catch
        {
            Throw "Unable to validate the Enterprise or User ID specified. Please confirm its correct and try again"
        }
    }
    else
    {
        $reflexion_customer_users
    }
}
