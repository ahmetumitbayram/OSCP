# LockLess.exe Kullanım Rehberi

## LockLess.exe Nedir?

**LockLess.exe**, Windows ortamlarında çeşitli güvenlik yapılandırmalarını analiz etmek ve zafiyetleri tespit etmek için kullanılan bir araçtır. Özellikle oturum kilitleme, kimlik doğrulama, ve erişim kontrol mekanizmalarını hedef alır. Araç, sistem yöneticilerine ve güvenlik araştırmacılarına, sistemdeki güvenlik açıklarını test etme ve raporlama imkanı sunar.

> **Önemli Not:** LockLess.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Güvenlik Yapılandırmalarını Analiz Etme:**
   - Windows oturum ve kilitleme mekanizmalarını test eder.
2. **Erişim Kontrollerini Test Etme:**
   - Hedef sistemin erişim kontrol ayarlarını ve oturum politikalarını analiz eder.
3. **Kapsamlı Raporlama:**
   - Tespit edilen zafiyetleri raporlar.

---

## İndirme ve Çalıştırma

LockLess.exe, genellikle güvenlik araçlarının bir parçası olarak sağlanır ve [GitHub](https://github.com) gibi kaynaklardan indirilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   LockLess.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   LockLess.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-analyze`**
- Sistem yapılandırmalarını analiz eder.

  **Kullanım:**
  ```cmd
  LockLess.exe -analyze
  ```

### 2. **`-report`**
- Analiz sonuçlarını bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  LockLess.exe -report C:\Logs\lockless_report.txt
  ```

### 3. **`-test`**
- Hedef sistemde belirli bir güvenlik testini çalıştırır.

  **Kullanım:**
  ```cmd
  LockLess.exe -test session-lock
  ```

### 4. **`-help`**
- Araç kullanımına ilişkin yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  LockLess.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Sistem Yapılandırmalarını Analiz Etme
```cmd
LockLess.exe -analyze
```

### 2. Analiz Sonuçlarını Raporlama
```cmd
LockLess.exe -analyze -report C:\Logs\lockless_report.txt
```

### 3. Belirli Bir Güvenlik Testini Çalıştırma
```cmd
LockLess.exe -test session-lock
```

### 4. Yardım Mesajını Görüntüleme
```cmd
LockLess.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** LockLess.exe yalnızca sistem yöneticileri ve yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar ve sonuçlar sistem loglarına kaydedilebilir. Dikkatli olunmalıdır.

---

## Kaynaklar

- [Windows Güvenlik Ayarları ve Test Araçları](https://learn.microsoft.com/en-us/windows/security/)
- [GitHub Güvenlik Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
