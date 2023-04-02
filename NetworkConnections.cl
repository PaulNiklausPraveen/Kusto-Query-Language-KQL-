
//Get Traffic from all the Virtual Machines in Azure

VMConnection 
| summarize by Computer, ProcessName, SourceIp, DestinationIp, DestinationPort, Protocol


//  Monitor Traffic from a particular Virtual Machine
VMConnection
| where TimeGenerated > ago(1h)
| summarize by Computer, ProcessName, SourceIp, DestinationIp, DestinationPort, Protocol
| where Computer has "VM1"
  
  
// Monitor Traffic for Inbound connections of a VM for 1day
VMConnection
| where TimeGenerated > ago(1d)
| where Direction has "Inbound"
| summarize by Computer,ProcessName,Direction,SourceIp,DestinationIp,DestinationPort,Protocol
| where Computer has "VM1"
  
  
//Monitor Traffic for Outbound connections of a VM for 1day
VMConnection
| where TimeGenerated > ago(1d)
| where Direction has "Outbound"
| summarize by Computer,ProcessName,Direction,SourceIp,DestinationIp,DestinationPort,Protocol
| where Computer has "VM1"
  
  
// Monitor Traffic for both inbound and outbound connections of a VM for 1day
VMConnection
| where TimeGenerated > ago(1h)
| where Direction has "Inbound" or Direction has "Outbound"
| summarize by Computer,ProcessName,Direction,SourceIp,DestinationIp,DestinationPort,Protocol
| where Computer has "VM1"
  
 
  

