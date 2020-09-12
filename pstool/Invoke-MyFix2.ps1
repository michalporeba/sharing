function Invoke-MyFix {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$Environment = "*", 
        [Parameter()]
        [String[]]$ServerName = "*",
        [Parameter()]
        [switch]$Fix = $false
    )

    $location = "./TestData"

    $Servers = @(
        @{Environment = "Dev"; Name = "Server10"}
        @{Environment = "Dev"; Name = "Server11"}
        @{Environment = "Dev"; Name = "Server12"}
        @{Environment = "Test"; Name = "Server20"}
        @{Environment = "Test"; Name = "Server21"}
        @{Environment = "Test"; Name = "Server22"}
        @{Environment = "Prod"; Name = "Server31"}
        @{Environment = "Prod"; Name = "Server32"}
        @{Environment = "Prod"; Name = "Server33"}
        @{Environment = "Prod"; Name = "Server34"}
        @{Environment = "Prod"; Name = "Server35"}
    ) | Where-Object { 
        $psitem.Environment -like $Environment -and `
        $psitem.Name -like $ServerName
    }
    
    @($Servers) | ForEach-Object {
        Write-Host "Checking $($psitem.Name) in $($psitem.Environment)"
        $Server = $psitem

        #convert data to a specific path where the file representing server should be
        $path = Join-Path $location $Server.Environment "$($Server.Name).txt"

        if (!(Test-Path -Path $path)) {
            if ($fix) {
                Write-Host "  Cannot connect"
                New-Item -Path $path -ItemType File | Out-Null
            } else { 
                Write-Host "  Missing!"
            }
        } else {
            Write-Host "  OK. It is not missing."
        }
    
        if ((Test-Path -Path $path)) {
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
        } else {
            Write-Host "  Inconclusive check."
        }
    
        if ((Test-Path -Path $path) -and (Get-Content -Path $path | Measure-Object -Line).Lines -gt 3) {
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

Invoke-MyFix -Environment Prod -Server Server32
Invoke-MyFix -Environment Test -Server Server22
Invoke-MyFix -Environment Dev
    
# what if we wanted to add exception handling?
# | Out-ConsoleGridView
# try OGV (Micrisoft.PowerShell.GraphicalTools)
