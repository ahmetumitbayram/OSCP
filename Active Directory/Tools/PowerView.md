# PowerView.ps1 Kullanım Rehberi

## PowerView.ps1 Nedir?

**PowerView.ps1**, Active Directory (AD) ortamlarında bilgi toplamak ve zafiyetleri tespit etmek için kullanılan bir PowerShell betiğidir. Güvenlik uzmanları ve sistem yöneticileri için tasarlanmış olan bu araç, AD ortamındaki kullanıcılar, gruplar, bilgisayarlar, GPO’lar ve diğer AD nesneleri hakkında ayrıntılı bilgi sağlar.

> **Önemli Not:** PowerView.ps1 yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Tarama:**
   - Kullanıcı, grup, bilgisayar ve diğer AD nesnelerini listeler.
2. **Erişim Hakları Analizi:**
   - AD nesnelerine erişim yetkilerini inceler ve zayıf yapılandırmaları raporlar.
3. **Bilgi Toplama:**
   - AD yapısını anlamak için ayrıntılı bilgi toplar.

---

## İndirme ve Çalıştırma

PowerView.ps1, GitHub üzerinden indirilebilir:

- [https://github.com/PowerShellEmpire/PowerTools/tree/master/PowerView](https://github.com/PowerShellEmpire/PowerTools/tree/master/PowerView)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   Invoke-WebRequest -Uri https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerView/powerview.ps1 -OutFile PowerView.ps1
   ```

2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\PowerView.ps1
   ```

---

## Kullanım Parametreleri

### 1. **`Get-Domain`**
- AD domain bilgilerini listeler.

  **Kullanım:**
  ```powershell
  Get-Domain
  ```

### 2. **`Get-DomainUser`**
- AD domainindeki kullanıcıları listeler.

  **Kullanım:**
  ```powershell
  Get-DomainUser
  ```

### 3. **`Get-DomainGroup`**
- AD domainindeki grupları listeler.

  **Kullanım:**
  ```powershell
  Get-DomainGroup
  ```

### 4. **`Get-DomainComputer`**
- AD domainindeki bilgisayar nesnelerini listeler.

  **Kullanım:**
  ```powershell
  Get-DomainComputer
  ```

### 5. **`Find-LocalAdminAccess`**
- Yerel yönetici erişimine sahip bilgisayarları bulur.

  **Kullanım:**
  ```powershell
  Find-LocalAdminAccess
  ```

### 6. **`-Help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```powershell
  Get-Help Get-Domain
  ```

---

## Örnek Kullanım Senaryoları

### 1. AD Domain Bilgilerini Görüntüleme
```powershell
Get-Domain
```

### 2. AD Kullanıcılarını Listeleme
```powershell
Get-DomainUser
```

### 3. AD Gruplarını Listeleme
```powershell
Get-DomainGroup
```

### 4. Bilgisayar Nesnelerini Bulma
```powershell
Get-DomainComputer
```

### 5. Yerel Yönetici Erişimi Olan Bilgisayarları Bulma
```powershell
Find-LocalAdminAccess
```

### 6. Yardım Mesajını Görüntüleme
```powershell
Get-Help Get-Domain
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PowerView.ps1 yalnızca güvenlik uzmanları ve sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PowerView Resmi Sayfası](https://github.com/PowerShellEmpire/PowerTools/tree/master/PowerView)
- [Active Directory Güvenliği](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
