# SharpLAPS.exe Kullanım Rehberi

## SharpLAPS.exe Nedir?

**SharpLAPS.exe**, Windows ortamında Local Administrator Password Solution (LAPS) yapılandırmalarını hedef alan bir araçtır. Bu araç, LAPS tarafından korunan yerel yönetici parolalarını çekmek, analiz etmek ve güvenlik açıklarını tespit etmek için tasarlanmıştır. **SharpLAPS**, LAPS yapılandırmasını değerlendirmek ve olası zafiyetleri belirlemek için güvenlik uzmanlarına etkili bir çözüm sunar.

> **Önemli Not:** SharpLAPS.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **LAPS Parola Çıkarma:**
   - Local Administrator Password Solution tarafından yönetilen parolaları çeker.
2. **Active Directory Entegrasyonu:**
   - AD ortamında LAPS nesnelerine erişim sağlar.
3. **Hızlı ve Kolay Kullanım:**
   - Basit bir komutla hızlıca sonuç verir.

---

## İndirme ve Çalıştırma

SharpLAPS.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpLAPS GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpLAPS.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpLAPS.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-target`**
- Hedef bilgisayarın adını veya IP adresini belirtir.

  **Kullanım:**
  ```cmd
  SharpLAPS.exe -target ComputerName
  ```

### 2. **`-all`**
- Tüm etki alanındaki LAPS parolalarını toplar.

  **Kullanım:**
  ```cmd
  SharpLAPS.exe -all
  ```

### 3. **`-username` ve `-password`**
- Kullanıcı adı ve parola bilgilerini belirterek çalıştırır.

  **Kullanım:**
  ```cmd
  SharpLAPS.exe -username AdminUser -password AdminPass
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpLAPS.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Belirli Bir Bilgisayarın LAPS Parolasını Çekmek
```cmd
SharpLAPS.exe -target ComputerName
```

### 2. Tüm Etki Alanındaki LAPS Parolalarını Toplamak
```cmd
SharpLAPS.exe -all
```

### 3. Kullanıcı Bilgileri ile Çalıştırma
```cmd
SharpLAPS.exe -username AdminUser -password AdminPass -target ComputerName
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpLAPS.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpLAPS.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpLAPS GitHub Sayfası](https://github.com)
- [Microsoft LAPS](https://learn.microsoft.com/en-us/windows-server/identity/laps/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
