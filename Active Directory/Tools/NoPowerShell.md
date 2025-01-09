# NoPowerShell.exe Kullanım Rehberi

## NoPowerShell.exe Nedir?

**NoPowerShell.exe**, PowerShell komutlarını çalıştırmak için PowerShell ortamına ihtiyaç duymayan bir araçtır. Windows sistemlerinde PowerShell’in devre dışı olduğu veya kısıtlandığı durumlarda, bu araç PowerShell komutlarını doğrudan çalıştırabilir. NoPowerShell, güvenlik araştırmaları ve kısıtlı ortamlarda test çalışmaları yapmak için ideal bir çözümdür.

> **Önemli Not:** NoPowerShell.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **PowerShell Alternatifi:**
   - PowerShell’e ihtiyaç duymadan komut çalıştırır.
2. **Minimalist ve Taşınabilir:**
   - Küçük boyutlu ve bağımlılık gerektirmez.
3. **Kısıtlı Ortamlar İçin Uygun:**
   - PowerShell’in devre dışı olduğu sistemlerde çalışabilir.

---

## İndirme ve Çalıştırma

NoPowerShell.exe, genellikle GitHub gibi açık kaynak platformlardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   NoPowerShell.exe dosyasını indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   NoPowerShell.exe <komut>
   ```

---

## Kullanım Parametreleri

### 1. **PowerShell Komutunu Çalıştırma**
- Herhangi bir PowerShell komutunu çalıştırır.

  **Kullanım:**
  ```cmd
  NoPowerShell.exe Get-Process
  ```

### 2. **Komut Çıktısını Dosyaya Kaydetme**
- Çıktıyı bir dosyaya yönlendirir.

  **Kullanım:**
  ```cmd
  NoPowerShell.exe Get-Service > C:\Logs\services.txt
  ```

### 3. **Yardım Mesajını Görüntüleme**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```cmd
  NoPowerShell.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Sistem Süreçlerini Listeleme
```cmd
NoPowerShell.exe Get-Process
```

### 2. Çalışan Servisleri Görüntüleme
```cmd
NoPowerShell.exe Get-Service
```

### 3. Komut Çıktısını Dosyaya Kaydetme
```cmd
NoPowerShell.exe Get-Process > C:\Logs\processes.txt
```

### 4. Yardım Mesajını Görüntüleme
```cmd
NoPowerShell.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** NoPowerShell.exe yalnızca yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PowerShell Komutları ve Alternatif Araçlar](https://learn.microsoft.com/en-us/powershell/)
- [GitHub Güvenlik Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.

