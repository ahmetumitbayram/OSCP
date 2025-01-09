# SpoolSample.exe Kullanım Rehberi

## SpoolSample.exe Nedir?

**SpoolSample.exe**, Windows ortamında Print Spooler hizmetini hedef alarak çeşitli güvenlik değerlendirmeleri ve testleri gerçekleştirmek için kullanılan bir araçtır. Bu araç, genellikle Print Spooler hizmetindeki potansiyel zafiyetleri analiz etmek veya sömürmek için kullanılır.

> **Önemli Not:** SpoolSample.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Print Spooler Zafiyet Analizi:**
   - Print Spooler hizmetindeki güvenlik açıklarını tespit eder.
2. **Uzaktan Komut Yürütme:**
   - Print Spooler üzerinden uzaktan komut çalıştırır.
3. **Test ve Eğitim Amaçlı Kullanım:**
   - Güvenlik ekipleri için eğitim ve test senaryoları oluşturur.

---

## İndirme ve Çalıştırma

SpoolSample.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SpoolSample GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SpoolSample.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SpoolSample.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-target`**
- Hedef makinenin adını veya IP adresini belirtir.

  **Kullanım:**
  ```cmd
  SpoolSample.exe -target 192.168.1.10
  ```

### 2. **`-exec`**
- Hedef makinede yürütülecek komutu belirtir.

  **Kullanım:**
  ```cmd
  SpoolSample.exe -target 192.168.1.10 -exec "cmd.exe /c whoami"
  ```

### 3. **`-test`**
- Print Spooler hizmetini test etmek için kullanılır.

  **Kullanım:**
  ```cmd
  SpoolSample.exe -test
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SpoolSample.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hedef Makinede Print Spooler Zafiyetlerini Test Etme
```cmd
SpoolSample.exe -target 192.168.1.10 -test
```

### 2. Uzaktan Komut Yürütme
```cmd
SpoolSample.exe -target 192.168.1.10 -exec "cmd.exe /c whoami"
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SpoolSample.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SpoolSample.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Print Spooler Güvenlik Açıkları](https://learn.microsoft.com/en-us/windows/)
- [SpoolSample GitHub Sayfası](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
