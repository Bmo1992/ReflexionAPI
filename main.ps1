<#
  .SYNOPSIS

  .DESCRIPTION

  .PARAMETER ServiceKey

  .EXAMPLE

  .NOTES
    NAME    :  
    AUTHOR  : BMO
    EMAIL   : brandonseahorse@gmail.com
    GITHUB  : github.com/Bmo1992
    CREATED : January 26, 2019
#>
# Parameters, required includes the API service key
[CmdletBinding()]
Param
(
    [Parameter(
        Mandatory=$True
    )]
    [string]$ServiceKey
)

#### VARIABLES ####

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

ConnectTo-Reflexion -ServiceKey $ServiceKey
$auth_token
