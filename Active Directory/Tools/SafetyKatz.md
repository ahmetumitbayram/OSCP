# SafetyKatz.exe Kullanım Rehberi

## SafetyKatz.exe Nedir?

**SafetyKatz.exe**, Windows ortamında kimlik bilgilerini çıkarmak ve analiz etmek için kullanılan bir araçtır. **SafetyKatz**, Mimikatz tabanlı bir uygulamadır ve genellikle kimlik bilgisi güvenliğini test etmek veya analiz etmek için kullanılır. Bu araç, LSASS (Local Security Authority Subsystem Service) belleğinden kimlik bilgilerini çekmek için tasarlanmıştır.

> **Önemli Not:** SafetyKatz.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kimlik Bilgisi Çıkarma:**
   - LSASS belleğinden kimlik bilgilerini çeker.
2. **Hafif ve Taşınabilir:**
   - Minimal bağımlılıklarla çalışan kompakt bir araçtır.
3. **Mimikatz Özellikleri:**
   - Mimikatz'in birçok özelliğini modern ve güvenli bir biçimde sunar.

---

## İndirme ve Çalıştırma

SafetyKatz.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SafetyKatz GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SafetyKatz.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SafetyKatz.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **Kimlik Bilgisi Çıkarma**
- LSASS belleğinden kimlik bilgilerini çıkarır.

  **Kullanım:**
  ```cmd
  SafetyKatz.exe dump
  ```

### 2. **Çıktıları Loglama**
- Çıkarılan kimlik bilgilerini bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SafetyKatz.exe dump -o credentials.txt
  ```

### 3. **Yardım Mesajını Görüntüleme**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```cmd
  SafetyKatz.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. LSASS Belleğinden Kimlik Bilgilerini Çıkarma
```cmd
SafetyKatz.exe dump
```

### 2. Çıktıları Dosyaya Kaydetme
```cmd
SafetyKatz.exe dump -o credentials.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SafetyKatz.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SafetyKatz.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SafetyKatz GitHub Sayfası](https://github.com)
- [Mimikatz ve Güvenlik Araçları](https://learn.microsoft.com/en-us/windows-server/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
