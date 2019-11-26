$ComputerName = $env:computername
$DateAndTime = Get-Date -Format g
$Model = (Get-WmiObject -Class Win32_ComputerSystem).Model
$Manufacturer = (Get-WmiObject -Class Win32_BIOS).Manufacturer
$SN = (Get-WmiObject win32_bios).SerialNumber
$MacAddress = Get-NetAdapter -Name Ethernet | Select MacAddress
$MacAddress = $MacAddress.MacAddress

#Getting OU of the local computer
$ADSISearcher = New-Object System.DirectoryServices.DirectorySearcher;
$ADSISearcher.Filter = '(&(name=' + $ComputerName + ')(objectClass=computer))';
$ADSISearcher.SearchScope = 'Subtree';
$Computer = $ADSISearcher.FindAll();

$OU = $($Computer.Properties.Item('distinguishedName')).Substring($($Computer.Properties.Item('distinguishedName')).IndexOf('OU='))


$uri = "WEBHOOK URL"
$body = ConvertTo-JSON @{
    title ="Task Sequence Completed on $ComputerName"
    text = "`n
    Time Completed:  $DateAndTime `n
    Computer Name: $ComputerName  `n
    MAC Address: $MacAddress `n
    Manufacturer: $Manufacturer   `n
    Computer Model: $Model        `n
    Serial Number: $SN            `n
    OU: $OU        
    "
}

Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'
