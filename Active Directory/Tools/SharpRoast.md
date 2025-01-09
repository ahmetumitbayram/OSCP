# SharpRoast.exe Kullanım Rehberi

## SharpRoast.exe Nedir?

**SharpRoast.exe**, Windows Active Directory ortamlarında Kerberoasting saldırıları gerçekleştirmek için kullanılan bir araçtır. Bu araç, AD içerisindeki hizmet hesaplarının TGS (Ticket Granting Service) biletlerini toplar ve offline parola kırma işlemleri için uygun hale getirir.

> **Önemli Not:** SharpRoast.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kerberoasting:**
   - Hizmet hesaplarına ait TGS biletlerini toplar.
2. **Parola Kırma:**
   - Toplanan biletler, offline olarak parola kırma işlemlerine uygundur.
3. **Active Directory Entegrasyonu:**
   - AD ortamında hızlı ve etkili bir bilgi toplama süreci sağlar.

---

## İndirme ve Çalıştırma

SharpRoast.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpRoast GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpRoast.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpRoast.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-domain`**
- Hedef Active Directory domain adını belirtir.

  **Kullanım:**
  ```cmd
  SharpRoast.exe -domain example.local
  ```

### 2. **`-user`**
- Kullanıcı adını belirtir.

  **Kullanım:**
  ```cmd
  SharpRoast.exe -domain example.local -user username
  ```

### 3. **`-password`**
- Kullanıcı şifresini belirtir.

  **Kullanım:**
  ```cmd
  SharpRoast.exe -domain example.local -user username -password Password123
  ```

### 4. **`-output`**
- Toplanan biletlerin kaydedileceği dosyayı belirtir.

  **Kullanım:**
  ```cmd
  SharpRoast.exe -output tickets.txt
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpRoast.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kerberoasting için TGS Biletlerini Toplama
```cmd
SharpRoast.exe -domain example.local -user admin -password Password123 -output tickets.txt
```

### 2. Yardım Mesajını Görüntüleme
```cmd
SharpRoast.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpRoast.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpRoast GitHub Sayfası](https://github.com)
- [Microsoft Kerberos](https://learn.microsoft.com/en-us/windows-server/security/kerberos/kerberos-authentication-overview)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
