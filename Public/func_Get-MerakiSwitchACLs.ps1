function Get-MerakiSwitchACLS {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $OrganizationID = (Get-MerakiOrganization).id
    $Networks = (Get-MerakiNetworks)   

    foreach ($network in $Networks) {
        $Params = @{
            ContentType = 'application/json'
            Headers = @{
            'X-Cisco-Meraki-API-Key' = $token
            'Accept' = "application/json" 
            }
            Method = 'GET'
            Uri = "https://api.meraki.com/api/v1/organizations/$($OrganizationID)/networks/$($network.id)/switch/accessControlLists"
        }
        Invoke-RestMethod @Params       
    }
}