# SharpDump.exe Kullanım Rehberi

## SharpDump.exe Nedir?

**SharpDump.exe**, Windows ortamında LSASS (Local Security Authority Subsystem Service) belleğini dökerek, hassas kimlik bilgilerini çıkarmak ve analiz etmek için kullanılan bir araçtır. Bu araç, özellikle Mimikatz ile uyumlu olarak çalışacak şekilde tasarlanmıştır ve LSASS'dan alınan dökümü analiz etmek için kullanılır.

> **Önemli Not:** SharpDump.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **LSASS Bellek Dökümü:**
   - LSASS sürecinden bellek dökümü alır.
2. **Mimikatz Uyumluluğu:**
   - Döküm dosyalarını Mimikatz ile analiz etmek için kullanıma hazır hale getirir.
3. **Hızlı ve Etkili:**
   - Sistem performansını etkilemeden hızlıca işlem yapar.

---

## İndirme ve Çalıştırma

SharpDump.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SharpDump GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpDump.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpDump.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-output`**
- LSASS bellek dökümünü belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SharpDump.exe -output lsass_dump.dmp
  ```

### 2. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpDump.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. LSASS Bellek Dökümü Almak
```cmd
SharpDump.exe -output lsass_dump.dmp
```

### 2. Yardım Mesajını Görüntüleme
```cmd
SharpDump.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpDump.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpDump GitHub Sayfası](https://github.com)
- [Windows LSASS ve Güvenlik](https://learn.microsoft.com/en-us/windows/security/identity-protection/lsass/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
