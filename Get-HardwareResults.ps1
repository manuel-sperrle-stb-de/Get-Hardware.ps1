#Requires -Modules @{ ModuleName='Microsoft.Graph.Intune'; RequiredVersion='6.1907.1.0'; }

param (
    $DeviceManagementScriptId = (Get-Content (Join-Path $PSScriptRoot 'DeviceManagementScriptId.env') )
)

Update-MSGraphEnvironment -SchemaVersion 'beta' | Write-Host
Connect-MSGraph | Write-Host

Invoke-MSGraphRequest -HttpMethod GET -Url ('deviceManagement/deviceManagementScripts/{0}/deviceRunStates?$expand=managedDevice' -f $DeviceManagementScriptId ) `
| Get-MSGraphAllPages `
| Where-Object -Property errorCode -EQ 0 `
| Select-Object -ExpandProperty resultMessage `
| ConvertFrom-Json