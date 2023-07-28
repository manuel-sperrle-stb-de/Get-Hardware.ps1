$CimInstance = @{}
@('ComputerSystem','Bios','Processor','PhysicalMemory','LogicalDisk','VideoController','NetworkAdapterConfiguration') | ForEach-Object {
    ($CimInstance).$_ = Get-CimInstance ('Win32_{0}' -f $_) | Select-Object -Property * -ExcludeProperty Cim* | ConvertTo-Json -WarningAction SilentlyContinue -InformationAction SilentlyContinue | ConvertFrom-Json
}

[PSCustomObject]@{

    # flat
    TimeStamp = Get-Date -Format s
    Name = $CimInstance.ComputerSystem.Name
    SerialNumber = $CimInstance.Bios.SerialNumber

    # 1 object
    ComputerSystem = $CimInstance.ComputerSystem
    Bios = $CimInstance.Bios
    Processor = $CimInstance.Processor
    
    # array of objects
    PhysicalMemory = @($CimInstance.PhysicalMemory)
    LogicalDisk = @($CimInstance.LogicalDisk)
    VideoController = @($CimInstance.Videocontroller)
    NetworkAdapterConfiguration = @($CimInstance.NetworkAdapterConfiguration)

} | ConvertTo-Json -Depth 5 -Compress