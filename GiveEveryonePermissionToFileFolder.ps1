$Path = "Path"
$Acl = (Get-Item $Path).GetAccessControl('Access')
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl -path $Path -AclObject $Acl
((Get-Item $Path).GetAccessControl('Access')).Access


