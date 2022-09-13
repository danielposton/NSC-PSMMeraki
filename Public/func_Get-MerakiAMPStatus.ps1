function Get-MerakiAMPStatus {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $Networks = (Get-MerakiNetworks)
    $ReturnObject = @()
    foreach ($network in $Networks) {
        $New = "" | Select-Object 'Network', 'Mode'
        $ReturnObject += $New
        $new.Network = $network.Name
        if ($network.productTypes -contains @('appliance')) {
        $Params = @{
         ContentType = 'application/json'
         Headers = @{
         'X-Cisco-Meraki-API-Key' = $token
         'Accept' = "application/json" 
         }
         Method = 'GET'
         Uri = "https://api.meraki.com/api/v1/networks/$($network.id)/appliance/security/malware"
        }
        $new.Mode = Invoke-RestMethod @Params
    }
    }
    $ReturnObject | Select-Object Network -ExpandProperty Mode | Select-Object Network, mode | Sort-Object -Property Network
}