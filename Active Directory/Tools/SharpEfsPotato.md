# SharpEfsPotato.exe Kullanım Rehberi

## SharpEfsPotato.exe Nedir?

**SharpEfsPotato.exe**, Windows ortamında EFSRPC (Encrypting File System Remote Protocol) zafiyetlerini istismar ederek SYSTEM yetkisi elde etmek için kullanılan bir araçtır. Bu araç, özellikle PrintSpooler gibi zafiyetli hizmetlerle birlikte kullanılarak, düşük yetkili bir kullanıcıdan SYSTEM yetkisine geçiş yapılmasını sağlar.

> **Önemli Not:** SharpEfsPotato.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Yetki Yükseltme:**
   - EFSRPC üzerinden SYSTEM yetkisi elde etme.
2. **Hafif ve Hızlı:**
   - Minimal kaynak kullanımı ile etkili sonuçlar sağlar.
3. **Zafiyetli Hizmetlerle Entegrasyon:**
   - PrintSpooler gibi hizmetlerle uyumlu çalışır.

---

## İndirme ve Çalıştırma

SharpEfsPotato.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SharpEfsPotato GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpEfsPotato.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpEfsPotato.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-target`**
- Hedef makineyi veya IP adresini belirtir.

  **Kullanım:**
  ```cmd
  SharpEfsPotato.exe -target 192.168.1.10
  ```

### 2. **`-command`**
- SYSTEM yetkisiyle çalıştırılacak komutu belirtir.

  **Kullanım:**
  ```cmd
  SharpEfsPotato.exe -command "cmd.exe /c whoami"
  ```

### 3. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpEfsPotato.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hedef Makinede SYSTEM Yetkisi Elde Etme
```cmd
SharpEfsPotato.exe -target 192.168.1.10 -command "cmd.exe /c whoami"
```

### 2. Yardım Mesajını Görüntüleme
```cmd
SharpEfsPotato.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpEfsPotato.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpEfsPotato GitHub Sayfası](https://github.com)
- [Windows EFSRPC ve Güvenlik](https://learn.microsoft.com/en-us/windows/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
