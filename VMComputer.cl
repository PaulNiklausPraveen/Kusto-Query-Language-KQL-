
#Gets the Virtual Machine data. Run this query in Azure Workspace Analytics

#Get VM data
VMComputer
| project  Computer,DisplayName,DnsNames,Ipv4Addresses,OperatingSystemFamily,Cpus,AzureResourceGroup,AzureSize


#Get Operating system details
VMComputer
| summarize by Computer, OperatingSystemFamily, OperatingSystemFullName


#KQL Query to get the Azure VM Server properties 
VMComputer
| summarize by Computer, AzureSize, Cpus,PhysicalMemoryMB,OperatingSystemFullName

#KQL Query to get  IPv4 Address, IPv4 Default Gateway, and IPv4 Subnet Mask of the VM

VMComputer
| summarize by Computer, tostring(Ipv4Addresses), tostring(Ipv4DefaultGateways), tostring(Ipv4SubnetMasks)

//Get Disk space details,
  
InsightsMetrics
| where Namespace == "LogicalDisk"
| extend Tags = todynamic(Tags)
| extend Drive = tostring(Tags["vm.azm.ms/mountId"])
| extend diskSizeGB = Tags["vm.azm.ms/diskSizeMB"]/1024.0
| summarize avg_FreeSpacePercentage = avgif(Val, Name == 'FreeSpacePercentage'),avg_FreeSpaceGB = avgif(Val, Name == 'FreeSpaceMB') /1024,take_any(diskSizeGB) by Computer, Drive

// Or use these below query

InsightsMetrics
| where Origin == "vm.azm.ms"
 and Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
| extend Disk=tostring(todynamic(Tags)["vm.azm.ms/mountId"])
| summarize Disk_Free_Space = avg(Val) by Computer, Disk, _ResourceId
| project Computer, Disk, Disk_Free_Space


//Get Process in a particual vm
VMProcess
| where Computer contains "VM1"

// KQL Query to get the VMProcess Executable Name and its Display Name and Group
VMProcess
| project ExecutableName, DisplayName, Group, ProductName 




  
