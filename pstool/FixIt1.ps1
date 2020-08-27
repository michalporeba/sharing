$location = "./TestData"
$environment = "Prod"
$server = "Server10"

#convert data to a specific path where the file representing server should be
$path = Join-Path $location $environment "$server.txt"

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
