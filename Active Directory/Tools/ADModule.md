# ADModule.dll Kullanım Rehberi

## ADModule.dll Nedir?

**ADModule.dll**, Active Directory ortamlarında PowerShell veya diğer araçlarla birlikte kullanılabilen bir modüldür. Active Directory'deki kullanıcı, grup, organizasyon birimleri (OU), ve politikalar gibi nesneleri yönetmek ve sorgulamak için işlevler sağlar.

Bu DLL dosyası, genellikle Windows Server ortamlarında veya Active Directory'nin yüklü olduğu makinelerde bulunur. Yönetim görevlerini otomatize etmek veya özel komutlar oluşturmak için kullanılabilir.

> **Önemli Not:** ADModule.dll, yalnızca yetkili yöneticiler tarafından kullanılmalıdır. Yanlış yapılandırmalar veya yetkisiz erişim, güvenlik açıklarına yol açabilir.

---

## Ana Özellikleri

1. **Active Directory Nesnelerini Yönetme:**
   - Kullanıcı, grup, ve organizasyon birimi (OU) oluşturma, silme ve düzenleme.
2. **Sorgulama ve Raporlama:**
   - Active Directory'deki nesneler üzerinde sorgular çalıştırma.
3. **Politika Yönetimi:**
   - Grup İlkesi Nesnelerini (GPO) sorgulama ve düzenleme.
4. **Kimlik Doğrulama ve Yetkilendirme İşlemleri:**
   - Kullanıcı oturumlarını ve izinlerini yönetme.

---

## ADModule.dll Nasıl Kullanılır?

ADModule.dll, genellikle bir PowerShell modülü veya .NET uygulaması aracılığıyla yüklenir ve kullanılır.

### PowerShell Üzerinden Kullanım

#### 1. Modülü Yükleme
ADModule.dll dosyasını PowerShell oturumuna yüklemek için aşağıdaki komutu kullanabilirsiniz:

```powershell
Import-Module -Name "C:\Path\To\ADModule.dll"
```

#### 2. Modülün Fonksiyonlarını Listeleme
Yüklü modülün tüm fonksiyonlarını görmek için:

```powershell
Get-Command -Module ADModule
```

#### 3. Yardım Mesajlarını Görüntüleme
Bir komutun kullanımını görmek için:

```powershell
Get-Help <Command-Name> -Full
```

---

## Önemli Fonksiyonlar ve Kullanım Örnekleri

### 1. **Get-ADUser**
- Active Directory'deki kullanıcıları listelemek için kullanılır.

  **Örnek Kullanım:**
  ```powershell
  Get-ADUser -Filter * | Select-Object Name, SamAccountName, EmailAddress
  ```

  **Parametreler:**
  - `-Filter`: Kullanıcıları filtrelemek için kullanılan parametre (örn. "Name -like '*admin*'")
  - `-Properties`: Ek kullanıcı özelliklerini listelemek için kullanılır.

### 2. **New-ADUser**
- Yeni bir kullanıcı oluşturur.

  **Örnek Kullanım:**
  ```powershell
  New-ADUser -Name "John Doe" -SamAccountName "jdoe" -UserPrincipalName "jdoe@example.com" -Path "OU=Users,DC=example,DC=com" -AccountPassword (ConvertTo-SecureString "Password123" -AsPlainText -Force) -Enabled $true
  ```

### 3. **Set-ADUser**
- Mevcut bir kullanıcıyı günceller.

  **Örnek Kullanım:**
  ```powershell
  Set-ADUser -Identity "jdoe" -EmailAddress "john.doe@example.com" -Title "System Administrator"
  ```

### 4. **Get-ADGroup**
- Active Directory'deki grupları sorgular.

  **Örnek Kullanım:**
  ```powershell
  Get-ADGroup -Filter "GroupCategory -eq 'Security'" | Select-Object Name, GroupScope
  ```

### 5. **New-ADGroup**
- Yeni bir grup oluşturur.

  **Örnek Kullanım:**
  ```powershell
  New-ADGroup -Name "ITAdmins" -GroupCategory Security -GroupScope Global -Path "OU=Groups,DC=example,DC=com"
  ```

### 6. **Remove-ADUser**
- Bir kullanıcıyı Active Directory'den siler.

  **Örnek Kullanım:**
  ```powershell
  Remove-ADUser -Identity "jdoe"
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm Kullanıcıları Listeleme ve E-posta Adreslerini Alma
```powershell
Get-ADUser -Filter * -Properties EmailAddress | Select-Object Name, EmailAddress
```

### 2. Belirli Bir OU'daki Kullanıcıları Listeleme
```powershell
Get-ADUser -Filter * -SearchBase "OU=Users,DC=example,DC=com"
```

### 3. Bir Kullanıcının Üye Olduğu Grupları Görüntüleme
```powershell
Get-ADUser -Identity "jdoe" | Get-ADGroupMember
```

### 4. Kullanıcı Parolasını Değiştirme
```powershell
Set-ADAccountPassword -Identity "jdoe" -NewPassword (ConvertTo-SecureString "NewPassword123" -AsPlainText -Force)
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** ADModule.dll yalnızca Active Directory yöneticileri tarafından kullanılmalıdır.
- **Loglama:** Yapılan değişiklikler Active Directory'de loglanır. Bu nedenle yetkisiz işlemler kolayca tespit edilebilir.
- **Test Ortamı:** Önce test ortamında çalıştırılması önerilir.

---

## Kaynaklar

- [Microsoft Docs](https://docs.microsoft.com/en-us/powershell/)
- [Active Directory PowerShell Cmdlets](https://learn.microsoft.com/en-us/windows-server/identity/ad-powershell/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
