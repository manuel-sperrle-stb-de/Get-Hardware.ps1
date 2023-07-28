$CimInstance = @{}
@('ComputerSystem', 'Bios', 'Processor', 'PhysicalMemory', 'LogicalDisk', 'VideoController', 'NetworkAdapterConfiguration') | ForEach-Object {
    ($CimInstance).$_ = Get-CimInstance ('Win32_{0}' -f $_) | Select-Object -Property * -ExcludeProperty Cim* | ConvertTo-Json -WarningAction SilentlyContinue -InformationAction SilentlyContinue | ConvertFrom-Json
}

[PSCustomObject]@{

    # flat
    TimeStamp                   = Get-Date -Format s
    Name                        = $CimInstance.ComputerSystem.Name
    SerialNumber                = $CimInstance.Bios.SerialNumber

    # 1 object
    ComputerSystem              = $CimInstance.ComputerSystem

    Bios                        = $CimInstance.Bios | Select-Object @(
        'Name'
        'Manufacturer'
        'Version'
        'SerialNumber'
        'SMBIOSBIOSVersion'
    ) 

    Processor                   = @(
        $CimInstance.Processor | Select-Object @(
            'Name'
            'DeviceID'
            'Manufacturer'
            'SocketDesignation'
            'NumberOfCores'
            'NumberOfLogicalProcessors'
            'MaxClockSpeed'
            'L2CacheSize'
            'L3CacheSize'
        )
    )
    
    PhysicalMemory              = @(
        $CimInstance.PhysicalMemory | Select-Object @(
            'PartNumber'
            'Manufacturer'
            'BankLabel'
            'Capacity'
            'Speed'
            'FormFactor'
        )
    )

    LogicalDisk                 = @(
        $CimInstance.LogicalDisk | Select-Object @(
            'DeviceID'
            'DriveType'
            'MediaType'
            'VolumeName'
            'VolumeSerialNumber'
            'Size'
            'FreeSpace'
            'FileSystem'
            'MaximumComponentLength'
        )
    )

    VideoController             = @(
        $CimInstance.Videocontroller | Select-Object @(
            'Name' 
            'PNPDeviceID'
            'VideoProcessor'
            'AdapterRAM'
            'InstalledDisplayDrivers'
            'DriverDate'
            'DriverVersion'
        )
    )

    NetworkAdapterConfiguration = @(
        $CimInstance.NetworkAdapterConfiguration | Select-Object @(
            'Index'
            'ServiceName'
            'DHCPEnabled'
            'Description'
            'MACAddress'
            'IPEnabled'
            'DHCPServer'
            'DHCPDomain'
            'IPAddress'
            'DefaultIPGateway'
        )
    )

} | ConvertTo-Json -Depth 5 -Compress