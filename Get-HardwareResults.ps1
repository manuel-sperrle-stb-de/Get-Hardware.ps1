param (
    $DeviceManagementScriptId = (Get-Content .\DeviceManagementScriptId.env )
)

Connect-MSGraph
(Invoke-MSGraphRequest -HttpMethod GET -Url ('deviceManagement/deviceManagementScripts/{0}/deviceRunStates?$expand=managedDevice' -f $DeviceManagementScriptId) | Get-MSGraphAllPages | Where-Object -Property errorCode -EQ 0).resultMessage | ConvertFrom-Json