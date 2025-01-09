# SharpWMI.exe Kullanım Rehberi

## SharpWMI.exe Nedir?

**SharpWMI.exe**, Windows ortamında WMI (Windows Management Instrumentation) sorguları ve işlemleri gerçekleştirmek için kullanılan bir araçtır. Bu araç, sistem yönetimi görevlerini otomatikleştirmek, bilgi toplamak ve uzaktan komut yürütmek için kullanılır.

> **Önemli Not:** SharpWMI.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **WMI Sorguları:**
   - Sistem bilgilerini ve yapılandırmalarını toplamak için WMI sorguları gerçekleştirir.
2. **Uzaktan Komut Yürütme:**
   - WMI kullanarak hedef sistemlerde komut çalıştırır.
3. **Bilgi Toplama ve Analiz:**
   - WMI üzerinden çeşitli sistem metriklerini analiz eder.

---

## İndirme ve Çalıştırma

SharpWMI.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpWMI GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpWMI.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpWMI.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-query`**
- Belirli bir WMI sorgusu gerçekleştirir.

  **Kullanım:**
  ```cmd
  SharpWMI.exe -query "SELECT * FROM Win32_OperatingSystem"
  ```

### 2. **`-exec`**
- WMI kullanarak hedef sistemde komut yürütür.

  **Kullanım:**
  ```cmd
  SharpWMI.exe -exec "cmd.exe /c whoami" -target 192.168.1.10
  ```

### 3. **`-namespace`**
- WMI namespace belirtir.

  **Kullanım:**
  ```cmd
  SharpWMI.exe -query "SELECT * FROM Win32_Process" -namespace "root\cimv2"
  ```

### 4. **`-target`**
- Hedef makineyi belirtir.

  **Kullanım:**
  ```cmd
  SharpWMI.exe -target 192.168.1.10
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpWMI.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. WMI Sorgusu Gerçekleştirme
```cmd
SharpWMI.exe -query "SELECT * FROM Win32_OperatingSystem"
```

### 2. Hedef Sistemde Komut Yürütme
```cmd
SharpWMI.exe -exec "cmd.exe /c whoami" -target 192.168.1.10
```

### 3. Belirli Bir Namespace Üzerinden Sorgu Yapma
```cmd
SharpWMI.exe -query "SELECT * FROM Win32_Process" -namespace "root\cimv2"
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpWMI.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpWMI.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpWMI GitHub Sayfası](https://github.com)
- [Windows Management Instrumentation Documentation](https://learn.microsoft.com/en-us/windows/win32/wmisdk/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
