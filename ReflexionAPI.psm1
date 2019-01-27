<#
  .DESCRIPTION
    Powershell module for interacting with the Reflexion API in order to automate management and auditing of Reflexion users and tenants.

  .NOTES
    NAME    : ReflexionAPI
    AUTHOR  : BMO
    EMAIL   : brandonseahorse@gmail.com
    GITHUB  : github.com/Bmo1992
    CREATED : January 26, 2019
#>

# Get the script functions
$Functions = @(Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue)

# Try to load each function by dot sourcing state send sourcing failures to stderr
ForEach ($script_function in $Functions)
{
    Try
    {
        . $script_function.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($script_function.fullname): $_"
    }
}
