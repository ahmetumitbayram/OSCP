# SCMUACBypass.exe Kullanım Rehberi

## SCMUACBypass.exe Nedir?

**SCMUACBypass.exe**, Windows ortamlarında User Account Control (UAC) mekanizmasını bypass etmek ve yüksek yetkili işlemler gerçekleştirmek için kullanılan bir araçtır. Bu araç, Service Control Manager (SCM) ile etkileşime geçerek UAC korumalarını aşar ve güvenlik açıklarını test etmek için kullanılır.

> **Önemli Not:** SCMUACBypass.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **UAC Bypass:**
   - UAC korumalarını aşarak SYSTEM yetkileri ile işlem gerçekleştirir.
2. **SCM Manipülasyonu:**
   - Service Control Manager kullanarak hizmet manipülasyonu yapar.
3. **Yetki Yükseltme:**
   - Düşük yetkili bir kullanıcı oturumundan yüksek yetkili bir oturuma geçiş sağlar.

---

## İndirme ve Çalıştırma

SCMUACBypass.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır ve GitHub gibi kaynaklardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   SCMUACBypass.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   SCMUACBypass.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`/execute`**
- Belirli bir komutu yüksek yetkilerle çalıştırır.

  **Kullanım:**
  ```cmd
  SCMUACBypass.exe /execute "cmd.exe /c whoami"
  ```

### 2. **`/service`**
- Belirtilen bir servisi manipüle eder.

  **Kullanım:**
  ```cmd
  SCMUACBypass.exe /service MyService
  ```

### 3. **`/help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SCMUACBypass.exe /help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Komut Çalıştırarak Yetki Yükseltme
```cmd
SCMUACBypass.exe /execute "cmd.exe /c whoami"
```

### 2. Belirli Bir Servisi Manipüle Etme
```cmd
SCMUACBypass.exe /service MyService
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SCMUACBypass.exe /help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SCMUACBypass.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SCMUACBypass GitHub Sayfası](https://github.com)
- [Microsoft UAC ve Güvenlik Mekanizmaları](https://learn.microsoft.com/en-us/windows/security/identity-protection/user-account-control/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
