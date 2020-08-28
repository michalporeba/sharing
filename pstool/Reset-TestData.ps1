$root = "./TestData"

if (Test-Path -Path $root) {
    Remove-Item -Path $root -Recurse
}

New-Item -Path "$root/Dev" -ItemType directory -Force
New-Item -Path "$root/Dev/Server10.txt" -ItemType file
Set-Content -Path "$root/Dev/Server10.txt" -Value "OK"
New-Item -Path "$root/Dev/Server11.txt" -ItemType file
Set-Content -Path "$root/Dev/Server11.txt" -Value "OK"
New-Item -Path "$root/Dev/Server12.txt" -ItemType file
Set-Content -Path "$root/Dev/Server12.txt" -Value "OK"

New-Item -Path "$root/Test" -ItemType directory -Force
New-Item -Path "$root/Test/Server20.txt" -ItemType file
New-Item -Path "$root/Test/Server22.txt" -ItemType file
Add-Content -Path "$root/Test/Server22.txt" -Value "line1"
Add-Content -Path "$root/Test/Server22.txt" -Value "line2"
Add-Content -Path "$root/Test/Server22.txt" -Value "line3"
Add-Content -Path "$root/Test/Server22.txt" -Value "line4"

New-Item -Path "$root/Prod" -ItemType directory -Force
New-Item -Path "$root/Prod/Server31.txt" -ItemType file
Set-Content -Path "$root/Prod/Server31.txt" -Value "OK"
New-Item -Path "$root/Prod/Server32.txt" -ItemType file
New-Item -Path "$root/Prod/Server33.txt" -ItemType file
Set-Content -Path "$root/Prod/Server33.txt" -Value "OK"
New-Item -Path "$root/Prod/Server35.txt" -ItemType file
Add-Content -Path "$root/Prod/Server35.txt" -Value "line1"
Add-Content -Path "$root/Prod/Server35.txt" -Value "line2"
Add-Content -Path "$root/Prod/Server35.txt" -Value "line3"
Add-Content -Path "$root/Prod/Server35.txt" -Value "line4"
