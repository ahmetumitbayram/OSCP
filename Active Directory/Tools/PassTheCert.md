
## PassTheCert.exe Nedir?

**PassTheCert.exe**, Windows ortamlarında sertifika tabanlı kimlik doğrulama süreçlerini istismar etmek için kullanılan bir araçtır. Bu araç, Active Directory ortamlarında kullanılan sertifikaları manipüle ederek yetki yükseltme, kimlik doğrulama baypası ve yanal hareket gibi saldırılar gerçekleştirebilir. **PassTheCert.exe**, özellikle PKI (Public Key Infrastructure) yapılandırmalarını hedef alır.

> **Önemli Not:** PassTheCert.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Sertifika Tabanlı Kimlik Doğrulama:**
   - Mevcut sertifikaları kullanarak kimlik doğrulama gerçekleştirebilir.
2. **Yetki Yükseltme:**
   - Hatalı yapılandırılmış sertifikaları kullanarak yüksek yetkili erişimler elde eder.
3. **Kolay Entegrasyon:**
   - Minimal bağımlılıkla çalışır ve mevcut PKI altyapılarını hedef alır.

---

## İndirme ve Çalıştırma

PassTheCert.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır ve [GitHub](https://github.com) gibi platformlardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   PassTheCert.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   PassTheCert.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-cert`**
- Kullanılacak sertifikanın yolunu belirtir.

  **Kullanım:**
  ```cmd
  PassTheCert.exe -cert C:\Path\to\certificate.pfx
  ```

### 2. **`-password`**
- Sertifika için gerekli parolayı belirtir.

  **Kullanım:**
  ```cmd
  PassTheCert.exe -cert C:\Path\to\certificate.pfx -password YourPassword
  ```

### 3. **`-target`**
- Hedef sunucuyu veya sistemi belirtir.

  **Kullanım:**
  ```cmd
  PassTheCert.exe -target target.domain.local
  ```

### 4. **`-output`**
- Çıktıyı belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  PassTheCert.exe -output C:\Logs\output.txt
  ```

### 5. **`-help`**
- Araç kullanımına ilişkin yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  PassTheCert.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Sertifika Kullanarak Kimlik Doğrulama
```cmd
PassTheCert.exe -cert C:\Path\to\certificate.pfx -password YourPassword -target target.domain.local
```

### 2. Çıktıyı Dosyaya Kaydetme
```cmd
PassTheCert.exe -cert C:\Path\to\certificate.pfx -password YourPassword -output C:\Logs\output.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
PassTheCert.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PassTheCert.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar ve sonuçlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PKI ve Sertifika Yönetimi](https://learn.microsoft.com/en-us/windows-server/security/pki/)
- [GitHub Güvenlik Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
