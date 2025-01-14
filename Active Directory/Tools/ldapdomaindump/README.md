# LDAPDomainDump Kullanım Rehberi

Bu rehber, Active Directory ortamındaki LDAP bilgilerinin bir kopyasını çıkarmak için kullanılan `ldapdomaindump` aracını tanıtan ve temel kullanımını açıklayan bir GitHub `README.md` dosyasıdır.

---

## Nedir?

`ldapdomaindump`, LDAP sorguları gerçekleştirerek Active Directory domain yapısını, kullanıcıları, grupları ve diğer bilgileri çıkarmaya yarayan bir Python aracıdır. Çıktılar HTML, JSON veya CSV formatında oluşturulabilir.

---

## Kurulum

`ldapdomaindump`, Python ile çalışır. Kurulum için aşağıdaki adımları izleyin:

1. **Python Bağımlılıklarını Yükleyin:**
   ```bash
   pip install ldapdomaindump
   ```

2. **Kurulumu Doğrulayın:**
   ```bash
   ldapdomaindump --help
   ```
   Bu komut, aracın kurulu olup olmadığını kontrol eder ve yardım menüsünü gösterir.

---

## Kullanım

`ldapdomaindump`, LDAP bilgilerini toplamak için kullanıcı adı, şifre ve hedef sunucu bilgilerine ihtiyaç duyar. Aşağıdaki komutlar sıkça kullanılan senaryoları açıklamaktadır.

### 1. Temel Kullanım

Bir domainin LDAP verilerini çıkarmak için aşağıdaki komutu kullanabilirsiniz:

```bash
ldapdomaindump -u <USERNAME> -p <PASSWORD> -d <DOMAIN> <LDAP_SERVER>
```

#### Örnek:
```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local 192.168.1.10
```
Bu komut, `192.168.1.10` IP adresindeki LDAP sunucusundan verileri çeker.

---

### 2. Hash ile Kimlik Doğrulama (Pass-the-Hash)

NTLM hash ile LDAP sorguları yapmak için `-H` seçeneğini kullanabilirsiniz:

```bash
ldapdomaindump -u <USERNAME> -H <LM:NT_HASH> -d <DOMAIN> <LDAP_SERVER>
```

#### Örnek:
```bash
ldapdomaindump -u admin -H aad3b435b51404eeaad3b435b51404ee:69cbf4a9b7415c9e1caf93d51d971be0 -d megacorp.local 192.168.1.10
```

---

### 3. LDAPS Kullanımı

LDAPS (LDAP Secure) kullanarak sorgu yapmak için `-ssl` bayrağını ekleyin:

```bash
ldapdomaindump -u <USERNAME> -p <PASSWORD> -d <DOMAIN> --ssl <LDAP_SERVER>
```

#### Örnek:
```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local --ssl 192.168.1.10
```

---

### 4. Çıktı Dosyaları

`ldapdomaindump` varsayılan olarak çıktıyı çalışma dizinine kaydeder. Çıktılar şu formatlarda oluşturulur:

- **HTML**: Kullanıcı dostu bir rapor.
- **JSON**: Yapılandırılmış veri.
- **CSV**: Tablolama için uygun format.

#### Çıktı Dizini Belirleme
Çıktıları belirli bir dizine kaydetmek için `-o` parametresini kullanabilirsiniz:

```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local -o /path/to/output 192.168.1.10
```

---

### 5. Anonim Erişim

LDAP sunucusu anonim bağlantıya izin veriyorsa kullanıcı adı ve şifre olmadan sorgu yapabilirsiniz:

```bash
ldapdomaindump <LDAP_SERVER>
```

#### Örnek:
```bash
ldapdomaindump 192.168.1.10
```

---

## Örnek Komutlar

### Kullanıcı Bilgilerini Çekmek
```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local 192.168.1.10
```

### Hash ile Kimlik Doğrulama
```bash
ldapdomaindump -u admin -H aad3b435b51404eeaad3b435b51404ee:69cbf4a9b7415c9e1caf93d51d971be0 -d megacorp.local 192.168.1.10
```

### LDAPS Kullanımı
```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local --ssl 192.168.1.10
```

### Çıktıyı Belirli Bir Dizine Kaydetme
```bash
ldapdomaindump -u admin -p Password123 -d megacorp.local -o /tmp/output 192.168.1.10
```

---

## Hata Giderme

- **Hata:** `NT_STATUS_ACCESS_DENIED`
  - Çözüm: Kullanıcı adı ve şifrenizin doğru olduğundan emin olun.

- **Hata:** `ldap3.core.exceptions.LDAPSocketOpenError`
  - Çözüm: Hedef sunucunun LDAP bağlantısına izin verdiğini kontrol edin. LDAPS için doğru portu (636) kullandığınızdan emin olun.

---

## Ek Kaynaklar

- [LDAPDomainDump GitHub](https://github.com/dirkjanm/ldapdomaindump)
- [LDAP Protokolü Bilgileri](https://ldap.com/)

---

Bu rehber, `ldapdomaindump` aracıyla temel LDAP sorgularını gerçekleştirmenize yardımcı olmak için hazırlanmıştır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
