# SharpMad.exe Kullanım Rehberi

## SharpMad.exe Nedir?

**SharpMad.exe**, Windows ortamında belirli güvenlik açıklarını ve zafiyetleri değerlendirmek için kullanılan bir araçtır. Active Directory ve sistem güvenliği üzerinde analiz yaparak, potansiyel riskleri ve yapılandırma hatalarını tespit etmek için tasarlanmıştır.

> **Önemli Not:** SharpMad.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Analizi:**
   - Active Directory ortamındaki ilişkileri ve izin yapılandırmalarını analiz eder.
2. **Güvenlik Açığı Tespiti:**
   - Sistem yapılandırmalarında ve ağda potansiyel güvenlik açıklarını belirler.
3. **Hızlı ve Detaylı Raporlama:**
   - Bulunan zafiyetler hakkında detaylı bilgi sunar.

---

## İndirme ve Çalıştırma

SharpMad.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpMad GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpMad.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpMad.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-scan`**
- Sistem genelinde zafiyet taraması yapar.

  **Kullanım:**
  ```cmd
  SharpMad.exe -scan
  ```

### 2. **`-analyze`**
- Belirli bir hedef üzerinde detaylı analiz yapar.

  **Kullanım:**
  ```cmd
  SharpMad.exe -analyze -target 192.168.1.10
  ```

### 3. **`-output`**
- Analiz sonuçlarını belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SharpMad.exe -scan -output results.txt
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpMad.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Genel Bir Zafiyet Taraması Gerçekleştirme
```cmd
SharpMad.exe -scan
```

### 2. Belirli Bir Hedefin Detaylı Analizini Yapma
```cmd
SharpMad.exe -analyze -target 192.168.1.10
```

### 3. Analiz Sonuçlarını Dosyaya Kaydetme
```cmd
SharpMad.exe -scan -output results.txt
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpMad.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpMad.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpMad GitHub Sayfası](https://github.com)
- [Windows Güvenlik Belgelendirme](https://learn.microsoft.com/en-us/windows/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
