# PowerUpSQL.ps1 Kullanım Rehberi

## PowerUpSQL.ps1 Nedir?

**PowerUpSQL.ps1**, Microsoft SQL Server ortamlarında zafiyetleri tespit etmek ve istismar etmek için kullanılan bir PowerShell araç setidir. Bu araç, SQL Server’ların yapılandırma hatalarını, izin sorunlarını ve potansiyel güvenlik açıklarını analiz ederek saldırganların veya güvenlik uzmanlarının veri sızdırmasına veya yetki yükseltmesine olanak tanır.

> **Önemli Not:** PowerUpSQL.ps1 yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Zafiyet Tespiti:**
   - SQL Server’ların yanlış yapılandırılmış veya güvenli olmayan özelliklerini analiz eder.
2. **Yetki Yükseltme:**
   - Hatalı yapılandırılmış SQL Server izinlerini kullanarak SYSTEM yetkisine geçiş yapar.
3. **Bilgi Toplama:**
   - SQL Server veritabanları, kullanıcılar ve oturumlarla ilgili ayrıntılı bilgi toplar.

---

## İndirme ve Çalıştırma

PowerUpSQL.ps1, GitHub üzerinden indirilebilir:

- [https://github.com/NetSPI/PowerUpSQL](https://github.com/NetSPI/PowerUpSQL)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   git clone https://github.com/NetSPI/PowerUpSQL.git
   cd PowerUpSQL
   ```

2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\PowerUpSQL.ps1
   ```

---

## Kullanım Parametreleri

### 1. **`Get-SQLInstanceDomain`**
- Active Directory’deki SQL Server örneklerini arar.

  **Kullanım:**
  ```powershell
  Get-SQLInstanceDomain
  ```

### 2. **`Get-SQLQuery`**
- Belirli bir SQL Server üzerinde özel sorgular çalıştırır.

  **Kullanım:**
  ```powershell
  Get-SQLQuery -InstanceName "SQLSERVER\INSTANCE" -Query "SELECT name FROM sys.databases"
  ```

### 3. **`Get-SQLServerInfo`**
- Hedef SQL Server hakkında bilgi toplar.

  **Kullanım:**
  ```powershell
  Get-SQLServerInfo -InstanceName "SQLSERVER\INSTANCE"
  ```

### 4. **`Invoke-SQLEscalatePriv`**
- Yetki yükseltme saldırılarını otomatik olarak gerçekleştirir.

  **Kullanım:**
  ```powershell
  Invoke-SQLEscalatePriv -InstanceName "SQLSERVER\INSTANCE"
  ```

### 5. **`-Help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```powershell
  Get-Help Get-SQLInstanceDomain
  ```

---

## Örnek Kullanım Senaryoları

### 1. SQL Server Örneklerini Bulma
```powershell
Get-SQLInstanceDomain
```

### 2. SQL Server Hakkında Bilgi Toplama
```powershell
Get-SQLServerInfo -InstanceName "SQLSERVER\INSTANCE"
```

### 3. Özel Bir SQL Sorgusu Çalıştırma
```powershell
Get-SQLQuery -InstanceName "SQLSERVER\INSTANCE" -Query "SELECT name FROM sys.databases"
```

### 4. Yetki Yükseltme Saldırısı Gerçekleştirme
```powershell
Invoke-SQLEscalatePriv -InstanceName "SQLSERVER\INSTANCE"
```

### 5. Yardım Mesajını Görüntüleme
```powershell
Get-Help Get-SQLInstanceDomain
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PowerUpSQL.ps1 yalnızca güvenlik uzmanları ve sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PowerUpSQL Resmi Sayfası](https://github.com/NetSPI/PowerUpSQL)
- [Microsoft SQL Server Güvenliği](https://learn.microsoft.com/en-us/sql/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
