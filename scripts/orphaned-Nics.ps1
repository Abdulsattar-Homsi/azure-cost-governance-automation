Write-Host "Scanning for Orphaned Network Interfaces (NICs)..." -ForegroundColor Cyan
$nics = Get-AzNetworkInterface -ResourceGroupName "rg-cost-gov-lab"
$orphanedNics = $nics | Where-Object { $null -eq $_.VirtualMachine }

if ($orphanedNics) {
    Write-Host "Found $($orphanedNics.Count) orphaned NIC(s):" -ForegroundColor Yellow
    $orphanedNics | Format-Table Name, MacAddress, ProvisioningState, Location
} else {
    Write-Host "No orphaned NICs found." -ForegroundColor Green
}