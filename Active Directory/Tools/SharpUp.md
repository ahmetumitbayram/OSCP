# SharpUp.exe Kullanım Rehberi

## SharpUp.exe Nedir?

**SharpUp.exe**, Windows ortamında potansiyel yerel yetki yükseltme zafiyetlerini tespit etmek için kullanılan bir güvenlik aracıdır. Bu araç, sistem yapılandırmalarını analiz eder ve kullanıcıların mevcut yetkilerini yükseltebilecek açıkları belirler.

> **Önemli Not:** SharpUp.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Yetki Yükseltme Zafiyeti Analizi:**
   - Sistem yapılandırmalarını tarar ve yerel yetki yükseltme açıklarını listeler.
2. **Hızlı ve Hafif:**
   - Sistem kaynaklarını minimum düzeyde kullanarak hızlı analiz yapar.
3. **Detaylı Raporlama:**
   - Bulunan zafiyetler hakkında detaylı bilgi sunar.

---

## İndirme ve Çalıştırma

SharpUp.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpUp GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpUp.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpUp.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-scan`**
- Sistem genelinde yetki yükseltme açıklarını tarar.

  **Kullanım:**
  ```cmd
  SharpUp.exe -scan
  ```

### 2. **`-report`**
- Analiz sonuçlarını belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SharpUp.exe -scan -report findings.txt
  ```

### 3. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpUp.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Yetki Yükseltme Zafiyetlerini Tespit Etme
```cmd
SharpUp.exe -scan
```

### 2. Tarama Sonuçlarını Dosyaya Kaydetme
```cmd
SharpUp.exe -scan -report findings.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SharpUp.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpUp.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpUp GitHub Sayfası](https://github.com)
- [Windows Privilege Escalation Techniques](https://learn.microsoft.com/en-us/windows/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
