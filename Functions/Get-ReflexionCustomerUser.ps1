Function Get-ReflexionCustomerUser
{
    <#
        .SYNOPSIS
          Get the Reflexion information for users of a specific customer under your enterprise.

        .DESCRIPTION

        .PARAMETER CustomerId
          Specify the customer's enterprise id. This field is required.

        .PARAMETER UserId
          Specify a specify user by their user id.

        .EXAMPLE

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
        [string]$CustomerId,
        [Parameter(
            ParameterSetName='UserId',
            Mandatory=$False
        )]
        [string]$UserId
    )

    Try
    {
        $reflexion_customer_users = Invoke-RestMethod -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$CustomerId/users" `
        -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again."
    }

    if($UserId)
    {
        # Get the user by their id -> unimplemented 
    }
    else
    {
        $reflexion_customer_users
    }
}
