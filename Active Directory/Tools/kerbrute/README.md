# Kerbrute Kullanım Rehberi

## Kerbrute Nedir?

**Kerbrute**, Active Directory (AD) ortamlarında Kerberos kimlik doğrulama protokolünü hedef alarak kullanıcı adlarını ve şifrelerini brute force yöntemiyle test etmek için kullanılan bir güvenlik aracıdır. Araç, AD kullanıcı adlarını keşfetmek ve zayıf parolaları belirlemek için kullanılır.

> **Önemli Not:** Kerbrute yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kullanıcı Adı Keşfi:**
   - Active Directory kullanıcılarının varlığını tespit eder.
2. **Parola Testi:**
   - Kullanıcı hesaplarında zayıf parolaları test eder.
3. **Hızlı ve Etkili:**
   - Kerberos protokolü üzerinden çoklu kullanıcı ve parola denemeleri yapar.

---

## İndirme ve Çalıştırma

Kerbrute aracı GitHub üzerinden sağlanabilir:

- [Kerbrute GitHub Sayfası](https://github.com/ropnop/kerbrute)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/ropnop/kerbrute.git
   cd kerbrute
   go build
   ```

2. **Çalıştırın:**
   ```bash
   ./kerbrute <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-domain`**
- Hedef Active Directory domain adını belirtir.

  **Kullanım:**
  ```bash
  ./kerbrute -domain example.local
  ```

### 2. **`-users`**
- Test edilecek kullanıcı adlarının bulunduğu dosyayı belirtir.

  **Kullanım:**
  ```bash
  ./kerbrute -domain example.local -users users.txt
  ```

### 3. **`-password`**
- Kullanılacak parolayı belirtir.

  **Kullanım:**
  ```bash
  ./kerbrute -domain example.local -users users.txt -password Password123
  ```

### 4. **`-passwords`**
- Test edilecek parola listesini belirtir.

  **Kullanım:**
  ```bash
  ./kerbrute -domain example.local -users users.txt -passwords passwords.txt
  ```

### 5. **`-output`**
- Çıktı dosyasını belirtir.

  **Kullanım:**
  ```bash
  ./kerbrute -domain example.local -users users.txt -passwords passwords.txt -output results.txt
  ```

### 6. **`-help`**
- Yardım mesajını görüntüler.

  **Kullanım:**
  ```bash
  ./kerbrute -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kullanıcı Adlarını Keşfetme
```bash
./kerbrute -domain example.local -users users.txt
```

### 2. Kullanıcı Adları ve Parolaları Test Etme
```bash
./kerbrute -domain example.local -users users.txt -passwords passwords.txt
```

### 3. Sonuçları Dosyaya Kaydetme
```bash
./kerbrute -domain example.local -users users.txt -passwords passwords.txt -output results.txt
```

### 4. Yardım Mesajını Görüntüleme
```bash
./kerbrute -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Kerbrute yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Kerbrute GitHub Sayfası](https://github.com/ropnop/kerbrute)
- [Active Directory ve Kerberos Hakkında](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
