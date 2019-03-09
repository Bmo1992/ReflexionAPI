Function Remove-ReflexionUser
{
    <#
        .SYNOPSIS
          Remove a Reflexion mailbox.

        .DESCRIPTION
          Remove a Reflexion mailbox by specifying the unique Id of the user.  The user must be located under your enterprise or another enterprise that is a tenant of your enterprise (in the event that you have multiple tenants/customers under your enterprise).

        .PARAMETER UserId
          Specify the user Id of the specific user to be removed. This field is required.

        .EXAMPLE
          Remove-ReflexionUser -UserId 12345

          Removes the user with a user Id of 12345 from one of the enterprises your API user controls. 

        .NOTES
          NAME    : Remove-ReflexionUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : March 10, 2019
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$UserId
    )

    # Prompt for confirmation before deleting the user. If yes proceed to attempting to delete the user.
    $confirm_submission = Read-Host "Are you sure you want to delete $UserId [Y/N]?"
    if($confirm_submission -eq "Y")
    {
        Try
        {
            Invoke-WebRequest -Uri "https://api.reflexion.net/rfx-rest-api/users/$UserId" `
            -Method DELETE -Headers $reflexion_headers
        }
        Catch
        {
            Throw "Unable to connect to Reflexion or delete the user. Please confirm your auth token is valid and that the user exists"        
        }
    }
    elseif($confirm_submission -eq "N")
    {
        Write-Host "User $UserId was not deleted because you answered N."
    }
    else
    {
        Throw "Response not understood. Valid answers are 'Y' and 'N'. Please run again and use one of the accepted responses."
    }
}
