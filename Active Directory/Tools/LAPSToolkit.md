# LAPSToolkit.ps1 Kullanım Rehberi

## LAPSToolkit.ps1 Nedir?

**LAPSToolkit.ps1**, Microsoft’un Local Administrator Password Solution (LAPS) özelliğini hedef alan bir PowerShell araç setidir. Bu araç, LAPS yapılandırmalarını analiz etmek, zafiyetleri tespit etmek ve Active Directory ortamlarında saklanan yerel yönetici şifrelerini keşfetmek için kullanılır. **LAPSToolkit**, sistem yöneticilerine güvenlik yapılandırmalarını test etme olanağı sunar ve saldırganların LAPS'ı kötüye kullanmasını simüle eder.

> **Önemli Not:** LAPSToolkit.ps1 yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **LAPS Yapılandırma Analizi:**
   - Active Directory'deki LAPS özelliklerini ve izinlerini kontrol eder.
2. **Yerel Yönetici Parolası Çıkarma:**
   - LAPS ile yönetilen şifreleri sorgular ve görüntüler.
3. **Zafiyet Analizi:**
   - Yanlış yapılandırılmış LAPS izinlerini tespit eder.

---

## İndirme ve Çalıştırma

LAPSToolkit.ps1, GitHub üzerinden indirilebilir:

- [https://github.com](https://github.com)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   git clone https://github.com/path/to/LAPSToolkit.git
   cd LAPSToolkit
   ```
2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\LAPSToolkit.ps1
   Invoke-LAPSToolkit
   ```

---

## Kullanım Parametreleri

### 1. **`-Domain`**
- Hedef domaini belirtir.

  **Kullanım:**
  ```powershell
  Invoke-LAPSToolkit -Domain example.com
  ```

### 2. **`-User`**
- LAPS şifrelerine erişimi olan kullanıcıları listeler.

  **Kullanım:**
  ```powershell
  Invoke-LAPSToolkit -User
  ```

### 3. **`-Password`**
- LAPS tarafından yönetilen yerel yönetici şifresini sorgular.

  **Kullanım:**
  ```powershell
  Invoke-LAPSToolkit -Password
  ```

### 4. **`-Audit`**
- LAPS yapılandırmasını analiz eder ve rapor oluşturur.

  **Kullanım:**
  ```powershell
  Invoke-LAPSToolkit -Audit
  ```

### 5. **`-Help`**
- Script’in yardım mesajını görüntüler.

  **Kullanım:**
  ```powershell
  Invoke-LAPSToolkit -Help
  ```

---

## Örnek Kullanım Senaryoları

### 1. LAPS Yönetilen Parolaları Görüntüleme
```powershell
Invoke-LAPSToolkit -Password
```

### 2. LAPS Kullanıcı İzinlerini Listeleme
```powershell
Invoke-LAPSToolkit -User
```

### 3. LAPS Yapılandırma Denetimi
```powershell
Invoke-LAPSToolkit -Audit
```

### 4. Yardım Mesajını Görüntüleme
```powershell
Invoke-LAPSToolkit -Help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** LAPSToolkit.ps1 yalnızca Active Directory yöneticileri veya yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Dikkatli olunmalıdır.

---

## Kaynaklar

- [Microsoft LAPS Hakkında Bilgi](https://learn.microsoft.com/en-us/windows-server/identity/laps/)
- [GitHub'da LAPS Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
