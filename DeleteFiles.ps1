Write-Host "Script running from " $PSScriptRoot

$machinesFilePath = "$PSScriptRoot\Machines.txt"
$pathsToDeleteFilePath = "$PSScriptRoot\PathsToDelete.txt"

Write-Host $machinesFilePath
Write-Host $pathsToDeleteFilePath

if (!(Test-Path $machinesFilePath))
{
    $errormessage = $machinesFilePath + " not found. Exiting"
    Write-Error $errormessage
    Exit 1
}

if (!(Test-Path $pathsToDeleteFilePath))
{
    $errormessage = $pathsToDeleteFilePath + " not found. Exiting"
    Write-Error $errormessage
    Exit 1
}

$machines= Get-Content -Path $machinesFilePath
$paths= Get-Content -Path $pathsToDeleteFilePath  

foreach ($machine in $machines) 
{    
    Write-Host "Removing items on machine " $machine
    foreach ($path in $paths) 
    {
        $fullPath = "\\$machine\" + $path.Replace(":","$")
        
        if (Test-Path $fullPath)
        {
            Write-Host "Removing item " $fullPath
            Remove-Item -Path $fullPath -Force -Recurse
        }
        else
        {
            Write-Host "Path not found " $fullPath
        }
    }
    Write-Host "Removed items on machine " $machine "successfully"
}