# Impacket Araçları: Kullanım ve Açıklamalar

Bu dokümanda, aşağıda listelenen 14 Impacket aracının ne işe yaradığını ve nasıl kullanıldığını 1, 2, 3 adımlarında açıklayacağız.

---

## 1. impacket-DumpNTLMInfo

### Ne İşe Yarar?
Bu araç, NTLM hash bilgilerini bir sistemden dökerek analiz etmenizi sağlar.

### Nasıl Kullanılır?
```bash
impacket-DumpNTLMInfo [kullanıcı_adı]:[şifre]@[hedef_ip]
```

1. Hedef sistemin IP adresini belirleyin.
2. Kullanıcı adı ve şifreyi girin.
3. Çıktıda NTLM hash bilgilerini alın.

---

## 2. impacket-dpapi

### Ne İşe Yarar?
Windows DPAPI (Data Protection API) ile korunan verileri çözmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-dpapi [seçenekler]
```

1. DPAPI korumalı veriyi belirleyin.
2. Gerekli anahtarları veya kullanıcı verilerini sağlayın.
3. Şifrelenmiş veriyi çözün.

---

## 3. impacket-karmaSMB

### Ne İşe Yarar?
SMB (Server Message Block) üzerinden saldırılar gerçekleştirmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-karmaSMB [IP]
```

1. SMB protokolünü hedef alın.
2. Hedef IP adresini girin.
3. Çeşitli saldırılar gerçekleştirin.

---

## 4. impacket-net

### Ne İşe Yarar?
Hedef ağda çeşitli ağ sorguları yapmak için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-net [seçenekler] [hedef_ip]
```

1. Hedef ağı analiz edin.
2. IP adreslerini ve port bilgilerini sorgulayın.
3. Çıktıyı inceleyin.

---

## 5. impacket-rbcd

### Ne İşe Yarar?
Active Directory ortamlarında Resource-Based Constrained Delegation saldırıları gerçekleştirmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-rbcd [kullanıcı_adı]:[şifre]@[domain_adı]
```

1. Active Directory ortamına erişin.
2. Saldırı hedefini belirleyin.
3. Yetki yükseltme saldırılarını gerçekleştirin.

---

## 6. impacket-services

### Ne İşe Yarar?
Hedef Windows sistemindeki hizmetleri listelemek ve yönetmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-services [kullanıcı_adı]:[şifre]@[hedef_ip]
```

1. Hedef sistemde oturum açın.
2. Hizmetleri sorgulayın veya değiştirin.
3. Çıktıları analiz edin.

---

## 7. impacket-ticketConverter

### Ne İşe Yarar?
Kerberos biletlerini farklı formatlara dönüştürmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-ticketConverter [bilet_dosya_adı]
```

1. Kerberos biletini bulun.
2. Bilet dosyasını araca yükleyin.
3. Dönüştürülmüş bileti alın.

---

## 8. impacket-Get-GPPPassword

### Ne İşe Yarar?
Group Policy Preferences (GPP) içerisinde saklanan şifreleri çıkarır.

### Nasıl Kullanılır?
```bash
impacket-Get-GPPPassword [path_to_xml_file]
```

1. GPP şifrelerini içeren XML dosyasını belirleyin.
2. Aracı çalıştırın.
3. Çözülen şifreyi alın.

---

## 9. impacket-esentutl

### Ne İşe Yarar?
Windows sistemlerde kullanılan Extensible Storage Engine (ESE) veritabanı dosyalarını analiz etmek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-esentutl [veritabanı_dosya_adı]
```

1. Analiz edilecek ESE dosyasını bulun.
2. Aracı çalıştırın.
3. Çıktıları analiz edin.

---

## 10. impacket-keylistattack

### Ne İşe Yarar?
KDC'nin (Key Distribution Center) anahtar listelerini sorgular.

### Nasıl Kullanılır?
```bash
impacket-keylistattack [kullanıcı_adı]:[şifre]@[domain_adı]
```

1. Domain bilgilerini sağlayın.
2. Anahtar listesini sorgulayın.
3. Çıktıları analiz edin.

---

## 11. impacket-netview

### Ne İşe Yarar?
Bir ağdaki tüm paylaşımları ve cihazları görüntülemek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-netview [kullanıcı_adı]:[şifre]@[hedef_ip]
```

1. Hedef ağı belirleyin.
2. Tüm ağ cihazlarını listeleyin.
3. Çıktıları inceleyin.

---

## 12. impacket-rdp_check

### Ne İşe Yarar?
Hedef sistemin RDP (Remote Desktop Protocol) durumunu kontrol eder.

### Nasıl Kullanılır?
```bash
impacket-rdp_check [IP]
```

1. Hedef IP'yi belirleyin.
2. RDP'nin açık olup olmadığını kontrol edin.
3. Çıktıları analiz edin.

---

## 13. impacket-smbclient

### Ne İşe Yarar?
SMB protokolü üzerinden dosya paylaşımını yönetmek ve incelemek için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-smbclient [kullanıcı_adı]:[şifre]@[hedef_ip]
```

1. Hedef sisteme bağlanın.
2. Dosyaları listeleyin veya kopyalayın.
3. Çıktıları inceleyin.

---

## 14. impacket-ticketer

### Ne İşe Yarar?
Kerberos bileti oluşturmak için kullanılır.

### Nasıl Kullanılır?
```bash
impacket-ticketer -nthash [hash] [kullanıcı_adı]
```

1. Kullanıcı bilgilerini ve NT hash'i sağlayın.
2. Kerberos bileti oluşturun.
3. Bileti kullanarak hedef sisteme erişin.

### Impacket Araçları: Kullanım ve Amaçlar

---

#### 15. **impacket-GetADUsers**
- **Ne işe yarar:**
  Active Directory (AD) ortamında belirli kullanıcı bilgilerini sorgulamak için kullanılır. Özellikle kullanıcı adlarını, açıklamalarını ve gruplarını öğrenmek için yararlıdır.

- **Nasıl kullanılır:**
  ```bash
  impacket-GetADUsers -dc-ip <DC_IP> <domain>/<username>:<password>
  ```
  - `<DC_IP>`: Domain Controller'ın IP adresi.
  - `<domain>`: Hedef domain adı.
  - `<username>`: Kullanıcı adı.
  - `<password>`: Kullanıcı şifresi.

---

#### 16. **impacket-GetNPUsers**
- **Ne işe yarar:**
  Kerberos protokolünde Pre-Authentication özelliği devre dışı bırakılmış kullanıcıların hashlerini (AS-REP hashes) almak için kullanılır. Bu hashler brute-force saldırıları için kullanılabilir.

- **Nasıl kullanılır:**
  ```bash
  impacket-GetNPUsers -dc-ip <DC_IP> -no-pass <domain>/<username>
  ```
  - `-no-pass`: Parola olmadan kullanıcı sorgulama.

---

#### 17. **impacket-findDelegation**
- **Ne işe yarar:**
  Active Directory ortamında güvenilirlik (delegation) yapılandırmalarını tespit etmek için kullanılır. Özellikle Kerberos tabanlı saldırılar için önemlidir.

- **Nasıl kullanılır:**
  ```bash
  impacket-findDelegation -dc-ip <DC_IP> <domain>/<username>:<password>
  ```

---

#### 18. **impacket-lookupsid**
- **Ne işe yarar:**
  Bir sistemdeki SID (Security Identifier) değerlerini kullanıcı veya grup bilgileriyle eşleştirir. Hedef sistemdeki kullanıcıları ve grupları listelemek için kullanılabilir.

- **Nasıl kullanılır:**
  ```bash
impacket-lookupsid <domain>/<username>:<password>@<target>
  ```

---

#### 19. **impacket-nmapAnswerMachine**
- **Ne işe yarar:**
  Sahte bir hedef gibi davranarak Nmap taramalarına yanıt vermek için kullanılır. Penetrasyon testlerinde savunma mekanizmalarını test etmek için idealdir.

- **Nasıl kullanılır:**
  ```bash
  impacket-nmapAnswerMachine
  ```

---

#### 20. **impacket-ntfs-read**
- **Ne işe yarar:**
  NTFS formatındaki dosya sistemlerinden veri okumak için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-ntfs-read <target_ip> <domain>/<username>:<password>
  ```

---

#### 21. **impacket-reg**
- **Ne işe yarar:**
  Windows kayıt defterine (registry) erişmek ve düzenlemeler yapmak için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-reg <operation> <target_ip> <domain>/<username>:<password>
  ```
  - `<operation>`: Örneğin `list`, `read`.

---

#### 22. **impacket-registry-read**
- **Ne işe yarar:**
  Windows sistemlerindeki kayıt defterinden bilgi okumak için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-registry-read <target_ip> <domain>/<username>:<password>
  ```

---

#### 23. **impacket-smbexec**
- **Ne işe yarar:**
  SMB protokolü üzerinden komut çalıştırmak için kullanılır. Özellikle sistemlere sızma sonrası hareketlerde faydalıdır.

- **Nasıl kullanılır:**
  ```bash
impacker-smbexec WORKGROUP/username:password@ip
  ```

---

#### 24. **impacket-smbpasswd**
- **Ne işe yarar:**
  SMB üzerinden kullanıcı şifrelerini değiştirmek için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-smbpasswd <target_ip> <username> <new_password>
  ```

---

#### 25. **impacket-tstool**
- **Ne işe yarar:**
  Terminal Services (RDP) üzerinden bilgi almak veya saldırı yapmak için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-tstool <target_ip> <domain>/<username>:<password>
  ```

---

#### 26. **impacket-wmiexec**
- **Ne işe yarar:**
  WMI (Windows Management Instrumentation) üzerinden komut çalıştırmak için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-wmiexec <domain>/<username>:<password>@<target_ip>
  ```

---

#### 27. **impacket-exchanger**
- **Ne işe yarar:**
  Microsoft Exchange Server üzerinde güvenlik açıklarını keşfetmek ve sömürmek için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-exchanger <domain>/<username>:<password>@<exchange_server_ip>
  ```

---

#### 28. **impacket-kintercept**
- **Ne işe yarar:**
  Microsoft Kerberos protokolü üzerinde işlemleri yakalamak ve analiz etmek için kullanılır.

- **Nasıl kullanılır:**
  ```bash
  impacket-kintercept <target_ip> <domain>/<username>:<password>
  ```
### 29. impacket-GetUserSPNs
- **Ne İşe Yarar:**
  Active Directory ortamında Service Principal Names (SPN) olan kullanıcıları listeler. Kerberoasting saldırıları için kullanışlıdır.
- **Nasıl Kullanılır:**
  ```bash
  impacket-GetUserSPNs -dc-ip <DC_IP> -request <DOMAIN>/<USER>:<PASSWORD>
  ```
  Parametreler:
  - `-dc-ip`: Domain Controller IP adresi.
  - `-request`: SPN biletlerini çıkartır ve Kerberos biletlerini kaydeder.

### 30. impacket-getArch
- **Ne İşe Yarar:**
  Hedef sistemin mimarisini (32-bit veya 64-bit) belirler.
- **Nasıl Kullanılır:**
  ```bash
  impacket-getArch <TARGET_IP> <USERNAME> <PASSWORD>
  ```

### 31. impacket-machine_role
- **Ne İşe Yarar:**
  Hedef makinenin Active Directory ortamındaki rolünü öğrenir (örneğin, Domain Controller).
- **Nasıl Kullanılır:**
  ```bash
  impacket-machine_role -dc-ip <DC_IP> <DOMAIN>/<USER>:<PASSWORD>
  ```

### 32. impacket-ntlmrelayx
- **Ne İşe Yarar:**
  NTLM kimlik doğrulama protokolünü kullanarak relay saldırıları düzenler.
- **Nasıl Kullanılır:**
  ```bash
  impacket-ntlmrelayx -tf <TARGET_FILE> -smb2support
  ```
  Parametreler:
  - `-tf`: Hedef dosyası, relay edilecek sistemleri içerir.

### 33. impacket-rpcdump
- **Ne İşe Yarar:**
  Hedef sistemdeki RPC arabirimlerini (Remote Procedure Call) keşfeder.
- **Nasıl Kullanılır:**
  ```bash
  impacket-rpcdump <TARGET_IP>
  ```

### 34. impacket-smbrelayx
- **Ne İşe Yarar:**
  SMB kimlik doğrulamalarını hedef sistemlere relay ederek yetkisiz erişim sağlar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-smbrelayx -h
  ```

### 35. impacket-wmipersist
- **Ne İşe Yarar:**
  WMI (Windows Management Instrumentation) kullanarak kalıcılık sağlar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-wmipersist -ip <TARGET_IP> -username <USER> -password <PASSWORD>
  ```

### 36. impacket-addcomputer
- **Ne İşe Yarar:**
  Active Directory ortamına yeni bir bilgisayar hesabı ekler.
- **Nasıl Kullanılır:**
  ```bash
  impacket-addcomputer -dc-ip <DC_IP> <DOMAIN>/<USER>:<PASSWORD>
  ```

### 37. impacket-getPac
- **Ne İşe Yarar:**
  PAC (Privilege Attribute Certificate) bilgilerini toplar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-getPac -target-ip <TARGET_IP> -username <USER> -password <PASSWORD>
  ```

### 38. impacket-mimikatz
- **Ne İşe Yarar:**
  Windows sistemlerinde Mimikatz komutlarını çalıştırır, kimlik bilgilerini çalar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-mimikatz <TARGET_IP> <DOMAIN>/<USER>:<PASSWORD>
  ```

### 39. impacket-ping
- **Ne İşe Yarar:**
  SMB ve ICMP protokollerini kullanarak hedefe ping atar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-ping <TARGET_IP>
  ```

### 40. impacket-rpcmap
- **Ne İşe Yarar:**
  RPC servislerini ve bunların UUID'lerini hedef sistemde tarar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-rpcmap <TARGET_IP>
  ```

### 41. impacket-smbserver
- **Ne İşe Yarar:**
  SMB paylaşımı başlatır ve saldırılar için sahte bir SMB sunucusu oluşturur.
- **Nasıl Kullanılır:**
  ```bash
  impacket-smbserver <SHARE_NAME> <SHARE_PATH>
  ```

### 42. impacket-wmiquery
- **Ne İşe Yarar:**
  WMI sorguları çalıştırarak bilgi toplar.
- **Nasıl Kullanılır:**
  ```bash
  impacket-wmiquery -target-ip <TARGET_IP> -username <USER> -password <PASSWORD>

## 43. impacket-atexec
**Ne İşe Yarar:**
Windows üzerinde uzak bir sistemde komut çalıştırmak için kullanılır. Windows'un "Task Scheduler" API'sini kullanır.

**Kullanımı:**
```
impacket-atexec <domain>/<username>:<password>@<target> "komut"
```
**Örnek:**
```
impacket-atexec corp.local/admin:Password123@192.168.1.10 "whoami"
```
---

## 44. impacket-changepasswd
**Ne İşe Yarar:**
Active Directory kullanıcılarının parolalarını değiştirmek için kullanılır.

**Kullanımı:**
```
impacket-changepasswd <domain>/<username>:<password>@<target>
```
**Örnek:**
```
impacket-changepasswd corp.local/user1:oldPass123@dc.corp.local -newPass yeniPass456
```
---

## 45. impacket-dcomexec
**Ne İşe Yarar:**
Distributed Component Object Model (DCOM) üzerinden komut çalıştırma aracıdır. Windows sistemlerde yetki yükseltme ve uzaktan komut çalıştırmada kullanılır.

**Kullanımı:**
```
impacket-dcomexec <domain>/<username>:<password>@<target> "komut"
```
**Örnek:**
```
impacket-dcomexec corp.local/admin:Password123@192.168.1.10 "ipconfig"
```
---

## 46. impacket-getST
**Ne İşe Yarar:**
Kerberos protokolünde bir kullanıcı için Service Ticket (ST) elde etmek için kullanılır.

**Kullanımı:**
```
impacket-getST -targetUser <username> -domain <domain> -hashes <hash> -spn <spn>
```
**Örnek:**
```
impacket-getST -targetUser user1 -domain corp.local -hashes a7b9c9... -spn ldap/dc.corp.local
```
---

## 47. impacket-getTGT
**Ne İşe Yarar:**
Bir kullanıcının Kerberos bileti olan Ticket Granting Ticket (TGT) elde etmek için kullanılır.

**Kullanımı:**
```
impacket-getTGT <username>:<password> -dc-ip <domain_controller>
```
**Örnek:**
```
impacket-getTGT admin:Password123 -dc-ip 192.168.1.5
```
---

## 48. impacket-goldenPac
**Ne İşe Yarar:**
Active Directory'de NTLM hash'lerini kullanarak "Golden Ticket" saldırısı gerçekleştirmek için kullanılır.

**Kullanımı:**
```
impacket-goldenPac <domain>/<username>:<password>@<target>
```
**Örnek:**
```
impacket-goldenPac corp.local/admin:Password123@192.168.1.10
```
---

## 49. impacket-mssqlclient
**Ne İşe Yarar:**
Microsoft SQL Server'lara bağlanmak ve komut çalıştırmak için kullanılan bir araçtır.

**Kullanımı:**
```
impacket-mssqlclient <username>:<password>@<target>
```
**Örnek:**
```
impacket-mssqlclient sa:Password123@192.168.1.20
```
---

## 50. impacket-mssqlinstance
**Ne İşe Yarar:**
Microsoft SQL Server'da aktif olan tüm instance'ları bulmak için kullanılır.

**Kullanımı:**
```
impacket-mssqlinstance <username>:<password>@<target>
```
**Örnek:**
```
impacket-mssqlinstance sa:Password123@192.168.1.20
```
---

## 51. impacket-ping6
**Ne İşe Yarar:**
IPv6 adreslerine ping atmak için kullanılan bir araçtır.

**Kullanımı:**
```
impacket-ping6 <target>
```
**Örnek:**
```
impacket-ping6 fe80::1
```
---

## 52. impacket-psexec
**Ne İşe Yarar:**
Windows üzerinde uzaktan komut çalıştırmak için kullanılan bir araçtır. SMB protokolünü kullanır.

**Kullanımı:**
```
impacket-psexec <domain>/<username>:<password>@<target>
```
**Örnek:**
```
impacket-psexec corp.local/admin:Password123@192.168.1.10
```
---

## 53. impacket-raiseChild
**Ne İşe Yarar:**
Bir child işlemi yükseltmek için kullanılan bir araçtır.

**Kullanımı:**
```
impacket-raiseChild <options>
```
**Örnek:**
```
impacket-raiseChild -process 1234
```
---

## 54. impacket-sambaPipe
**Ne İşe Yarar:**
SMB boruları üzerinden veri alışverişi yapmak için kullanılan bir araçtır.

**Kullanımı:**
```
impacket-sambaPipe <options>
```
**Örnek:**
```
impacket-sambaPipe -pipe srvsvc
```
---

## 55. impacket-samrdump
**Ne İşe Yarar:**
SAMR protokolü kullanarak kullanıcı ve grup bilgilerini listelemek için kullanılır.

**Kullanımı:**
```
impacket-samrdump <domain>/<username>:<password>@<target>
```
**Örnek:**
```
impacket-samrdump corp.local/admin:Password123@192.168.1.10
```
---

## 56. impacket-secretsdump
**Ne İşe Yarar:**
Bir sistemin NTLM hash'lerini ve parolalarını dump etmek için kullanılır.

**Kullanımı:**
```
impacket-secretsdump <domain>/<username>:<password>@<target>
```
**Örnek:**
```
impacket-secretsdump corp.local/admin:Password123@192.168.1.10
```
---

## 57. impacket-sniff
**Ne İşe Yarar:**
Ağ trafiğini yakalamak ve analiz etmek için kullanılan bir araçtır.

**Kullanımı:**
```
impacket-sniff <options>
```
**Örnek:**
```
impacket-sniff -interface eth0
```
---

## 58. impacket-sniffer
**Ne İşe Yarar:**
Ağ trafiğini yakalamak için kullanılan başka bir araçtır. Daha ayrıntılı analiz için kullanılır.

**Kullanımı:**
```
impacket-sniffer <options>
```
**Örnek:**
```
impacket-sniffer -filter "tcp port 80"
```
---

## 59. impacket-split
**Ne İşe Yarar:**
Büyük dosyaları daha küçük parçalara bölmek için kullanılır.

**Kullanımı:**
```
impacket-split <file> <size>
```
**Örnek:**
```
impacket-split bigfile.pcap 50MB
```
---

## 60. impacket-mqtt_check
**Ne İşe Yarar:**
MQTT (Message Queuing Telemetry Transport) protokolünü kullanan cihazların zafiyetlerini test etmek için kullanılır.

**Kullanımı:**
```
impacket-mqtt_check <host>:<port>
```
**Örnek:**
```
impacket-mqtt_check 192.168.1.10:1883
```
---
