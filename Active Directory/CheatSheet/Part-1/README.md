# Active Directory Exploitation Cheat Sheet - Bölüm 1

Bu cheat sheet, Windows Active Directory için yaygın kullanılan keşif ve saldırı yöntemlerini içermektedir.

## Domain Keşfi

### PowerView Kullanımı

#### PowerView v.3.0

- **Mevcut Domain Bilgisi Al:**  
  `Get-Domain`

- **Diğer Domainleri Listele:**  
  `Get-Domain -Domain <DomainName>`

- **Domain SID Bilgisi Al:**  
  `Get-DomainSID`

- **Domain Policy Bilgisi Al:**  
  ```powershell
  Get-DomainPolicy
  Get-DomainPolicy | Select-Object -ExpandProperty SystemAccess
  Get-DomainPolicy | Select-Object -ExpandProperty KerberosPolicy
  ```

- **Domain Controller Bilgisi Al:**  
  ```powershell
  Get-DomainController
  Get-DomainController -Domain <DomainName>
  ```

- **Domain Kullanıcılarını Listele:**  
  ```powershell
  Get-DomainUser | Out-File -FilePath .\DomainUsers.txt
  Get-DomainUser -Identity [username] -Properties DisplayName, MemberOf | Format-List
  Get-NetLoggedon -ComputerName <ComputerName>
  Get-NetSession -ComputerName <ComputerName>
  Find-DomainUserLocation -Domain <DomainName> | Select-Object UserName, SessionFromName
  ```

- **Domain Bilgisayarlarını Listele:**  
  ```powershell
  Get-DomainComputer -Properties OperatingSystem, Name, DnsHostName | Sort-Object -Property DnsHostName
  Get-DomainComputer -Ping -Properties OperatingSystem, Name, DnsHostName | Sort-Object -Property DnsHostName
  ```

- **Grupları ve Grup Üyelerini Listele:**  
  ```powershell
  Get-DomainGroup | Out-File -FilePath .\DomainGroup.txt
  Get-DomainGroup -Identity '<GroupName>' | Select-Object -ExpandProperty Member
  Get-DomainGroupMember -Identity '<GroupName>' | Select-Object MemberDistinguishedName
  Get-NetLocalGroup | Select-Object GroupName
  Get-NetLocalGroupMember -GroupName Administrators | Select-Object MemberName, IsGroup, IsDomain
  Get-DomainGPOLocalGroup | Select-Object GPODisplayName, GroupName
  ```

- **Paylaşımları Listele:**  
  ```powershell
  Find-DomainShare
  Find-DomainShare -CheckShareAccess
  Find-InterestingDomainShareFile -Include *passwords*
  ```

- **Group Policy Nesnelerini Listele:**  
  ```powershell
  Get-DomainGPO -Properties DisplayName | Sort-Object -Property DisplayName
  Get-DomainGPO -ComputerIdentity <ComputerName> -Properties DisplayName | Sort-Object -Property DisplayName
  Get-DomainGPOComputerLocalGroupMapping -ComputerName <ComputerName>
  ```

- **Organizational Unit (OU) Listele:**  
  ```powershell
  Get-DomainOU -Properties Name | Sort-Object -Property Name
  ```

- **ACL Bilgisi Listele:**  
  ```powershell
  Get-DomainObjectAcl -Identity <AccountName> -ResolveGUIDs
  Find-InterestingDomainAcl -ResolveGUIDs
  Get-PathAcl -Path "\\Path\Of\A\Share"
  ```

- **Domain Trust İlişkilerini Listele:**  
  ```powershell
  Get-DomainTrust
  Get-DomainTrust -Domain <DomainName>
  Get-DomainTrustMapping
  ```

- **Forest Trust İlişkilerini Listele:**  
  ```powershell
  Get-ForestDomain
  Get-ForestDomain -Forest <ForestName>
  Get-ForestTrust
  Get-ForestTrust -Forest <ForestName>
  
