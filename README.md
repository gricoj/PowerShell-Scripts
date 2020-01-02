# PowerShell-Scripts

### [GiveEveryonePermissionToFileFolder.ps1](https://github.com/gricoj/PowerShell-Scripts/blob/master/GiveEveryonePermissionToFileFolder.ps1)
The purpose of this script is to give *Everyone* the *Full Control* permission to a file or folder. 

Granting *Everyone* the *Full Control* permission was needed because certain applications needed said permissions on certain folders inorder for the application to work correctly.

The script was created to skip the manual task of having to browse for the file/folder and having to change it's permissions.

### [FileSharePermissions.ps1](https://github.com/gricoj/PowerShell-Scripts/blob/master/FileSharePermissions.ps1)
This script was utilized to find out which users and security groups had access to what folders on our file server (NTFS Permissions)

The script returns a CSV with all the folders and subfolders and their respective NTFS permissions.

### [UninstallInternetExplorer.ps1](https://github.com/gricoj/PowerShell-Scripts/blob/master/UninstallInternetExplorer.ps1)
Simple one-line script used to Disable/Remove Internet Explorer 11. 

This script was used as a step in a SCCM task sequence to remove Internet Explorer from computers running Windows 10 LTSB/LTSC, so that no internet browesers were on the computer.


