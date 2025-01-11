# NetExec Tool Kullanım Kılavuzu

## Giriş
NetExec, ağ yönetimi, uzaktan komut çalıştırma ve penetrasyon testlerinde kullanılan güçlü bir araçtır. Bu kılavuz, aracın kurulumundan başlayarak tüm özelliklerini detaylı bir şekilde açıklamaktadır.

---

## Kurulum

### Gereksinimler
- Python 3.8 veya üzeri
- pip paket yöneticisi
- Linux, Windows veya macOS işletim sistemi

### Kurulum Adımları

#### 1. Python ve Pip Kurulumu
- **Linux:**
  ```bash
  sudo apt update && sudo apt install python3 python3-pip -y
  ```

- **Windows:**
  [Python resmi sitesinden](https://www.python.org) Python'u indirip yükleyin. Kurulum sırasında "Add Python to PATH" seçeneğini işaretlediğinizden emin olun.

#### 2. NetExec'i İndirin
Git kullanarak NetExec'i klonlayın:
```bash
git clone https://github.com/example/netexec.git
cd netexec
```

#### 3. Gereksinimlerin Kurulumu
```bash
pip install -r requirements.txt
```

#### 4. Çalıştırma
```bash
python netexec.py
```

---

## Kullanım

### 1. Yardım Menüsü
Komutlar hakkında bilgi almak için:
```bash
python netexec.py --help
```

### 2. Modüller ve Özellikler

#### Uzaktan Komut Çalıştırma
Hedef bir makinede uzaktan komut çalıştırmak için şu komutu kullanabilirsiniz:
```bash
python netexec.py exec --target 192.168.1.10 --user admin --password pass123 --command "whoami"
```

##### Parametreler:
- `--target`: Hedef IP adresi veya alan adı.
- `--user`: Hedef sistemin kullanıcı adı.
- `--password`: Kullanıcı şifresi.
- `--command`: Çalıştırılacak komut.

#### Çoklu Hedeflere Komut Çalıştırma
Birden fazla hedefte aynı komutu çalıştırmak için:
```bash
python netexec.py exec --targets targets.txt --user admin --password pass123 --command "uptime"
```

##### Parametreler:
- `--targets`: IP adreslerini içeren bir dosya (her satırda bir adres).

#### Ağ Keşfi
Ağdaki tüm cihazları keşfetmek için şu komutu kullanabilirsiniz:
```bash
python netexec.py scan --network 192.168.1.0/24
```

##### Parametreler:
- `--network`: Taranacak ağ aralığı.

#### Dosya Aktarımı
Bir hedefe dosya yüklemek için:
```bash
python netexec.py upload --target 192.168.1.10 --user admin --password pass123 --file payload.exe --dest C:\\Temp
```

Dosya indirmek için:
```bash
python netexec.py download --target 192.168.1.10 --user admin --password pass123 --file C:\\Temp\\report.txt --dest ./downloads
```

#### Şifre Kırma
SSH şifrelerini kırmak için:
```bash
python netexec.py brute-force --protocol ssh --target 192.168.1.10 --user admin --wordlist passwords.txt
```

##### Parametreler:
- `--protocol`: Hedef protokol (örneğin, `ssh`, `smb`).
- `--wordlist`: Kullanılacak şifre listesi.

#### Proxy Kullanımı
Proxy üzerinden komut çalıştırmak için:
```bash
python netexec.py exec --target 192.168.1.10 --user admin --password pass123 --command "ipconfig" --proxy 127.0.0.1:8080
```

##### Parametreler:
- `--proxy`: Kullanılacak proxy adresi (IP:PORT formatında).

---

## Otomatik Mod
Ağ keşfi, zafiyet taraması ve komut çalıştırmayı otomatik olarak gerçekleştirmek için:
```bash
python netexec.py auto --network 192.168.1.0/24 --command "hostname"
```

---

## Güncelleme

NetExec'in en son sürümüne güncellemek için:
```bash
git pull origin main
pip install -r requirements.txt --upgrade
```

---

## Sıkça Sorulan Sorular (SSS)

### NetExec Hangi Sistemlerde Çalışır?
NetExec, Windows, Linux ve macOS sistemlerinde çalışabilir. Ancak Linux üzerinde daha iyi performans gösterir.

### Çıktılar Nasıl Kaydedilir?
Komut çıktısını bir dosyaya kaydetmek için `--output` parametresini kullanabilirsiniz:
```bash
python netexec.py scan --network 192.168.1.0/24 --output results.txt
```

### Hata Ayıklama
Debug modunu etkinleştirmek için `--debug` parametresini kullanabilirsiniz:
```bash
python netexec.py exec --target 192.168.1.10 --debug
```

---

## İletişim ve Destek
Herhangi bir sorunuz veya öneriniz varsa, GitHub üzerinden issue oluşturabilirsiniz:
[GitHub Repository](https://github.com/example/netexec)

---

## Lisans
NetExec, MIT lisansı altında yayınlanmıştır. Daha fazla bilgi için `LICENSE` dosyasına göz atabilirsiniz.
