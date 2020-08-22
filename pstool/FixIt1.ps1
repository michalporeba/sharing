$location = "./TestLocation"
$file = "server3"

$path = Join-Path $location "$file.txt"

if (!(Test-Path -Path $path)) {
    Write-Host "Missing $file"
    New-Item -Path $path -ItemType File | Out-Null
} else {
    Write-Host "OK. $file is not missing"
}

if (!(Get-Content -Path $path)) {
    Write-Host "File $file is empty"
    Set-Content -Path $path -Value "OK"
} else {
    Write-Host "OK. $file is not empty"
}

if ((Get-Content -Path $path | Measure-Object -Line).Lines -gt 3) {
    Write-Host "File $file is too long"
    $content = Get-Content -Path $path -Tail 3 
    Set-Content -Path $path -Value $content
} else {
    Write-Host "OK. $file is not too long."
}
