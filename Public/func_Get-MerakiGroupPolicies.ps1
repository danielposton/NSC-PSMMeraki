function Get-MerakiGroupPolicies {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $Networks = (Get-MerakiNetworks)
    $ReturnObject = @()
    foreach ($network in $Networks) {
        $New = "" | Select-Object 'Network', 'name'
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
         Uri = "https://api.meraki.com/api/v1/networks/$($network.id)/groupPolicies"
        }
        $new.name = Invoke-RestMethod @Params
    }
    }
    $ReturnObject | Select-Object Network -ExpandProperty Name | Sort-Object -Property Network
}