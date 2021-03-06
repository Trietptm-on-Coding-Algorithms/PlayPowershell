<#
.SYNOPSIS
    This script enables then disables the SMTP port on a local system 
.DESCRIPTION
    This script first creates a FW object, then creates a port. The
    script then addes that port to the firewall rules. The script
    finally removes the port. The script also prints before/after
    results.
.NOTES
    File Name  : Enable-FWPort.ps1
	Author     : Thomas Lee - tfl@psp.co.uk
	Requires   : PowerShell Version 2.0
.LINK
    This script posted to:
	    http://www.pshscripts.blogspot.com
    MSDN Sample posted at:
	    http://msdn.microsoft.com/en-us/library/aa366425(VS.85).aspx
#>

## 
# Start of Script
## 

# Define Constants
$NET_FW_IP_PROTOCOL_UDP = 17
$NET_FW_IP_PROTOCOL_TCP = 6
$NET_FW_SCOPE_ALL = 0

# Create FW objecct
$fwMgr = new-object -com HNetCfg.FwMgr

# Get current profile
$profile = $fwMgr.LocalPolicy.CurrentProfile

# Display ports open:
$profile.GloballyOpenPorts | ft name,port,enabled -auto

# Create Port object
$port = New-Object -com HNetCfg.FWOpenPort
$port.Name = "SMTP"
$port.Port = 25
$port.Protocol = $NET_FW_IP_PROTOCOL_TCP
$port.Scope = $NET_FW_SCOPE_ALL

# Enable the port
$port.Enabled = $True
$profile.GloballyOpenPorts.Add($port)

# Display results
$profile.GloballyOpenPorts | ft name,port,enabled -auto

# now remove the port
$profile.GloballyOpenPorts.remove($port.port,$NET_FW_IP_PROTOCOL_TCP)

# Display results
$profile.GloballyOpenPorts | ft name,port,enabled -auto
# End of script