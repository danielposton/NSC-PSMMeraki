function Get-MerakiWANIPs {    
    
    [CmdletBinding()]
         
    $Networks = (Get-MerakiNetworks)
    $Uplinks = (Get-MerakiUplinks)

    Join-Object -Left $Networks -Right $Uplinks -LeftJoinProperty 'id' -RightJoinProperty 'networkId' -Type OnlyIfInBoth `
    -ExcludeLeftProperties enrollmentString, isBoundToConfigTemplate, organizationId,  notes, productTypes, timeZone, tags, url -ExcludeRightProperties model, serial, highAvailability | `
    Select-Object name, uplinks -ExpandProperty uplinks | Select-Object name, interface,publicIp,primaryDns,secondaryDns, status | Sort-Object name, interface, active
}