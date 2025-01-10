# Active Directory Enumeration Rehberi

Bu rehberde, Active Directory (AD) ortamlarında kullanılan tüm keşif komutları ve yöntemler sıralı olarak açıklanmıştır. Her bir komutun ne işe yaradıkları detaylı bir şekilde ele alınmıştır.

## 1. Giriş

Active Directory (AD) bir ağdaki kaynakları yönetmek için kullanılan bir dizin hizmetidir. Saldırganlar için, bir AD ortamını keşfetmek (enumeration), ağ içindeki zayıf noktaları belirlemek ve ilerideki saldırılar için bir temel oluşturmak açısından kritik öneme sahiptir.

Bu rehberde, hem PowerShell hem de CMD gibi araçlarla kullanılabilecek yöntemler ve araçlar açıklanmaktadır.

---

## 2. Enumeration Komutları ve Metodolojisi

### 2.1. Domain Bilgilerini Keşfetme

#### `whoami`
**Amaç:** Mevcut kullanıcı adını öğrenir.

```cmd
whoami
```

#### `whoami /priv`
**Amaç:** Kullanıcının sahip olduğu ayrıcalıkları listeler.

```cmd
whoami /priv
```

#### `echo %USERDOMAIN%`
**Amaç:** Kullanıcının bağlı olduğu domain adını gösterir.

```cmd
echo %USERDOMAIN%
```

#### `Get-NetDomain`
**Amaç:** Domain hakkında genel bilgileri getirir.

```powershell
Get-NetDomain
```

#### `nltest /dsgetdc:<domain_adı>`
**Amaç:** Domain Controller (DC) hakkında bilgi alır.

```cmd
nltest /dsgetdc:<domain_adı>
```

---

### 2.2. Kullanıcı Hesaplarını Keşfetme

#### `net user /domain`
**Amaç:** Domain'deki tüm kullanıcı hesaplarını listeler.

```cmd
net user /domain
```

#### `Get-NetUser`
**Amaç:** Domain'deki kullanıcı hesapları hakkında detaylı bilgi alır.

```powershell
Get-NetUser
```

#### `Get-NetUser -Username <kullanıcı_adı>`
**Amaç:** Belirli bir kullanıcı hakkında bilgi alır.

```powershell
Get-NetUser -Username <kullanıcı_adı>
```

---

### 2.3. Grupları Keşfetme

#### `net group /domain`
**Amaç:** Domain'deki tüm grupları listeler.

```cmd
net group /domain
```

#### `Get-NetGroup`
**Amaç:** Domain'deki tüm grupları ve üyelerini listeler.

```powershell
Get-NetGroup
```

#### `Get-NetGroupMember -GroupName "Domain Admins"`
**Amaç:** Belirli bir grubun üyelerini listeler (ör. Domain Admins).

```powershell
Get-NetGroupMember -GroupName "Domain Admins"
```

---

### 2.4. Domain Controller Bilgilerini Keşfetme

#### `Get-NetDomainController`
**Amaç:** Domain Controller'ları listeler.

```powershell
Get-NetDomainController
```

#### `nltest /dclist:<domain_adı>`
**Amaç:** Domain Controller listesini alır.

```cmd
nltest /dclist:<domain_adı>
```

#### `dsquery server -isgc`
**Amaç:** Global Catalog (GC) sunucularını listeler.

```cmd
dsquery server -isgc
```

---

### 2.5. Paylaşımları (Shares) Keşfetme

#### `net view /domain`
**Amaç:** Domain'deki tüm bilgisayarları listeler.

```cmd
net view /domain
```

#### `net view \\<bilgisayar_adı>`
**Amaç:** Belirli bir bilgisayardaki paylaşılmış kaynakları gösterir.

```cmd
net view \\<bilgisayar_adı>
```

#### `Invoke-ShareFinder`
**Amaç:** Domain'deki tüm paylaşılmış dizinleri tarar.

```powershell
Invoke-ShareFinder
```

---

### 2.6. Açık Oturumları (Sessions) Keşfetme

#### `query user`
**Amaç:** Mevcut oturumları listeler.

```cmd
query user
```

#### `Invoke-UserHunter`
**Amaç:** Domain'deki aktif oturumları tespit eder.

```powershell
Invoke-UserHunter
```

---

### 2.7. ACL ve Yetkilendirme Bilgileri Keşfetme

#### `Get-ObjectAcl`
**Amaç:** Active Directory nesnelerine uygulanan erişim kontrol listelerini (ACL) inceler.

```powershell
Get-ObjectAcl -SamAccountName <kullanıcı_adı>
```

#### `Find-LocalAdminAccess`
**Amaç:** Kullanıcının yerel admin erişimi olan makineleri tespit eder.

```powershell
Find-LocalAdminAccess
```

---

### 2.8. SPN Tabanlı Kullanıcı Keşfi

#### `setspn -Q */*`
**Amaç:** Domain'deki SPN (Service Principal Name) tabanlı kullanıcıları bulur.

```cmd
setspn -Q */*
```

#### `Get-NetUser -SPN`
**Amaç:** SPN'i olan kullanıcı hesaplarını listeler.

```powershell
Get-NetUser -SPN
```

---

### 2.9. DNS Keşfi

#### `nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain_adı>`
**Amaç:** Domain Controller hizmetlerini çözümlemek.

```cmd
nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain_adı>
```

#### `Resolve-DnsName -Type SRV _kerberos._tcp.dc._msdcs.<domain_adı>`
**Amaç:** Kerberos hizmetlerini çözümlemek.

```powershell
Resolve-DnsName -Type SRV _kerberos._tcp.dc._msdcs.<domain_adı>
```

---

## 3. Özel Araçlar ve Teknikler

### BloodHound
**Amaç:** Active Directory ortamında kapsamlı bir grafiksel analiz sunar.

1. Neo4j veritabanını başlatın:
   ```cmd
   neo4j console
   ```

2. BloodHound GUI aracını açarak veritabanına bağlanın.

3. Verileri toplamak için `SharpHound` kullanın:
   ```cmd
   SharpHound.exe -c All
   ```

### PingCastle
**Amaç:** Active Directory güvenlik durumunu analiz eder.

```cmd
PingCastle.exe --healthcheck
```

---

## 4. Yöntemlerin Sıralı Uygulaması

1. **Domain bilgilerini keşfet:**
   - `whoami`
   - `Get-NetDomain`

2. **Kullanıcıları ve grupları keşfet:**
   - `net user /domain`
   - `Get-NetGroup`

3. **Domain Controller bilgilerini tespit et:**
   - `nltest /dclist:<domain_adı>`
   - `Get-NetDomainController`

4. **Paylaşımları ve oturumları keşfet:**
   - `net view /domain`
   - `Invoke-UserHunter`

5. **ACL ve SPN'leri analiz et:**
   - `Get-ObjectAcl`
   - `Get-NetUser -SPN`

6. **BloodHound ile detaylı analiz yap:**
   - `SharpHound.exe -c All`

7. **DNS keşfi yap:**
   - `nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain_adı>`

---

## 5. Sonuç

Bu rehber, Active Directory ortamlarında kapsamlı bir enumeration yapmanıza olanak tanır. Her adımın dikkatli bir şekilde uygulanması, ağ üzerindeki zayıflıkların tespitini kolaylaştırır ve saldırılar için sağlam bir temel oluşturur.
