Function Add-ReflexionUser
{
    <#
        .SYNOPSIS
          Create a new user under an enterprise.

        .DESCRIPTION
          Create a new user under an enterprise by specifying the new user's name and primary address.  For accounts with multiple tenants the enterprise Id of the specific tenant to create the new user under is required.

        .PARAMETER Name
          Specify the name of the new Reflexion user.

        .PARAMETER PrimaryAddress
          Specify the primary smtp address of the user to be created.

        .PARAMETER EnterpriseId
          Specify the enterprise Id of the enterprise the user is to be created under.

        .EXAMPLE
          Add-ReflexionUser -Name "John Doe" -PrimaryAddress "jdoe@bigcompany.com" -EnterpriseId 12345

          Creates a new Reflexion mailbox with the name 'John Doe' and a primary smtp address of 'jdoe@bigcompany.com' under the enterprise with the ID of 12345. 

        .NOTES
          NAME    : Add-ReflexionUser
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : March 8, 2019 
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$Name,
        [string]$PrimaryAddress,
        [string]$EnterpriseId
    )

    $new_user = @{
        "name" = $Name;
        "primaryAddress" = $PrimaryAddress
    }

    Try
    {
        Invoke-WebRequest -Uri "https://api.reflexion.net/rfx-rest-api/enterprises/$EnterpriseId/users" -Method POST `
        -Body ($new_user | ConvertTo-Json) -Headers $reflexion_headers
    }
    Catch
    {
        Throw "Unable to connect to Reflexion or create the new user.  Please confirm that youre authenticated to the Reflexion API and that the user name or enterprise id does not already exist in Reflexion and try again"
    }
}
