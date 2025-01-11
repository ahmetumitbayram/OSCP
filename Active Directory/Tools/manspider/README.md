# MANSPIDER Kullanım Kılavuzu

MANSPIDER, SMB paylaşım ağlarında hassas bilgiler içeren dosyaları taramak için kullanılan bir araçtır. Dosya içeriği arama ve regex desteği sunar. 

## Özellikler
- PDF, DOCX, XLSX, PPTX ve diğer metin tabanlı formatlar dahil olmak üzere çok çeşitli dosya türlerini destekler.
- Hedef sistemlerdeki tüm paylaşımları tarar.
- Kullanıcı adı ve parola sağlanamazsa, misafir (guest) ve null oturum ile çalışır.

---

## Kurulum

### Docker ile Kurulum (Önerilir):
```bash
$ docker run --rm -v ./manspider:/root/.manspider blacklanternsecurity/manspider --help
```

### Alternatif Kurulum Yöntemi:
1. Gerekli bağımlılıkları yükleyin:
   ```bash
   $ sudo apt install tesseract-ocr  # Görüntüler (png, jpeg) için
   $ sudo apt install antiword      # Legacy doküman desteği (.doc)
   ```

2. MANSPIDER'ı yükleyin:
   ```bash
   $ pip install pipx
   $ pipx install git+https://github.com/blacklanternsecurity/MANSPIDER
   ```

---

## Kullanım Örnekleri

### Örnek 1: Ağdaki kullanıcı adı veya parola içeren dosya adlarını bulma
```bash
$ manspider 192.168.0.0/24 -f passw user admin account network login logon cred -d evilcorp -u bob -p Passw0rd
```

### Örnek 2: "password" içeren dosya adlarını bulma
```bash
$ manspider share.evilcorp.local -f passw -e xlsx csv -d evilcorp -u bob -p Passw0rd
```

### Örnek 3: İçeriğinde "password" geçen dokümanları bulma
```bash
$ manspider share.evilcorp.local -c passw -e xlsx csv docx pdf -d evilcorp -u bob -p Passw0rd
```

### Örnek 4: İlginç dosya uzantılarını arama
```bash
$ manspider share.evilcorp.local -e bat com vbs ps1 psd1 psm1 pem key rsa pub reg pfx cfg conf config vmdk vhd vdi dit -d evilcorp -u bob -p Passw0rd
```

### Örnek 5: Finansal dosyaları arama
```bash
$ manspider share.evilcorp.local --dirnames bank financ payable payment reconcil remit voucher vendor eft swift -f '[0-9]{5,}' -d evilcorp -u bob -p Passw0rd
```

### Örnek 6: SSH anahtarlarını dosya adına göre arama
```bash
$ manspider share.evilcorp.local -e ppk rsa pem ssh rsa -o -f id_rsa id_dsa id_ed25519 -d evilcorp -u bob -p Passw0rd
```

### Örnek 7: SSH anahtarlarını içeriklerine göre arama
```bash
$ manspider share.evilcorp.local -e '' -c 'BEGIN .{1,10} PRIVATE KEY' -d evilcorp -u bob -p Passw0rd
```

---

## Kullanım İpuçları

1. **Birden Fazla MANSPIDER Örneği Çalıştırma**:
   - Yüklenen dosyaları aramak için birden fazla örnek çalıştırabilirsiniz.
   - Örneğin: 
     ```bash
     $ manspider loot -f passw
     ```

2. **Varsayılan Ayarların Aşılması**:
   - Maksimum tarama derinliği: 10 (Değiştirmek için: `-m`)
   - Maksimum dosya boyutu: 10MB (Değiştirmek için: `-s`)
   - Varsayılan thread sayısı: 5 (Değiştirmek için: `-t`)

3. **Hedeflerin Tanımlanması**:
   - IP adresleri: `192.168.1.250`
   - CIDR blokları: `192.168.1.0/24`
   - Dosyalar: `smb_hosts.txt`
   - Yerel klasörler: `/mnt/share`

---

## Komut Kullanımı
```bash
usage: manspider [-h] [-u USERNAME] [-p PASSWORD] [-d DOMAIN] [-m MAXDEPTH] [-H HASH] [-t THREADS] [-f REGEX [REGEX ...]] [-e EXT [EXT ...]] [--exclude-extensions EXT [EXT ...]]
                 [-c REGEX [REGEX ...]] [--sharenames SHARE [SHARE ...]] [--exclude-sharenames [SHARE ...]] [--dirnames DIR [DIR ...]] [--exclude-dirnames DIR [DIR ...]] [-q] [-n]
                 [-mfail INT] [-o] [-s SIZE] [-v]
                 targets [targets ...]
```

**Açıklamalar:**
- `-u, --username`: Kimlik doğrulama için kullanıcı adı
- `-p, --password`: Kimlik doğrulama için parola
- `-d, --domain`: Kimlik doğrulama için domain adı
- `-f, --filenames`: Dosya adlarını regex ile filtreleme
- `-c, --content`: Dosya içeriğini regex ile arama
- `-e, --extensions`: Belirli dosya uzantılarını hedefleme
- `-m, --maxdepth`: Maksimum tarama derinliği
- `-s, --max-filesize`: Maksimum dosya boyutu
- `-t, --threads`: Paralel çalışan thread sayısı

Daha fazla bilgi için `--help` seçeneğini kullanabilirsiniz:
```bash
$ manspider --help
```

---

## Lisans
Bu proje [GPL-3.0 Lisansı](LICENSE) ile lisanslanmıştır.
