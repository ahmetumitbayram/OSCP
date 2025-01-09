# PowerUp.ps1 Kullanım Rehberi

## PowerUp.ps1 Nedir?

**PowerUp.ps1**, Windows ortamlarında yetki yükseltme (privilege escalation) testleri yapmak için kullanılan bir PowerShell scriptidir. Bu araç, yanlış yapılandırılmış servisler, erişim izinleri, ve diğer güvenlik açıklarını tespit ederek saldırganların veya güvenlik uzmanlarının SYSTEM yetkisi kazanmasına yardımcı olabilir.

> **Önemli Not:** PowerUp.ps1 yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Zafiyet Tespiti:**
   - Yanlış yapılandırılmış servisleri ve güvenlik açıklarını tespit eder.
2. **Yetki Yükseltme:**
   - Sistem üzerinde yetki yükseltme yollarını analiz eder.
3. **Hızlı ve Kolay Kullanım:**
   - Komutlar aracılığıyla hızlıca bilgi sağlar.

---

## İndirme ve Çalıştırma

PowerUp.ps1, GitHub üzerinden indirilebilir:

- [https://github.com/PowerShellMafia/PowerSploit](https://github.com/PowerShellMafia/PowerSploit)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   git clone https://github.com/PowerShellMafia/PowerSploit.git
   cd PowerSploit\Privesc
   ```
2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\PowerUp.ps1
   Invoke-AllChecks
   ```

---

## Kullanım Parametreleri

### 1. **`Invoke-AllChecks`**
- Sistem üzerinde tüm yetki yükseltme kontrollerini gerçekleştirir.

  **Kullanım:**
  ```powershell
  Invoke-AllChecks
  ```

### 2. **`Invoke-ServiceAbuse`**
- Yanlış yapılandırılmış servisleri analiz eder ve istismar eder.

  **Kullanım:**
  ```powershell
  Invoke-ServiceAbuse -Name "VulnerableService"
  ```

### 3. **`Get-ServiceDetail`**
- Belirli bir servisin detaylarını görüntüler.

  **Kullanım:**
  ```powershell
  Get-ServiceDetail -Name "ServiceName"
  ```

### 4. **`Invoke-ScheduledTaskAbuse`**
- Yanlış yapılandırılmış zamanlanmış görevleri istismar eder.

  **Kullanım:**
  ```powershell
  Invoke-ScheduledTaskAbuse
  ```

### 5. **`-Help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```powershell
  Get-Help Invoke-AllChecks
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm Yetki Yükseltme Kontrollerini Çalıştırma
```powershell
Invoke-AllChecks
```

### 2. Servis Detaylarını Görüntüleme
```powershell
Get-ServiceDetail -Name "VulnerableService"
```

### 3. Zamanlanmış Görevleri İstismar Etme
```powershell
Invoke-ScheduledTaskAbuse
```

### 4. Yardım Mesajını Görüntüleme
```powershell
Get-Help Invoke-AllChecks
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PowerUp.ps1 yalnızca güvenlik uzmanları ve sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PowerSploit Resmi Sayfası](https://github.com/PowerShellMafia/PowerSploit)
- [Windows Yetki Yükseltme Teknikleri](https://learn.microsoft.com/en-us/windows/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
