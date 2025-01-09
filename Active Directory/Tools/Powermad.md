# Powermad.ps1 Kullanım Rehberi

## Powermad.ps1 Nedir?

**Powermad.ps1**, Active Directory ortamında dinamik nesne manipülasyonu yapmak için kullanılan bir PowerShell betiğidir. Bu araç, özellikle Active Directory (AD) domain'lerinde kontrolü ele geçirmek veya domain yapılandırmalarını analiz etmek için kullanılır. **Powermad**, AD ortamlarında saldırı simülasyonları ve güvenlik testleri için güçlü bir araçtır.

> **Önemli Not:** Powermad.ps1 yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Domain Controller Nesneleri Oluşturma:**
   - AD domain'inde test amaçlı nesneler oluşturur.
2. **Bilgi Toplama:**
   - Active Directory yapısındaki kritik bilgileri toplar.
3. **Yapılandırma Analizi:**
   - Domain trust ilişkilerini ve grup yapılandırmalarını analiz eder.

---

## İndirme ve Çalıştırma

Powermad.ps1, GitHub üzerinden indirilebilir:

- [https://github.com/Kevin-Robertson/Powermad](https://github.com/Kevin-Robertson/Powermad)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   Invoke-WebRequest -Uri https://raw.githubusercontent.com/Kevin-Robertson/Powermad/master/Powermad.ps1 -OutFile Powermad.ps1
   ```

2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\Powermad.ps1
   ```

---

## Kullanım Parametreleri

### 1. **`New-MachineAccount`**
- AD domain'ine yeni bir bilgisayar hesabı ekler.

  **Kullanım:**
  ```powershell
  New-MachineAccount -MachineAccount TestMachine -Password $(ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force)
  ```

### 2. **`Remove-MachineAccount`**
- Oluşturulmuş bir bilgisayar hesabını kaldırır.

  **Kullanım:**
  ```powershell
  Remove-MachineAccount -MachineAccount TestMachine
  ```

### 3. **`Get-DomainTrust`**
- Domain trust ilişkilerini listeler.

  **Kullanım:**
  ```powershell
  Get-DomainTrust
  ```

### 4. **`Set-MachineAccount`**
- Bir bilgisayar hesabının özelliklerini değiştirir.

  **Kullanım:**
  ```powershell
  Set-MachineAccount -MachineAccount TestMachine -Description "Updated Description"
  ```

### 5. **`-Help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```powershell
  Get-Help New-MachineAccount
  ```

---

## Örnek Kullanım Senaryoları

### 1. Yeni Bir Bilgisayar Hesabı Oluşturma
```powershell
New-MachineAccount -MachineAccount TestMachine -Password $(ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force)
```

### 2. Domain Trust İlişkilerini Görüntüleme
```powershell
Get-DomainTrust
```

### 3. Bir Bilgisayar Hesabını Kaldırma
```powershell
Remove-MachineAccount -MachineAccount TestMachine
```

### 4. Bir Hesabın Özelliklerini Güncelleme
```powershell
Set-MachineAccount -MachineAccount TestMachine -Description "Updated Description"
```

### 5. Yardım Mesajını Görüntüleme
```powershell
Get-Help New-MachineAccount
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Powermad.ps1 yalnızca güvenlik uzmanları ve sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Powermad Resmi Sayfası](https://github.com/Kevin-Robertson/Powermad)
- [Active Directory Güvenliği](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
