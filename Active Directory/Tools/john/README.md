# John the Ripper Kullanım Kılavuzu

## Giriş
John the Ripper, parola kırma işlemleri için kullanılan güçlü ve açık kaynaklı bir araçtır. Çeşitli hash türlerini destekler ve parola kırma işlemlerini hızlandırmak için CPU ve GPU hızlandırmasını kullanabilir. Bu kılavuz, John the Ripper'ın detaylı kullanımını, kurulumunu ve sık kullanılan özelliklerini ele alır.

---

## Kurulum

### 1. Gereksinimler
- **Desteklenen İşletim Sistemleri:** Linux, Windows, macOS
- **Bağımlılıklar:**
  - Gerekli kütüphaneler (`build-essential`, `libssl-dev` vb.)

### 2. Kurulum Adımları

#### Linux
John the Ripper'ı kaynak koddan derlemek en iyi seçenektir:
```bash
git clone https://github.com/openwall/john -b bleeding-jumbo john-jumbo
cd john-jumbo/src
./configure && make -s clean && make -sj4
```

#### Windows
1. [John the Ripper Resmi Web Sitesi](https://www.openwall.com/john/) üzerinden indir.
2. İndirilen dosyaları çıkar ve `john.exe` ile çalıştır.

#### macOS
Homebrew kullanarak kurulum yapabilirsiniz:
```bash
brew install john-jumbo
```

---

## Temel Kullanım

### Komut Yapısı
```bash
john [seçenekler] [hash dosyası]
```

### Yardım Menüsü
Tüm komut ve seçenekleri görmek için:
```bash
john --help
```

### Desteklenen Hash Türleri
John the Ripper, birçok hash türünü destekler. Örnek hash türlerini görmek için:
```bash
john --list=formats
```

---

## Saldırı Modları

### 1. **Sözlük Saldırısı (Dictionary Attack)**
Bir wordlist kullanarak parola kırma:
```bash
john --wordlist=wordlist.txt hashes.txt
```
- `--wordlist`: Kullanılacak parola listesini belirtir.

### 2. **Kaba Kuvvet Saldırısı (Brute-Force Attack)**
Belirli bir maske ile brute-force:
```bash
john --incremental hashes.txt
```
- `--incremental`: Varsayılan brute-force modunu kullanır.
- Özel maske:
  ```bash
  john --mask=?u?l?l?l?d hashes.txt
  ```
  - `?u`: Büyük harf
  - `?l`: Küçük harf
  - `?d`: Rakam

### 3. **Hybrid Attack (Hibrit Saldırı)**
Sözlük ve brute-force'u birleştirerek:
```bash
john --wordlist=wordlist.txt --rules hashes.txt
```
- `--rules`: Sözlükteki kelimelere varyasyonlar ekler.

---

## Gelişmiş Özellikler

### Hash Türünü Belirleme
Hash türü otomatik olarak algılanmazsa:
```bash
john --format=NT hashes.txt
```
- Örnek hash formatları:
  - MD5: `raw-md5`
  - SHA1: `raw-sha1`
  - NTLM: `nt`

### Parola Kırma İşlemini Kaydetme ve Devam Ettirme
- İşlemi durdurup kaydedin:
  ```bash
  john --session=mySession --wordlist=wordlist.txt hashes.txt
  ```
- Kaldığınız yerden devam edin:
  ```bash
  john --restore=mySession
  ```

### Cracked Şifreleri Görüntüleme
Başarılı bir şekilde kırılan şifreleri görmek için:
```bash
john --show hashes.txt
```

---

## Performans İyileştirmeleri

### Donanım Hızlandırma
- **OpenCL veya CUDA kullanarak hızlandırma:**
  OpenCL sürümünü derleyin ve GPU hızlandırmasını etkinleştirin:
  ```bash
  ./configure --enable-opencl && make -sj4
  ```
- CUDA sürücüleri yüklü olmalıdır.

### İş Parçacıkları
- Çok çekirdekli işlemci kullanımı:
  ```bash
  john --fork=4 hashes.txt
  ```
  - `--fork`: Kullanılacak çekirdek sayısını belirtir.

### Parola Kapsamını Azaltma
Belirli bir uzunluk veya karakter seti için brute-force:
```bash
john --mask=?a?a?a --min-length=4 --max-length=6 hashes.txt
```

---

## Örnek Kullanımlar

### MD5 Hash Kırma
```bash
john --format=raw-md5 --wordlist=wordlist.txt hashes.txt
```

### NTLM Hash Brute Force
```bash
john --format=nt --incremental hashes.txt
```

### SHA1 Hybrid Attack
```bash
john --format=raw-sha1 --wordlist=wordlist.txt --rules hashes.txt
```

---

## Sorun Giderme

### Sık Karşılaşılan Hatalar
1. **"No password hashes loaded" hatası:**
   - Hash dosyasının doğru biçimde olduğundan emin olun.
2. **Performans düşük:**
   - GPU hızlandırmasını etkinleştirin veya `--fork` parametresini kullanarak çoklu iş parçacığı çalıştırmayı deneyin.

### Loglama
Hata ayıklama için log dosyasını etkinleştirin:
```bash
john --log=logfile.txt --wordlist=wordlist.txt hashes.txt
```

---

## Ek Kaynaklar
- [John the Ripper Resmi Web Sitesi](https://www.openwall.com/john/)
- [John Jumbo GitHub Reposu](https://github.com/openwall/john)
- [Wordlists ve Kurallar](https://github.com/danielmiessler/SecLists)

---

## Katkıda Bulunanlar
Bu kılavuz, John the Ripper kullanımını detaylı bir şekilde ele almak için hazırlanmıştır. Sorularınız veya önerileriniz için iletişime geçmekten çekinmeyin!
