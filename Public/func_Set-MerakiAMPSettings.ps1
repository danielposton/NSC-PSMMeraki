function Set-MerakiAMPSettings {    
    
    [CmdletBinding()]
    
    $token = (Get-AzKeyVaultSecret -VaultName "p26tkv" -Name "MerakiAPI" -AsPlainText)
    $Networks = (Get-MerakiNetworks)
    $Data = @"
    {
        "mode": "enabled",
        "allowedUrls": [
            {
                "url": "http://appldnld.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://suconfig.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://swdownload.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://swcdn.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://mesu.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://itunes.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://phobos.itunes-apple.com.akadns.net/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://gateway.push-apple.com.akadns.net/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://ax.itunes.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://phobos.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://albert.gcsis-apple.com.akadns.net/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://ax.init.itunes.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://init.itunes.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://oscp.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://deploy.static.akamaitechnologies.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://itunes.apple.com.edgekey.net/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://swquery.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://swscan.apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://aaplimg.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://updates-http.cdn-apple.com/*",
                "comment": "Apple Updates"
            },
            {
                "url": "http://microsoft.com/*",
                "comment": "Windows Updates"
            },
            {
                "url": "http://update.microsoft.com/*",
                "comment": "Windows Updates"
            },
            {
                "url": "http://windowsupdates.microsoft.com/*",
                "comment": "Windows Updates"
            },
            {
                "url": "http://windowsupdate.com/*",
                "comment": "Windows Updates"
            }
        ],
        "allowedFiles": []
        }
"@
    $Body = $Data
    foreach ($network in $Networks) {
        if ($network.name -ne 'AZR') {
        $Params = @{
            Body = $Body
            ContentType = 'application/json'
            Headers = @{
            'X-Cisco-Meraki-API-Key' = $token
            'Accept' = "application/json" 
            }
            Method = 'PUT'
            Uri = "https://api.meraki.com/api/v1/networks/$($network.id)/appliance/security/malware"
            }
        Invoke-WebRequest @Params
        }
}
}