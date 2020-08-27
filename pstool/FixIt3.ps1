$location = "./TestData"
$environment = "Prod"
$server = "Server32","server33"
$fix = $false

@($server) | ForEach-Object {
    Write-Host "Checking $psitem"

    #convert data to a specific path where the file representing server should be
    $path = Join-Path $location $environment "$psitem.txt"

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

    ###
    if (!(Test-Path -Path $path)) {
        Write-Host "Cannot connect to $server"
        New-Item -Path $path -ItemType File | Out-Null
    } else {
        Write-Host "OK. $file is available."
    }

    if (!(Get-Content -Path $path)) {
        Write-Host "$server has no data"
        Set-Content -Path $path -Value "OK"
    } else {
        Write-Host "OK. $server has some data."
    }

    if ((Get-Content -Path $path | Measure-Object -Line).Lines -gt 3) {
        Write-Host "$server has too much data"
        $content = Get-Content -Path $path -Tail 3 
        Set-Content -Path $path -Value $content
    } else {
        Write-Host "OK. $server has too much data."
    }
}



# what if we wanted to add exception handling?
# | Out-ConsoleGridView
# try OGV (Micrisoft.PowerShell.GraphicalTools)
# how about a single type of an error? 
