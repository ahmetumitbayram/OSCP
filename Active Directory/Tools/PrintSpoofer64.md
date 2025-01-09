# PrintSpoofer64.exe Kullanım Rehberi

## PrintSpoofer64.exe Nedir?

**PrintSpoofer64.exe**, Windows ortamlarında Print Spooler servisinin zafiyetlerini kullanarak yetki yükseltme (privilege escalation) saldırıları gerçekleştirmek için kullanılan bir araçtır. Bu araç, mevcut bir kullanıcı oturumundan SYSTEM yetkisi elde etmek için tasarlanmıştır. **PrintSpoofer**, özellikle Print Spooler servisinde bulunan "JuicyPotato" benzeri güvenlik açıklarını hedef alır.

> **Önemli Not:** PrintSpoofer64.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Yetki Yükseltme:**
   - Kullanıcı yetkisinden SYSTEM yetkisine geçiş sağlar.
2. **Hızlı ve Hafif:**
   - Minimal kaynak kullanımı ile etkili bir şekilde çalışır.
3. **Windows Print Spooler İstismarı:**
   - Print Spooler servisindeki bilinen zafiyetleri hedef alır.

---

## İndirme ve Çalıştırma

PrintSpoofer64.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır ve GitHub gibi kaynaklardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   PrintSpoofer64.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   PrintSpoofer64.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-i` veya `--interactive`**
- SYSTEM yetkisiyle etkileşimli bir komut istemi başlatır.

  **Kullanım:**
  ```cmd
  PrintSpoofer64.exe -i
  ```

### 2. **`-c` veya `--command`**
- Belirli bir komutu SYSTEM yetkisiyle çalıştırır.

  **Kullanım:**
  ```cmd
  PrintSpoofer64.exe -c "whoami"
  ```

### 3. **`-h` veya `--help`**
- Kullanım bilgilerini görüntüler.

  **Kullanım:**
  ```cmd
  PrintSpoofer64.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Etkileşimli Komut İstemi Başlatma
```cmd
PrintSpoofer64.exe -i
```

### 2. Belirli Bir Komutu SYSTEM Yetkisiyle Çalıştırma
```cmd
PrintSpoofer64.exe -c "net user administrator"
```

### 3. Yardım Mesajını Görüntüleme
```cmd
PrintSpoofer64.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PrintSpoofer64.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Windows Print Spooler Zafiyetleri](https://learn.microsoft.com/en-us/windows-server/identity/)
- [PrintSpoofer GitHub Sayfası](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
