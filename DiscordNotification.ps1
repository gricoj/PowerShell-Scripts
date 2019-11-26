$ComputerName = $env:computername
$DateAndTime = Get-Date -Format g
$Model = (Get-WmiObject -Class Win32_ComputerSystem).Model
$Manufacturer = (Get-WmiObject -Class Win32_BIOS).Manufacturer
$SN = (Get-WmiObject win32_bios).SerialNumber
$MacAddress = Get-NetAdapter -Name Ethernet | Select MacAddress

#Getting OU of the local computer
$ADSISearcher = New-Object System.DirectoryServices.DirectorySearcher;
$ADSISearcher.Filter = '(&(name=' + $ComputerName + ')(objectClass=computer))';
$ADSISearcher.SearchScope = 'Subtree';
$Computer = $ADSISearcher.FindAll();

$OU = $($Computer.Properties.Item('distinguishedName')).Substring($($Computer.Properties.Item('distinguishedName')).IndexOf('OU='))



#Sending the message
$url = "WEBHOOK URL"
$content = @"
#<@&......> You can get the role ID by typing \@RoleName
__**Task Sequence completed**__
**Time Completed:** $DateAndTime
**Computer Name:** $ComputerName
**MAC Address:** $MacAddress
**Manufacturer:** $Manufacturer
**Computer Model:** $Model
**Serial Number:** $SN
**OU:** $OU
"@
$payload = [PSCustomObject]@{
    content = $content
    }
Invoke-RestMethod -Uri $url -Method Post -Body ($payload | ConvertTo-Json)
