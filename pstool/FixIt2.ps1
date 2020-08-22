$location = "./TestLocation"
$file = "server2","server3"
$fix = $false

@($file) | ForEach-Object {
    Write-Host "Checking $psitem"
    $path = Join-Path $location "$psitem.txt"

    if (!(Test-Path -Path $path)) {
        Write-Host "  Missing. Creating."
        New-Item -Path $path -ItemType File | Out-Null
    } else {
        Write-Host "  OK. It is not missing."
    }

    if (!(Get-Content -Path $path)) {
        Write-Host "  Is empty. Setting the default value."
        Set-Content -Path $path -Value "OK"
    } else {
        Write-Host "  OK. It is not empty."
    }

    if ((Get-Content -Path $path | Measure-Object -Line).Lines -gt 3) {
        Write-Host "  Too long. Making it shorter."
        $content = Get-Content -Path $path -Tail 3 
        Set-Content -Path $path -Value $content
    } else {
        Write-Host "  OK. It is not too long."
    }
}
