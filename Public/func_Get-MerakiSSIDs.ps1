function Get-MerakiSSIDs {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $Networks = (Get-MerakiNetworks)
    $ReturnObject = @()
    foreach ($network in $Networks) {
        $New = "" | Select-Object 'Network', 'SSIDs'
        $ReturnObject += $New
        $new.Network = $network.Name
        if ($network.productTypes -contains @('wireless')) {
        $Params = @{
         ContentType = 'application/json'
         Headers = @{
         'X-Cisco-Meraki-API-Key' = $token
         'Accept' = "application/json" 
         }
         Method = 'GET'
         Uri = "https://api.meraki.com/api/v1/networks/$($network.id)/wireless/ssids"
        }
        $new.SSIDs = Invoke-RestMethod @Params
    }
    }
    $ReturnObject | Select-Object Network -ExpandProperty SSIDs | Where-Object name -eq "NewSpring-Staff" | Sort-Object -Property Network
}