Function Get-ReflexionApiUser
{
    <#
        .SYNOPSIS
          Get the account information of an authorized Reflexion API user.  

        .DESCRIPTION
          Retrieve the account info of the Reflexion API user. The returned information includes mailbox information about the user and the enterprise Id tried to the account.  The enterprise Id is required to manage enterprises, customers, and their users.

        .PARAMETER UserId
          Specify the Id of the authorized Reflexion API user.

        .EXAMPLE
          Get-ReflexionApiUser -UserId "12345"

          Returns the account information of the Reflexion API user with a user ID of 12345.

        .NOTES
          NAME    : Get-ReflexionApiUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : January 27, 2019
    #>
    # The Reflexion API User ID is required to return information on the user
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$UserId
    )

    Try
    {
        Invoke-RestMethod -Uri "https://api.reflexion.net/rfx-rest-api/users/$UserId" -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion. If your authentication token has expired run the Connect-ReflexionAPI function and try again"
    }
}
