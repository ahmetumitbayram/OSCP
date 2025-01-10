# bloodyAD Kullanım Rehberi

## bloodyAD Nedir?

**bloodyAD**, Active Directory (AD) ortamlarında çeşitli LDAP çağrılarını kullanarak yetki yükseltme işlemleri gerçekleştiren bir güvenlik aracıdır. Araç, hem farklı kimlik doğrulama yöntemlerini destekler hem de bir Domain Controller'a bağlanarak AD üzerindeki kötü yapılandırmaları ve güvenlik açıklarını manipüle eder.

> **Önemli Not:** bloodyAD yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **LDAP Üzerinden Yetki Yükseltme:**
   - Parola, bilet ya da sertifika kullanarak AD nesnelerinde değişiklik yapabilir.
2. **Şifre ve Hash Desteği:**
   - Cleartext şifreler, Pass-the-Hash (PTH) ve Pass-the-Ticket (PTT) gibi yöntemleri destekler.
3. **LDAPS ile Güvenli İletişim:**
   - LDAPS olmadan da hassas bilgilerin değiş tokuşunu yapabilir.
4. **SOCKS Proxy Uyumluluğu:**
   - Proxy üzerinden kullanım için tasarlanmıştır.

---

## İndirme ve Çalıştırma

bloodyAD aracı GitHub üzerinden sağlanabilir:

- [bloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/CravateRouge/bloodyAD.git
   cd bloodyAD
   python3 -m pip install -r requirements.txt
   ```

2. **Çalıştırın:**
   ```bash
   bloodyAD <parametreler>
   ```

---

## Kullanım Komutları

### 1. Parola Ayarlama
Bir hedef kullanıcının parolasını değiştirmek için kullanılır.

**Parametreler:**
- `--host`: Hedef Domain Controller IP adresi. (**Gerekli**)
- `-d`: Domain adı. (**Gerekli**)
- `-u`: Kullanıcı adı. (**Gerekli**)
- `-p`: Parola veya NTLM hash. (**Gerekli**)

**Örnek Kullanım:**
```bash
bloodyAD --host 172.16.1.15 -d bloody.local -u jane.doe -p :70016778cb0524c799ac25b439bd6a31 set password john.doe 'Password123!'
```

### 2. Kullanıcı Grubu Manipülasyonu
Bir kullanıcıyı gruba eklemek veya çıkarmak için kullanılır.

**Örnek Kullanım:**
```bash
bloodyAD --host 172.16.1.15 -d bloody.local -u admin -p AdminPass add group john.doe 'Domain Admins'
```

### 3. SOA (Start of Authority) Kontrolü
AD üzerinde SOA kayıtlarını incelemek için kullanılır.

**Örnek Kullanım:**
```bash
bloodyAD --host 172.16.1.15 -d bloody.local -u admin -p AdminPass check soa
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** bloodyAD yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [bloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.

ChatGPT: **bloodyAD** için Türkçe kullanım rehberi dokümana eklendi. Daha fazla düzenleme veya başka bir konuda yardım ister misiniz?
