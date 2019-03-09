Function Get-ReflexionCustomerUser
{
    <#
        .SYNOPSIS
          Get the Reflexion information for users of a specific customer under your enterprise.

        .DESCRIPTION
          Get the information of all users under a specific customer tied to your enterprise. The customer's enterprise ID is a required field in order to pull information from that customer. A specific users information can be queried by specifying their Reflexion UserId, primary smtp address, or name.

        .PARAMETER CustomerEnterpriseId
          Specify the customer's enterprise id. This field is required.

        .PARAMETER UserId
          Specify a specific user by their user id.

        .PARAMETER PrimaryAddress
          Specify a specific user by their primary smtp address.

        .PARAMETER Name
          Specify a specific user by their name.

        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345
   
          Pulls all the uesrs from the customer with an enterprise ID of 12345.

        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345 -UserId 3131

          Pulls the information for the user with an ID of 3131 from the enterprise with an ID of 12345.

        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345 -PrimaryAddress "jdoe@bigcompany.com"

          Pulls all information for the user with a primary address of jdoe@bigcompany.com from the customer with an enterprise Id of 12345.
    
        .EXAMPLE
          Get-ReflexionCustomerUser -CustomerEnterpriseId 12345 -Name "John Doe"

          Pulls all information for a user with the name "John Doe" from the customer with an enterprise Id of 12345.

        .NOTES
          NAME    : Get-ReflexionCustomerUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 28, 2019
    #>
    [CmdletBinding(DefaultParameterSetName='CustomerEnterpriseId')]
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
        [string]$UserId,
        [Parameter(
            ParameterSetName='PrimaryAddress',
            Mandatory=$False
        )]
        [string]$PrimaryAddress,
        [Parameter(
            ParameterSetName='Name',
            Mandatory=$False
        )]
        [string]$Name
    )

    # First confirm we can connect to the Reflexion API and then store all user info in a variable.
    Try
    {
        $reflexion_customer_users = Invoke-RestMethod `
        -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$CustomerEnterpriseId/users" -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again."
    }

    # Check for any arguments that have been passed to query for a specific user.  Return the info based on the query or list all users.
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
    elseif($PrimaryAddress)
    {
        Try
        {
            $reflexion_customer_users | ?{ $_.primaryAddress -eq $PrimaryAddress }
        }
        Catch
        {
            Throw "Unable to validate the Enterprise or User Primary Address specified. Please confirm its correct and try again"
        }
    }
    elseif($Name)
    {
        Try
        {
            $reflexion_customer_users | ?{ $_.name -eq $Name }
        }
        Catch
        {
            Throw "Unable to validate the Enterprise or User Name specified. Please confirm its correct and try again"
        }
    }
    else
    {
        $reflexion_customer_users
    }
}
