Write-Host "Scanning for Unattached Managed Disks..." -ForegroundColor Cyan
$disks = Get-AzDisk -ResourceGroupName "rg-cost-gov-lab"
$unattachedDisks = $disks | Where-Object { $_.DiskState -eq 'Unattached' }

if ($unattachedDisks) {
    Write-Host "Found $($unattachedDisks.Count) unattached disk(s):" -ForegroundColor Yellow
    $unattachedDisks | Format-Table Name, DiskSizeGB, SkuName, DiskState, Location
} else {
    Write-Host "No unattached disks found." -ForegroundColor Green
}