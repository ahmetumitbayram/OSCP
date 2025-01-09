# SharpChrome.exe Kullanım Rehberi

## SharpChrome.exe Nedir?

**SharpChrome.exe**, Google Chrome tarayıcısındaki kullanıcı kimlik bilgilerini ve diğer hassas bilgileri toplamak için kullanılan bir güvenlik değerlendirme aracıdır. Bu araç, güvenlik uzmanlarına Chrome profillerinden parola, çerez ve oturum bilgilerini analiz etme imkanı sunar.

> **Önemli Not:** SharpChrome.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Parola Toplama:**
   - Chrome tarayıcısında kaydedilen parolaları çıkarır.
2. **Çerez Analizi:**
   - Web uygulamalarında oturum yönetimini test etmek için çerez bilgilerini toplar.
3. **Kullanıcı Profili Bilgisi:**
   - Chrome kullanıcı profilleriyle ilişkili hassas bilgileri analiz eder.

---

## İndirme ve Çalıştırma

SharpChrome.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SharpChrome GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpChrome.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpChrome.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`dump`**
- Chrome'da kaydedilen tüm parolaları ve çerez bilgilerini döker.

  **Kullanım:**
  ```cmd
  SharpChrome.exe dump
  ```

### 2. **`cookies`**
- Chrome profillerinde saklanan çerezleri çıkarır.

  **Kullanım:**
  ```cmd
  SharpChrome.exe cookies
  ```

### 3. **`passwords`**
- Chrome'da kaydedilen parolaları döker.

  **Kullanım:**
  ```cmd
  SharpChrome.exe passwords
  ```

### 4. **`-output`**
- Çıktıyı bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SharpChrome.exe dump -output credentials.txt
  ```

### 5. **`-h` veya `--help`**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```cmd
  SharpChrome.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm Parola ve Çerez Bilgilerini Çıkarma
```cmd
SharpChrome.exe dump
```

### 2. Çerez Bilgilerini Çıkarma
```cmd
SharpChrome.exe cookies
```

### 3. Parolaları Çıkarma
```cmd
SharpChrome.exe passwords
```

### 4. Çıktıyı Dosyaya Kaydetme
```cmd
SharpChrome.exe dump -output credentials.txt
```

### 5. Yardım Mesajını Görüntüleme
```cmd
SharpChrome.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpChrome.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpChrome GitHub Sayfası](https://github.com)
- [Chrome Güvenliği ve Gizlilik](https://support.google.com/chrome/answer/114836)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
