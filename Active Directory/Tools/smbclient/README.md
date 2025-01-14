# SMBClient Kullanım Rehberi

Bu rehber, Linux sistemlerinde kullanılan `smbclient` aracını tanıtmakta ve temel komutlarını örneklerle açıklamaktadır. `smbclient`, SMB/CIFS protokolünü kullanarak ağ paylaşımına erişim sağlayan bir araçtır.

## Kurulum

`SMBClient`, çoğu Linux dağıtımında varsayılan olarak gelir. Eğer sisteminizde yüklü değilse aşağıdaki komutla yükleyebilirsiniz:

```bash
# Debian/Ubuntu:
sudo apt update && sudo apt install smbclient

# Red Hat/CentOS:
sudo yum install samba-client
```

Yüklü olup olmadığını kontrol etmek için:

```bash
smbclient --version
```

---

## Temel Kullanım

### 1. Paylaşımları Listeleme

Bir sunucuda hangi SMB paylaşımlarının mevcut olduğunu listelemek için:

```bash
smbclient -L //<HOSTNAME> -U <USERNAME>
```

#### Örnek:
```bash
smbclient -L //192.168.1.10 -U admin
```
Bu komut, `192.168.1.10` üzerindeki SMB paylaşımlarını listeleyecektir.

Eğer bir şifre istemezseniz:

```bash
smbclient -L //192.168.1.10 -N
```

---

### 2. Paylaşıma Bağlanma

Bir SMB paylaşımına bağlanmak için aşağıdaki komutu kullanabilirsiniz:

```bash
smbclient //HOSTNAME/SHARE -U <USERNAME>
```

#### Örnek:
```bash
smbclient //192.168.1.10/shared -U admin
```
Bu komut, `192.168.1.10` üzerindeki `shared` paylaşımına bağlanır.

---

### 3. Dosya ve Dizine Göz Atma

Bağlantı kurulduktan sonra, aşağıdaki komutlarla paylaşımı keşfedebilirsiniz:

- **Dizin Listeleme:**
  ```bash
  ls
  ```
- **Dizin Değiştirme:**
  ```bash
  cd <DIZIN_ADI>
  ```
- **Mevcut Dizin:**
  ```bash
  pwd
  ```

---

### 4. Dosya İndirme ve Yükleme

- **Dosya İndirme:**
  ```bash
  get <DOSYA_ADI>
  ```
  Örnek:
  ```bash
  get test.txt
  ```

- **Dosya Yükleme:**
  ```bash
  put <YEREL_DOSYA_ADI>
  ```
  Örnek:
  ```bash
  put /home/user/file.txt
  ```

---

### 5. Yerel Komutlar Çalıştırma

Bağlantı sırasında yerel komutlar çalıştırmak için komuttan önce `!` koyun:

#### Örnek:
```bash
!ls
!pwd
```
Bu komutlar, yerel sistemdeki dosya ve dizinleri listeler.

---

### 6. Şifreleme ve Güvenlik Seçenekleri

- **NTLMv2 Zorlamak:**
  ```bash
  smbclient //192.168.1.10/shared -U admin --option='client min protocol=NT1'
  ```

- **Anonim Erişim:**
  ```bash
  smbclient //192.168.1.10/shared -N
  ```

---

## Komut Özet Tablosu

| Komut          | Açıklama                                  |
|----------------|------------------------------------------|
| `ls`          | Dizin içeriğini listele                  |
| `cd`          | Dizin değiştir                           |
| `pwd`         | Mevcut dizini göster                     |
| `get`         | Dosya indir                              |
| `put`         | Dosya yükle                              |
| `!<komut>`    | Yerel komut çalıştır                     |

---

## Hata Giderme

- **Hata:** `NT_STATUS_ACCESS_DENIED`
  - Çözüm: Doğru kullanıcı adı ve şifre kullandığınızdan emin olun. Gerekirse `-U` seçeneğini kullanarak kullanıcı adı belirtin.

- **Hata:** `Connection failed`
  - Çözüm: Hedef sunucunun SMB hizmetinin çalıştığını ve port 445'in açık olduğunu doğrulayın.

```bash
nmap -p 445 <HOSTNAME>
```

---

## Ek Kaynaklar

- [SMBClient Resmi Belgeleri](https://www.samba.org/samba/docs/current/man-html/smbclient.1.html)

---

Bu rehber, `smbclient` ile temel işlemleri gerçekleştirmenize yardımcı olacak şekilde hazırlanmıştır. Daha fazla bilgi için resmi belgeleri inceleyebilir veya örnek senaryolar oluşturabilirsiniz.
