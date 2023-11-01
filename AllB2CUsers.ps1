$ApplicationID = "xxx"
$TenatDomainName = "xxx"
$AccessSecret = "xxx"


$Body = @{    
Grant_Type    = "client_credentials"
Scope         = "https://graph.microsoft.com/.default"
client_Id     = $ApplicationID
Client_Secret = $AccessSecret
} 

$ConnectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenatDomainName/oauth2/v2.0/token" -Method POST -Body $Body

$token = $ConnectGraph.access_token

$GrapUrl = 'https://graph.microsoft.com/v1.0/users/?$select=id,displayName,mail,otherMails,EmailAddresses'
$GrapUrl = 'https://graph.microsoft.com/v1.0/applications/fea0ec14f6364d3790b1c72b82bd0a00/extensionProperties'
$GrapUrl = 'https://graph.microsoft.com/v1.0/applications'

Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
Write-Host '----------------------------------------------------- B2C App Id ------------------------------------------------------------------------------'
Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
Write-Host ' --- AppName --- '
(Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $GrapUrl -Method Get).value.displayName+" --- appID --- "+(Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $GrapUrl -Method Get).value.appId+" --- Id --- "+(Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $GrapUrl -Method Get).value.Id
Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
Write-Host '------------------------------ The Custom fields taken from b2c-extensions-app Id (last outputs) not appId ------------------------------------'
Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
$GrapUrl = 'https://graph.microsoft.com/v1.0/applications/2834a576-f992-44ab-b5f5-31703ba491f1/extensionProperties'
(Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $GrapUrl -Method Get).value
Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
Write-Host '--------------------------------------------------    All Users     ---------------------------------------------------------------------------'
Write-Host '-----------------------------------------------------------------------------------------------------------------------------------------------'
$GrapUrl = 'https://graph.microsoft.com/v1.0/users/?$select=identities,displayName,mail,otherMails,id,userType,creationType,accountEnabled,createdDateTime,creationType,lastPasswordChangeDateTime,mailNickname,refreshTokensValidFromDateTime,signInSessionsValidFromDateTime,displayName,extension_a0a23b3b4e404f2ba6e711d151e13811_Level1PlayerWeight,extension_a0a23b3b4e404f2ba6e711d151e13811_Level1PlayerHeight,extension_a0a23b3b4e404f2ba6e711d151e13811_Level1PlayerSchool'
(Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)"} -Uri $GrapUrl -Method Get).value|Format-List
