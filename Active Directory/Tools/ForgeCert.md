# ForgeCert.exe Kullanım Rehberi

## ForgeCert.exe Nedir?

**ForgeCert.exe**, Windows ortamlarında dijital sertifikalar oluşturmak, düzenlemek ve analiz etmek için kullanılan bir araçtır. Özellikle sahte sertifikalar oluşturarak test senaryoları geliştirmek ve güvenlik açıklarını araştırmak amacıyla kullanılır. ForgeCert, aynı zamanda sertifika tabanlı saldırılar veya sertifika yapılandırmalarını analiz etmek için de değerlidir.

> **Önemli Not:** Bu araç yalnızca yetkili sistemlerde ve eğitim amaçlı kullanılmalıdır. Yetkisiz kullanım yasa dışıdır ve ciddi sonuçlara yol açabilir.

---

## Ana Özellikleri

1. **Sertifika Oluşturma:**
   - X.509 sertifikaları oluşturabilir.
2. **Sahte Sertifikalar Üretme:**
   - Test amaçlı sahte sertifikalar oluşturur.
3. **Sertifika İmzalama:**
   - Sertifika otoriteleri tarafından imzalanmış gibi görünen sahte sertifikalar üretir.
4. **Sertifika Çözümleme:**
   - Mevcut sertifikaların detaylarını analiz eder.

---

## İndirme ve Çalıştırma

ForgeCert.exe, genellikle güvenlik araçları koleksiyonlarında bulunabilir. Araç, [GitHub](https://github.com) gibi platformlardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   ForgeCert.exe dosyasını indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   ForgeCert.exe <parametreler>
   ```

---

## Kullanım Parametreleri

Aşağıda ForgeCert.exe’nin temel komutları ve parametreleri açıklanmıştır:

### 1. **`-generate`**
- Yeni bir sertifika oluşturur.

  **Kullanım:**
  ```cmd
  ForgeCert.exe -generate -subject "CN=TestCertificate" -output test_cert.cer
  ```

  **Parametreler:**
  - `-subject`: Sertifika sahibi bilgisi.
  - `-output`: Çıktı dosyasının adı.

### 2. **`-sign`**
- Bir sertifikayı imzalar.

  **Kullanım:**
  ```cmd
  ForgeCert.exe -sign -input test_cert.cer -ca ca_cert.cer -output signed_cert.cer
  ```

  **Parametreler:**
  - `-input`: İmzalanacak sertifika dosyası.
  - `-ca`: Sertifikayı imzalayacak otoritenin sertifikası.
  - `-output`: İmzalanmış sertifikanın adı.

### 3. **`-analyze`**
- Mevcut bir sertifikanın detaylarını analiz eder.

  **Kullanım:**
  ```cmd
  ForgeCert.exe -analyze -input test_cert.cer
  ```

  **Parametreler:**
  - `-input`: Analiz edilecek sertifika dosyası.

### 4. **`-help`**
- Tüm komutlar ve parametreler hakkında bilgi sağlar.

  **Kullanım:**
  ```cmd
  ForgeCert.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Yeni Bir Sertifika Oluşturma
```cmd
ForgeCert.exe -generate -subject "CN=TestCert" -output TestCert.cer
```

### 2. Bir Sertifikayı İmzalama
```cmd
ForgeCert.exe -sign -input TestCert.cer -ca CA_Cert.cer -output SignedTestCert.cer
```

### 3. Sertifika Detaylarını İnceleme
```cmd
ForgeCert.exe -analyze -input SignedTestCert.cer
```

### 4. Yardım Mesajını Görüntüleme
```cmd
ForgeCert.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** ForgeCert.exe yalnızca sertifika yönetimi ve güvenlik testleri için yetkili kullanıcılar tarafından kullanılmalıdır.
- **Loglama:** Araç çalıştırıldığında sistem loglarına kaydedilebilir. Gizlilik ihlallerinden kaçının.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmesi önerilir.

---

## Kaynaklar

- [ForgeCert GitHub Sayfası](https://github.com)
- [X.509 Sertifikaları Hakkında Bilgi](https://en.wikipedia.org/wiki/X.509)
- [Microsoft Docs - Sertifika Yönetimi](https://docs.microsoft.com/en-us/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
