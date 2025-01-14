# LDAPSearch Kullanım Rehberi

Bu rehber, **LDAPSearch** aracını kullanarak Active Directory ve LDAP sunucularında sorgular gerçekleştirmenize yardımcı olacaktır. **LDAPSearch**, LDAP sunucularındaki verileri aramak ve çıkarmak için kullanılan güçlü bir komut satırı aracıdır.

---

## LDAPSearch Nedir?

LDAPSearch, LDAP protokolünü kullanarak dizin bilgilerini sorgulayan bir araçtır. Kullanıcılar, gruplar, bilgisayarlar ve diğer nesneler hakkında bilgi toplamak için kullanılabilir.

---

## Kurulum

LDAPSearch genellikle `ldap-utils` paketinin bir parçası olarak gelir. Eğer sisteminizde yüklü değilse aşağıdaki adımları izleyerek yükleyebilirsiniz:

### 1. Debian/Ubuntu:
```bash
sudo apt update && sudo apt install ldap-utils
```

### 2. Red Hat/CentOS:
```bash
sudo yum install openldap-clients
```

### Kurulum Kontrolü

Yüklemenin başarılı olup olmadığını kontrol etmek için:
```bash
ldapsearch -h
```

---

## Temel Kullanım

LDAP sunucusuna sorgu göndermek için aşağıdaki format kullanılır:
```bash
ldapsearch -x -h <HOST> -D <BIND_DN> -w <PASSWORD> -b <BASE_DN> <FILTRE>
```

- **`-x`**: Basit kimlik doğrulama kullan.
- **`-h <HOST>`**: LDAP sunucusunun adresi.
- **`-D <BIND_DN>`**: Kimlik doğrulamada kullanılacak Distinguished Name.
- **`-w <PASSWORD>`**: Kullanıcı şifresi.
- **`-b <BASE_DN>`**: Arama yapılacak temel dizin.
- **`<FILTRE>`**: LDAP sorgu filtresi.

### Örnek Komutlar

#### 1. Anonim Sorgu
LDAP sunucusuna anonim olarak bağlanarak tüm nesneleri listeleyebilirsiniz:
```bash
ldapsearch -x -h 192.168.1.10 -b "DC=megacorp,DC=local"
```

#### 2. Kimlik Doğrulama ile Sorgu
Bir kullanıcı adı ve şifre ile LDAP sunucusuna bağlanarak bilgi çekebilirsiniz:
```bash
ldapsearch -x -h 192.168.1.10 -D "CN=admin,DC=megacorp,DC=local" -w Password123 -b "DC=megacorp,DC=local"
```

#### 3. Kullanıcıları Listeleme
Belirli bir filtreyle sadece kullanıcı nesnelerini sorgulamak:
```bash
ldapsearch -x -h 192.168.1.10 -D "CN=admin,DC=megacorp,DC=local" -w Password123 -b "DC=megacorp,DC=local" "(objectClass=user)"
```

#### 4. Grupları Listeleme
Sadece grup nesnelerini listelemek:
```bash
ldapsearch -x -h 192.168.1.10 -D "CN=admin,DC=megacorp,DC=local" -w Password123 -b "DC=megacorp,DC=local" "(objectClass=group)"
```

#### 5. Belirli Bir Kullanıcıyı Sorgulama
E-posta adresi veya kullanıcı adına göre bir kullanıcı aramak:
```bash
ldapsearch -x -h 192.168.1.10 -D "CN=admin,DC=megacorp,DC=local" -w Password123 -b "DC=megacorp,DC=local" "(mail=johndoe@megacorp.local)"
```

---

## LDAPS Kullanımı
LDAPS (LDAP Secure) ile şifreli bağlantı yapmak için `-ZZ` veya `-H ldaps://` kullanabilirsiniz.

### Örnek Komut:
```bash
ldapsearch -x -H ldaps://192.168.1.10 -D "CN=admin,DC=megacorp,DC=local" -w Password123 -b "DC=megacorp,DC=local"
```

---

## Çıktı Formatları
LDAP sorgularının çıktıları, düzenli olarak birden fazla nesne hakkında bilgi içerir. Aşağıda tipik bir kullanıcı nesnesi örneği verilmiştir:

```plaintext
dn: CN=John Doe,CN=Users,DC=megacorp,DC=local
objectClass: user
sAMAccountName: johndoe
mail: johndoe@megacorp.local
memberOf: CN=Domain Admins,CN=Users,DC=megacorp,DC=local
```

### Çıktıyı Bir Dosyaya Kaydetme
Çıktıyı bir dosyaya kaydetmek için `>` kullanabilirsiniz:
```bash
ldapsearch -x -h 192.168.1.10 -b "DC=megacorp,DC=local" > output.txt
```

---

## Hata Giderme

- **Hata:** "Invalid credentials"
  - Çözüm: Kullanıcı adı ve şifrenizin doğru olduğundan emin olun.

- **Hata:** "Can't contact LDAP server"
  - Çözüm: Sunucunun IP adresi ve portunun doğru olduğundan emin olun.
  - Sunucunun açık portlarını kontrol etmek için:
    ```bash
    nmap -p 389,636 <HOST>
    ```

- **Hata:** "No such object"
  - Çözüm: Yanlış `Base DN` kullanıyorsunuz. Doğru `Base DN` değerini kontrol edin.

---

## Ek Kaynaklar

- [OpenLDAP Resmi Dokümantasyonu](https://www.openldap.org/doc/)
- [LDAP Sorguları Hakkında Detaylı Bilgi](https://ldap.com/)

---

Bu rehber, LDAP sunucularına sorgu göndermek ve veri toplamak için gerekli temel komutları ve kullanım ipuçlarını içermektedir. Daha fazla bilgi için yukarıdaki kaynakları inceleyebilirsiniz.
