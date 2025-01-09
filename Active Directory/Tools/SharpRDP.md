# SharpRDP.exe Kullanım Rehberi

## SharpRDP.exe Nedir?

**SharpRDP.exe**, Windows ortamında Uzak Masaüstü Protokolü (RDP) bağlantılarını başlatmak, analiz etmek ve potansiyel güvenlik açıklarını değerlendirmek için kullanılan bir araçtır. Bu araç, RDP oturumları üzerinde kontrol sağlamak ve kötü amaçlı yapılandırmaları tespit etmek için tasarlanmıştır.

> **Önemli Not:** SharpRDP.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **RDP Bağlantı Yönetimi:**
   - Belirli bir hedefe RDP bağlantısı kurar.
2. **Kimlik Bilgisi Kullanımı:**
   - Kullanıcı adı ve şifre ile doğrulama yapar.
3. **Otomasyon ve Testler:**
   - Güvenlik değerlendirmeleri ve otomatik test senaryoları için uygundur.

---

## İndirme ve Çalıştırma

SharpRDP.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpRDP GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpRDP.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpRDP.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-target`**
- Hedef makinenin adını veya IP adresini belirtir.

  **Kullanım:**
  ```cmd
  SharpRDP.exe -target 192.168.1.10
  ```

### 2. **`-username`**
- Kullanıcı adını belirtir.

  **Kullanım:**
  ```cmd
  SharpRDP.exe -target 192.168.1.10 -username Administrator
  ```

### 3. **`-password`**
- Şifreyi belirtir.

  **Kullanım:**
  ```cmd
  SharpRDP.exe -target 192.168.1.10 -username Administrator -password Password123
  ```

### 4. **`-command`**
- Hedef makinede çalıştırılacak komutu belirtir.

  **Kullanım:**
  ```cmd
  SharpRDP.exe -target 192.168.1.10 -username Administrator -password Password123 -command "cmd.exe /c whoami"
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpRDP.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hedef Makineye RDP Bağlantısı Kurma
```cmd
SharpRDP.exe -target 192.168.1.10 -username Administrator -password Password123
```

### 2. Hedef Makinede Komut Çalıştırma
```cmd
SharpRDP.exe -target 192.168.1.10 -username Administrator -password Password123 -command "cmd.exe /c whoami"
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SharpRDP.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpRDP.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpRDP GitHub Sayfası](https://github.com)
- [Microsoft RDP Yönetimi](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
