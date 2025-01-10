# WinPEAS Kullanım Rehberi

## WinPEAS Nedir?

**WinPEAS (Windows Privilege Escalation Awesome Scripts)**, Windows sistemlerinde yetki yükseltme zafiyetlerini tespit etmek için kullanılan bir betiktir. Bu araç, sistem yapılandırmalarını analiz ederek potansiyel güvenlik açıklarını hızlı bir şekilde tespit etmek amacıyla tasarlanmıştır.

> **Önemli Not:** WinPEAS yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Yetki Yükseltme Zafiyeti Tespiti:**
   - Sistem yapılandırmalarını tarar ve yetki yükseltme için kullanılabilecek açıkları belirler.
2. **Hızlı ve Detaylı Tarama:**
   - Windows ortamında kullanıcı haklarından faydalanarak geniş bir veri yelpazesi toplar.
3. **Renkli ve Anlaşılır Çıktı:**
   - Önemli bulguları vurgulayarak analizi kolaylaştırır.

---

## İndirme ve Çalıştırma

WinPEAS genellikle GitHub gibi kaynaklardan sağlanır:

- [WinPEAS GitHub Sayfası](https://github.com/carlospolop/PEASS-ng)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   WinPEAS'i GitHub'dan indirin ve uygun bir dizine kaydedin.

2. **PowerShell veya CMD ile Çalıştırın:**
   ```cmd
   winpeas.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-h` veya `--help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  winpeas.exe -h
  ```

### 2. **`-fast`**
- Hızlı bir tarama gerçekleştirir.

  **Kullanım:**
  ```cmd
  winpeas.exe -fast
  ```

### 3. **`-cmd`**
- Komut satırı tabanlı bilgileri toplar.

  **Kullanım:**
  ```cmd
  winpeas.exe -cmd
  ```

### 4. **`-systeminfo`**
- Sistem bilgilerini detaylı bir şekilde toplar.

  **Kullanım:**
  ```cmd
  winpeas.exe -systeminfo
  ```

### 5. **`-services`**
- Servisleri analiz eder ve potansiyel açıkları belirler.

  **Kullanım:**
  ```cmd
  winpeas.exe -services
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hızlı Yetki Yükseltme Taraması
```cmd
winpeas.exe -fast
```

### 2. Sistem Bilgilerini Toplama
```cmd
winpeas.exe -systeminfo
```

### 3. Servisleri Analiz Etme
```cmd
winpeas.exe -services
```

### 4. Yardım Mesajını Görüntüleme
```cmd
winpeas.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** WinPEAS yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [WinPEAS GitHub Sayfası](https://github.com/carlospolop/PEASS-ng)
- [Windows Güvenlik Açıkları](https://learn.microsoft.com/en-us/windows/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
