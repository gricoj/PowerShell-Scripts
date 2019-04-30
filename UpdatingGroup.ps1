function Update-Group {
    param ([Parameter(Mandatory = $true)][string]$Group, [Parameter(Mandatory = $true)][array]$UpdatedUsers)
    
    $CurrentUsersInGroup = @()
    $CurrentUsersInGroup += (Get-ADGroupMember $Group).name

    foreach($User in $UpdatedUsers){
        if($CurrentUsersInGroup -notcontains $User){
            Add-ADGroupMember -Identity $Group -Members $User -Confirm:$false
            Write-Host $User " has been added to " $Group
        }
     }

    
    foreach($User in $CurrentUsersInGroup){
        if($UpdatedUsers -notcontains $User){
            Remove-ADGroupMember -Identity $Group -Members $User -Confirm:$false
            Write-Host $User " has been removed from " $Group
        }
     }

 }
 
function Update-GroupCSV {
    param ([Parameter(Mandatory = $true)][string]$Path, [Parameter(Mandatory = $true)][string]$Header, [Parameter(Mandatory = $true)][string]$Group)
    $UpdatedUsers = @()
    $UpdatedUsers += (Import-Csv $Path).$Header
    Update-Group -Group $Group -UpdatedUsers $UpdatedUsers
    }

function Update-GroupTXT {
    param ([Parameter(Mandatory = $true)][string]$Path, [Parameter(Mandatory = $true)][string]$Group)
    $UpdatedUsers = @()
    $UpdatedUsers += Get-Content $Path
    Update-Group -Group $Group -UpdatedUsers $UpdatedUsers
    }
