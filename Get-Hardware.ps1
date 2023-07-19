[PSCustomObject]@{

    TimeStamp = Get-Date -Format s

    Bios = Get-CimInstance Win32_Bios | Select-Object @(
        'Name'
        'Manufacturer'
        'Version'
        'SerialNumber'
        'SMBIOSBIOSVersion'
    )

    Processor = Get-CimInstance Win32_Processor | Select-Object @(
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
    
    PhysicalMemory = Get-CimInstance Win32_PhysicalMemory | Select-Object @(
        'PartNumber'
        'Manufacturer'
        'BankLabel'
        'Capacity'
        'Speed'
        'FormFactor'
    )

    LogicalDisk = Get-CimInstance Win32_LogicalDisk | Select-Object @(
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

    VideoController = Get-CimInstance Win32_Videocontroller | Select-Object @(
        'Name' 
        'PNPDeviceID'
        'VideoProcessor'
        'AdapterRAM'
        'InstalledDisplayDrivers'
        'DriverDate'
        'DriverVersion'
    )

    NetworkAdapterConfiguration = Get-CimInstance Win32_NetworkAdapterConfiguration | Select-Object @(
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

} | ConvertTo-Json -Depth 3 -Compress