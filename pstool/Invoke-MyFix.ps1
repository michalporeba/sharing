function Invoke-MyFix {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$Location, 
        [Parameter()]
        [String[]]$File,
        [Parameter()]
        [switch]$Fix
    )

    
    @($file) | ForEach-Object {
        Write-Host "Checking $psitem"
        $path = Join-Path $location "$psitem.txt"

        if (!(Test-Path -Path $path)) {
            if ($fix) {
                Write-Host "  Missing. Creating."
                New-Item -Path $path -ItemType File | Out-Null
            } else { 
                Write-Host "  Missing!"
            }
        } else {
            Write-Host "  OK. It is not missing."
        }

        if (!(Get-Content -Path $path)) {
            if ($fix) {
                Write-Host "  Is empty. Setting the default value."
                Set-Content -Path $path -Value "OK"
            } else {
                Write-Host "  Is empty!"
            }
        } else {
            Write-Host "  OK. It is not empty."
        }

        if ((Get-Content -Path $path | Measure-Object -Line).Lines -gt 3) {
            if ($fix) {
                Write-Host "  Too long. Making it shorter." 
                $content = Get-Content -Path $path -Tail 3 
                Set-Content -Path $path -Value $content
            } else { 
                Write-Host "  Too long!" 
            }
        } else {
            Write-Host "  OK. It is not too long."
        }
    }

}


Invoke-MyFix -Location "./TestLocation" -File "server2","server3" -Fix:$false
Invoke-MyFix -Location "./TestLocation2" -File "server5" -Fix:$false
    


    # what if we wanted to add exception handling?
    # | Out-ConsoleGridView
    # try OGV (Micrisoft.PowerShell.GraphicalTools)
