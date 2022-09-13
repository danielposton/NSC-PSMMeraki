function Get-MerakiOrganization {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "nsc-inf-kv" -Name "MerakiAPI" -AsPlainText)

       
    $Params = @{
        ContentType = 'application/json'
        Headers = @{
        'X-Cisco-Meraki-API-Key' = $token
        'Accept' = "application/json" 
        }
        Method = 'GET'
        Uri = "https://api.meraki.com/api/v1/organizations"
    }
        Invoke-RestMethod @Params
        
}