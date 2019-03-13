Function Set-ReflexionUser
{
    <#
        .SYNOPSIS
          Set the mailbox properties of an individual Reflexion user's mailbox.

        .DESCRIPTION

        .PARAMETER UserId
          Specify the Id of the user to be modified. 

        .PARAMETER AttachControlPanel
          Specify whether or not to attach the Reflexion control panel message to inbound messages by changing this setting to ON ($True) or OFF ($False).

        .PARAMETER AutoAotf
          

        .PARAMETER BlockBulkEmails
          Specify whether or not inbound bulk emails should be blocked by changing this setting to ON ($True) or OFF ($False).

        .PARAMETER OutlookFormatting
          Specify whether or not messages should be formatting specifically for Microsoft Outlook by changing this setting to ON ($True) or OFF ($False).

        .PARAMETER SecurityStatus
          Specify whether or not security should be enabled for this user by changing this setting to ON ($True) or OFF ($False).

        .PARAMETER SpoofingPrevention
          Specify whether or not to turn spoofing prevention on for the user by changing this setting to ON ($True) or OFF ($False).

        .EXAMPLE

        .NOTES
          NAME    : Set-ReflexionUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : March 13, 2019
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$UserId,
        [Parameter(
            Mandatory=$False
        )]
        [bool]$AttachControlPanel,
        [bool]$AutoAotf,
        [bool]$BlockBulkEmails,
        [bool]$OutlookFormatting,
        [bool]$SecurityStatus,
        [bool]$SpoofingPrevention    
    )

    $api_url = "https://api.reflexion.net/rfx-rest-api/"

    if($PSBoundParameters.ContainsKey('AttachControlPanel'))
    {
        if($AttachControlPanel)
        {
            Try
            {
                Write-Host "The AttachControlPanel setting for $UserId was set to $AttachControlPanel."
            }
            Catch
            {
                Throw "Couldn't set the AttachControlPanel option to $AttachControlPanel for $UserId. Please check connectivity and try again."
            }
        }
        elseif(-not $AttachControlPanel)
        {
            Try
            {
                Write-Host "The AttachControlPanel setting for $UserId was set to $AttachControlPanel."
            }
            Catch
            {
                Throw "Couldn't set the AttachControlPanel option to $AttachControlPanel for $UserId. Please check connectivity and try again."
            }
        }
        else
        {
            Throw "Answer not understood, accepted values for the AttachControlPanel property are `$True and `$False"
        }
    }
}
