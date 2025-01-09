# KeeTheft.exe Kullanım Rehberi

## KeeTheft.exe Nedir?

**KeeTheft.exe**, KeePass şifre yöneticisini hedef alan bir araçtır. KeePass, kullanıcıların şifrelerini güvenli bir şekilde saklamak için kullanılan popüler bir yazılımdır. KeeTheft, aktif bir KeePass oturumu sırasında bellekte depolanan şifre verilerini çıkarmak için tasarlanmıştır. Araç, KeePass kullanıcılarının oturum açtığı sırada çalıştırılır ve şifrelenmiş veritabanının çözülmüş hallerine erişim sağlar.

> **Önemli Not:** KeeTheft.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **KeePass Bellek Çözümlemesi:**
   - KeePass tarafından bellekte saklanan şifreleri hedef alır.
2. **Hızlı ve Hafif:**
   - Minimal sistem kaynakları kullanır.
3. **Doğrudan Çıkarma:**
   - Aktif oturum sırasında şifreleri doğrudan çıkarır.

---

## İndirme ve Çalıştırma

KeeTheft.exe, araştırma ve güvenlik testlerinde kullanılan özel bir araçtır ve genellikle özel kaynaklardan elde edilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   KeeTheft.exe’yi sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   KeeTheft.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-process`**
- KeePass sürecini hedefler.

  **Kullanım:**
  ```cmd
  KeeTheft.exe -process KeePass.exe
  ```

### 2. **`-output`**
- Çıkarılan şifrelerin kaydedileceği dosyayı belirtir.

  **Kullanım:**
  ```cmd
  KeeTheft.exe -output C:\Logs\keethief_output.txt
  ```

### 3. **`-help`**
- Araç kullanımına ilişkin yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  KeeTheft.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. KeePass Belleğini Analiz Etme
```cmd
KeeTheft.exe -process KeePass.exe
```

### 2. Çıkarılan Şifreleri Bir Dosyaya Kaydetme
```cmd
KeeTheft.exe -process KeePass.exe -output C:\Logs\keethief_output.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
KeeTheft.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** KeeTheft.exe yalnızca güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Kapsama Alanı:** Araç yalnızca aktif KeePass oturumlarında çalışır. KeePass kilitliyse çalışmaz.

---

## Kaynaklar

- [KeePass Resmi Web Sitesi](https://keepass.info)
- [Şifre Yöneticileri ve Güvenlik Zafiyetleri](https://learn.microsoft.com/en-us/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
