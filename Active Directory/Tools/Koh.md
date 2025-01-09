# Koh.exe Kullanım Rehberi

## Koh.exe Nedir?

**Koh.exe**, Windows ortamlarında kimlik bilgilerini ele geçirmek veya belirli kimlik doğrulama işlemlerini analiz etmek için kullanılan bir araçtır. Bu araç, çeşitli güvenlik zafiyetlerini test etmek, analiz yapmak ve kimlik bilgisi tabanlı saldırılar için uygun bir platform sağlar. Koh.exe, özellikle Windows kimlik doğrulama mekanizmaları ve oturum verilerini hedef alır.

> **Önemli Not:** Koh.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır ve ciddi sonuçlara yol açabilir.

---

## Ana Özellikleri

1. **Kimlik Bilgisi Analizi:**
   - Hedef sistemdeki kimlik doğrulama süreçlerini analiz eder.
2. **Credential Dumping:**
   - Bellekten kimlik bilgilerini çıkarır.
3. **Hafif ve Hızlı:**
   - Minimal kaynak kullanımı ile etkili analiz sunar.

---

## İndirme ve Çalıştırma

Koh.exe, araştırma toplulukları veya güvenlik ekipleri tarafından özel olarak dağıtılır. Araç, genellikle güvenilir bir kaynaktan edinilmelidir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   Koh.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   Koh.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-analyze`**
- Sistemdeki oturum bilgilerini ve kimlik doğrulama süreçlerini analiz eder.

  **Kullanım:**
  ```cmd
  Koh.exe -analyze
  ```

### 2. **`-dump`**
- Bellekteki kimlik bilgilerini döker.

  **Kullanım:**
  ```cmd
  Koh.exe -dump
  ```

### 3. **`-output`**
- Çıktıyı belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  Koh.exe -output C:\Logs\koh_output.txt
  ```

### 4. **`-help`**
- Araç ile ilgili yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  Koh.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kimlik Bilgilerini Dökme
```cmd
Koh.exe -dump -output C:\Logs\koh_dump.txt
```

### 2. Oturum Bilgilerini Analiz Etme
```cmd
Koh.exe -analyze
```

### 3. Yardım Mesajını Görüntüleme
```cmd
Koh.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Koh.exe yalnızca yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Dikkatli olunmalıdır.

---

## Kaynaklar

- [Kimlik Bilgisi Yönetimi ve Güvenlik](https://learn.microsoft.com/en-us/)
- [Güvenlik Araçları ve Teknikleri](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
