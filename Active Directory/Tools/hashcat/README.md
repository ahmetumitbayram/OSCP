Hash Türü	Hashcat Mode ID
Windows Hashleri	
NTLM	1000
NetNTLMv1	5500
NetNTLMv1+ESS	5600
NetNTLMv2	5600
Kerberos 5 AS-REP (AES)	18200
Linux Hashleri	
MD5-Crypt	500
SHA256-Crypt	7400
SHA512-Crypt	1800
bcrypt (Blowfish)	3200
Genel Hash Algoritmaları	
MD5	0
SHA-1	100
SHA-256	1400
SHA-512	1700
LM Hash	3000
Wi-Fi Hashleri	
WPA/WPA2	22000
Veritabanı Hashleri	
MySQL 4.1+ (SHA1)	300
MySQL 5+ SHA256	7401
MSSQL 2000	131
MSSQL 2005	132
MSSQL 2012+	1731
Active Directory Hashleri	
Kerberos 5 AS-REP Roasting	18200
Kerberos 5 TGS-REP Hash	13100


# Hashcat Kullanım Kılavuzu

## Giriş
Hashcat, parola kırma işlemleri için kullanılan, dünya çapında popüler bir açık kaynaklı araçtır. CPU, GPU, FPGA ve diğer hızlandırıcıları kullanarak karma çözme işlemlerini hızlandırabilir. Bu kılavuz, Hashcat'in detaylı kullanımını, komutlarını, modlarını ve en iyi uygulamalarını ele alır.

---

## Kurulum

### 1. Gereksinimler
- **Desteklenen İşletim Sistemleri:** Linux, Windows, macOS
- **Donanım Gereksinimleri:**
  - CPU
  - NVIDIA/AMD GPU (OpenCL veya CUDA desteği gereklidir)

### 2. Kurulum Adımları
#### Linux
```bash
sudo apt update
sudo apt install -y hashcat
```
Veya Hashcat'in en son sürümünü indirin:
```bash
wget https://hashcat.net/files/hashcat-<version>.7z
7z x hashcat-<version>.7z
cd hashcat-<version>
```

#### Windows
1. [Hashcat Resmi Web Sitesi](https://hashcat.net/hashcat/) üzerinden indir.
2. Dosyaları çıkar ve `hashcat.exe` ile çalıştır.

#### macOS
Homebrew ile yükleyebilirsiniz:
```bash
brew install hashcat
```

---

## Temel Kullanım

### Komut Yapısı
```bash
hashcat [seçenekler] [hash dosyası] [wordlist veya mask]
```

### Yardım Menüsü
Hashcat ile ilgili tüm komut ve seçenekleri görmek için:
```bash
hashcat --help
```

### Hash Modları
Hashcat, farklı türdeki hash'leri çözmek için birçok mod sunar. Örneğin:
- MD5: `0`
- SHA1: `100`
- NTLM: `1000`
- bcrypt: `3200`
Tüm modları listelemek için:
```bash
hashcat --example-hashes
```

---

## Saldırı Modları

### 1. **Dictionary Attack (Sözlük Saldırısı)**
Bu mod, bir wordlist kullanır:
```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt
```

### 2. **Brute-Force Attack (Kaba Kuvvet Saldırısı)**
Belirli bir maske ile brute-force:
```bash
hashcat -m 0 -a 3 hashes.txt ?a?a?a?a
```
- `?a`: Tüm karakterler
- `?l`: Küçük harfler
- `?u`: Büyük harfler
- `?d`: Sayılar

### 3. **Combination Attack (Kombinasyon Saldırısı)**
İki farklı wordlist'in birleşimi:
```bash
hashcat -m 0 -a 1 hashes.txt wordlist1.txt wordlist2.txt
```

### 4. **Hybrid Attack (Hibrit Saldırı)**
Sözlük ve maske birleştirilir:
```bash
hashcat -m 0 -a 6 hashes.txt wordlist.txt ?d?d
```

---

## Gelişmiş Kullanım

### Benchmark Testi
Hashcat'in performansını test etmek için:
```bash
hashcat -b
```

### Çıkış Biçimi
Sonuçları belirli bir dosyaya kaydetmek için:
```bash
hashcat -o cracked.txt -m 0 -a 0 hashes.txt wordlist.txt
```

### Kurallar (Rules)
Kurallar, wordlist'teki kelimeleri değiştirerek yeni kombinasyonlar üretir:
```bash
hashcat -m 0 -a 0 -r rules/best64.rule hashes.txt wordlist.txt
```

### Mask Generator (Maske Üretici)
Kendi maske kombinasyonlarınızı oluşturmak için:
```bash
hashcat --stdout -a 3 ?l?l?l?l | head
```

---

## İpuçları

### Performans Optimizasyonu
- GPU hızlandırmayı kullanın:
```bash
hashcat -d 1 -m 0 -a 0 hashes.txt wordlist.txt
```
- Hashcat'in hızını artırmak için `--force` parametresi kullanılabilir ancak dikkatli olun.

### Checkpoint ve Devam Ettirme
Uzun süren işlemleri durdurup devam ettirmek için:
- İşlem sırasında durdur:
  ```bash
  hashcat --restore
  ```
- Checkpoint özelliği ile kaldığınız yerden devam:
  ```bash
  hashcat --session=mySession
  ```

---

## Örnekler

### MD5 Hash Saldırısı
```bash
hashcat -m 0 -a 0 hashes.txt wordlist.txt
```

### NTLM Hash Brute Force
```bash
hashcat -m 1000 -a 3 hashes.txt ?u?l?l?l?d?d
```

### bcrypt Hash Kullanımı
```bash
hashcat -m 3200 -a 0 hashes.txt wordlist.txt
```

---

## Sorun Giderme

### Sık Karşılaşılan Hatalar
1. **OpenCL Platform bulunamadı:**
   - GPU sürücülerinizin yüklü olduğundan emin olun.
2. **Hash formatı yanlış:**
   - Doğru hash modunu kullandığınızdan emin olun.

### Loglama
Hata ayıklama için log dosyası oluşturabilirsiniz:
```bash
hashcat --debug-file=debug.txt
```

---

## Ek Kaynaklar
- [Hashcat Resmi Dokümantasyonu](https://hashcat.net/wiki/)
- [Hashcat GitHub Reposu](https://github.com/hashcat/hashcat)
- [Hashcat Kurallar ve Maske Üretici](https://hashcat.net/wiki/doku.php?id=rule_based_attack)

---

## Katkıda Bulunanlar
Bu kılavuz, Hashcat kullanımını detaylı olarak ele almak için hazırlanmıştır. Önerileriniz ve katkılarınız için iletişime geçmekten çekinmeyin!
