# RunasCs.exe Kullanım Rehberi

## RunasCs.exe Nedir?

**RunasCs.exe**, Windows ortamlarında kimlik doğrulama ve yetkilendirme süreçlerini manipüle etmek için kullanılan bir araçtır. Özellikle farklı kullanıcı kimlik bilgileri ile işlemleri çalıştırmak ve belirli senaryolarda kimlik doğrulama mekanizmalarını test etmek için tasarlanmıştır. **RunasCs**, güvenlik uzmanlarının yetki yükseltme ve kullanıcı hesaplarının izinlerini analiz etmesine olanak tanır.

> **Önemli Not:** RunasCs.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Yetki Yükseltme:**
   - Belirli bir kullanıcı hesabıyla işlemler başlatır.
2. **Kimlik Bilgisi Manipülasyonu:**
   - Farklı kullanıcı kimlik bilgileriyle oturum açar ve işlemleri çalıştırır.
3. **Kimlik Doğrulama Testleri:**
   - Kimlik doğrulama mekanizmalarını test eder ve yapılandırma hatalarını analiz eder.

---

## İndirme ve Çalıştırma

RunasCs.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır ve GitHub gibi kaynaklardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   RunasCs.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   RunasCs.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`/user`**
- Belirli bir kullanıcı hesabıyla işlem başlatır.

  **Kullanım:**
  ```cmd
  RunasCs.exe /user:DOMAIN\UserName /password:Password123 /command:cmd.exe
  ```

### 2. **`/netonly`**
- Ağ kimlik doğrulaması için belirli bir kullanıcı hesabını kullanır.

  **Kullanım:**
  ```cmd
  RunasCs.exe /user:DOMAIN\UserName /password:Password123 /netonly /command:cmd.exe
  ```

### 3. **`/command`**
- Çalıştırılacak komutu belirtir.

  **Kullanım:**
  ```cmd
  RunasCs.exe /user:DOMAIN\UserName /password:Password123 /command:notepad.exe
  ```

### 4. **`/help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  RunasCs.exe /help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Belirli Bir Kullanıcı Hesabıyla Komut Çalıştırma
```cmd
RunasCs.exe /user:DOMAIN\UserName /password:Password123 /command:cmd.exe
```

### 2. Ağ Kimlik Doğrulaması İçin Kullanıcı Hesabı Kullanma
```cmd
RunasCs.exe /user:DOMAIN\UserName /password:Password123 /netonly /command:powershell.exe
```

### 3. Yardım Mesajını Görüntüleme
```cmd
RunasCs.exe /help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** RunasCs.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [RunasCs GitHub Sayfası](https://github.com)
- [Microsoft Kimlik Doğrulama ve Yetkilendirme](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
