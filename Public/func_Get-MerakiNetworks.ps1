function Get-MerakiNetworks {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)
    $OrganizationID = (Get-MerakiOrganization).id
       
    $Params = @{
        ContentType = 'application/json'
        Headers = @{
        'X-Cisco-Meraki-API-Key' = $token
        'Accept' = "application/json" 
        }
        Method = 'GET'
        Uri = "https://api.meraki.com/api/v1/organizations/$($OrganizationID)/networks"
    }
       Invoke-RestMethod @Params       
}