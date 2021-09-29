Connect-SPOService -Url "Your -admin Sharepoint Online URL here”
$urls= get-sposite 



foreach($url in $urls){
 $SiteURL= $Url.url

#Connect to PnP Online
Connect-PnPOnline  -Url $SiteURL -UseWebLogin
$Site = Get-PnPSite -Includes CustomScriptSafeDomains

#This would allow for a custom domain list through powershell
Write-Host "Applying  AllowedDomains to $SiteURL"
$site.AllowExternalEmbeddingWrapper = [Microsoft.SharePoint.Client.ScriptSafeExternalEmbedding]::AllowedDomains;

Invoke-pnpquery




 #Add domain
$Domain = [Microsoft.SharePoint.Client.ScriptSafeDomainEntityData]::new()

$Domain.DomainName = "URL1 here" 
$Site.CustomScriptSafeDomains.Create($Domain) 

$Domain.DomainName = "URL2 here" 
$Site.CustomScriptSafeDomains.Create($Domain)
Invoke-pnpquery



#Removal of domains
$Removed=$Site.CustomScriptSafeDomains.GetByDomainName(“URL to be removed here”)
$Removed.DeleteObject()
Invoke-pnpquery
#What URLs need to be deleted?
}