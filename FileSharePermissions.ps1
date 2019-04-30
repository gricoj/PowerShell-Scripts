$AllFolders = Get-ChildItem -Directory -Path "Path" -Recurse -Force
$Results = @()
Foreach ($Folder in $AllFolders){
    $acl = Get-Acl -Path $folder.FullName
    foreach ($Access in $acl.Access) { 
        if ($Access.IdentityReference -notlike "BUILTIN\Administrators" -and $Access.IdentityReference -notlike "domain\Domain Admins" -and $Access.IdentityReference -notlike "CREATOR OWNER" -and $access.IdentityReference -notlike "NT AUTHORITY\SYSTEM" -and $Access.IdentityReference -notlike "AD\gg-vcsa-IT-Admins" -and $Access.IdentityReference -notlike "AD\groupname" -and $Access.IdentityReference -notlike "AD\username") {
            $Properties = [ordered]@{'FolderName'=$Folder.FullName;'AD Group'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
            $Results += New-Object -TypeName PSObject -Property $Properties
        }
    }
}
$Results | Export-Csv -path "Path"
