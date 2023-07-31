Get-ChildItem $PSScriptRoot -File -Filter '*.Function.ps1' | ForEach-Object {
    $_.BaseName.TrimEnd('.Function')
    . $_.FullName
}
Get-HardwareResults | ConvertTo-Json -Depth 5 | Out-File '.\Get-Hardware.json'