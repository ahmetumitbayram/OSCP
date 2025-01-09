# SharpDPAPI.exe Kullanım Rehberi

## SharpDPAPI.exe Nedir?

**SharpDPAPI.exe**, Windows Data Protection API (DPAPI) mekanizmalarını hedef alarak, kullanıcı ve sistem kimlik bilgilerini çözmek ve analiz etmek için kullanılan bir araçtır. Bu araç, DPAPI korumalı verileri (ör. tarayıcı şifreleri, Wi-Fi şifreleri, sertifikalar) çözmek için güvenlik araştırmacıları ve sistem yöneticileri tarafından kullanılır.

> **Önemli Not:** SharpDPAPI.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **DPAPI Veri Çözme:**
   - DPAPI ile şifrelenmiş kullanıcı ve sistem verilerini çözer.
2. **Kimlik Bilgisi Analizi:**
   - Chrome, Wi-Fi, RDP gibi uygulamalarda saklanan hassas bilgileri çıkarır.
3. **Master Key Yönetimi:**
   - DPAPI anahtarlarını çıkarır ve şifre çözme işlemleri için kullanır.

---

## İndirme ve Çalıştırma

SharpDPAPI.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SharpDPAPI GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpDPAPI.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpDPAPI.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`masterkeys`**
- DPAPI Master Key'leri çıkarır ve görüntüler.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe masterkeys
  ```

### 2. **`credentials`**
- Windows kimlik bilgilerini çözer ve listeler.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe credentials
  ```

### 3. **`vaults`**
- Windows Vault'daki saklı kimlik bilgilerini çözer.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe vaults
  ```

### 4. **`chrome`**
- Chrome tarayıcısındaki saklı şifreleri ve çerezleri çözer.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe chrome
  ```

### 5. **`-file`**
- Belirli bir dosyayı çözmek için kullanılır.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe -file <dosya_yolu>
  ```

### 6. **`-help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```cmd
  SharpDPAPI.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. DPAPI Master Key'lerini Çıkarma
```cmd
SharpDPAPI.exe masterkeys
```

### 2. Windows Kimlik Bilgilerini Çözme
```cmd
SharpDPAPI.exe credentials
```

### 3. Windows Vault Verilerini Listeleme
```cmd
SharpDPAPI.exe vaults
```

### 4. Chrome Şifrelerini ve Çerezlerini Çözme
```cmd
SharpDPAPI.exe chrome
```

### 5. Belirli Bir Dosyayı Çözme
```cmd
SharpDPAPI.exe -file C:\Path\To\EncryptedFile
```

### 6. Yardım Mesajını Görüntüleme
```cmd
SharpDPAPI.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpDPAPI.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpDPAPI GitHub Sayfası](https://github.com)
- [Windows DPAPI Mekanizmaları](https://learn.microsoft.com/en-us/windows/win32/secbp/data-protection-api)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
