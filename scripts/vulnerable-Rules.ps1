Write-Host "Scanning for Vulnerable NSG Inbound Rules..." -ForegroundColor Cyan
$nsgs = Get-AzNetworkSecurityGroup -ResourceGroupName "rg-cost-gov-lab"

foreach ($nsg in $nsgs) {
    $vulnerableRules = $nsg.SecurityRules | Where-Object {
        $_.Direction -eq 'Inbound' -and
        $_.Access -eq 'Allow' -and
        $_.SourceAddressPrefix -match '^\*$|^Internet$' -and
        ($_.DestinationPortRange -match '3389|22|\*')
    }

    if ($vulnerableRules) {
        Write-Host "SECURITY RISK FOUND in NSG: $($nsg.Name)" -ForegroundColor Red
        $vulnerableRules | Format-Table Name, SourceAddressPrefix, DestinationPortRange, Access, Priority
    }
}