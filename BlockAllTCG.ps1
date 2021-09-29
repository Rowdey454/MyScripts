
Connect-SPOService -Url "Your -Admin Sharepoint Online URL Here" 
$urls= get-sposite 



foreach($url in $urls){
 $SiteURL= $Url.url


Connect-PnPOnline -Url $SiteURL  -UseWebLogin
$Site = Get-PnPSite -Includes CustomScriptSafeDomains

Write-Host "Applying  BlockAll to $SiteURL"

#This blocks any domain  
$Site.AllowExternalEmbeddingWrapper = [Microsoft.SharePoint.Client.ScriptSafeExternalEmbedding]::None;
Invoke-PnPQuery
}