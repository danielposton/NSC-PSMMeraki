function Get-MerakiVLANS {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $Networks = (Get-MerakiNetworks)   

    foreach ($network in $Networks) {
        $Params = @{
            ContentType = 'application/json'
            Headers = @{
            'X-Cisco-Meraki-API-Key' = $token
            'Accept' = "application/json" 
            }
            Method = 'GET'
            Uri = "https://api.meraki.com/api/v1/networks/$($network.id)/appliance/vlans"
        }
        Invoke-RestMethod @Params       
    }
}