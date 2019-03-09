Function Remove-ReflexionUser
{
    <#
        .SYNOPSIS
          Remove a Reflexion mailbox.

        .DESCRIPTION
          Remove a Reflexion mailbox by specifying the enterprise Id of the customer or primary account. To remove a user the primary smtp address of the specific user is required. 

        .PARAMETER EnterpriseId
          Specify the enterprise Id of the specific customer under which the user to be removed is located. This field is required.

        .PARAMETER PrimaryAddress
          Specify the primary address of the specific user to be removed.

        .EXAMPLE
          Remove-ReflexionUser -EnterpriseId 12345 -PrimaryAddress "jdoe@bigcompany.com"

          Removes the user with a primary smtp address of jdoe@bigcompany.com from the enterprise with an Id of 12345.

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
        [int]$EnterpriseId,
        [string]$PrimaryAddress
    )

    $confirm_submission = Read-Host "Are you sure you want to remove $PrimaryAddress from enterprise $EnterpriseId [Y/N]?"
    if($confirm_submission -eq "Y")
    {
        Try
        {
            Invoke-WebRequest -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$EnterpriseId/users" `
            -Method DELETE -Body ($PrimaryAddress | ConvertTo-Json) -Headers $reflexion_headers
        }
        Catch
        {
            Throw "Unable to connect to Reflexion or delete the user. Please confirm your auth token is valid and that the user exists"        
        }
    }
    elseif($confirm_submission -eq "N")
    {
        Write-Host "User $PrimaryAddress was not deleted because you answered N."
    }
    else
    {
        Throw "Response not understood. Valid answers are 'Y' and 'N'. Please run again and use one of the accepted responses."
    }
}
