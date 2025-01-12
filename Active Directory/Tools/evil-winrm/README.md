# Evil-WinRM Kullanım Kılavuzu

Evil-WinRM, Windows Remote Management (WinRM) protokolünü kullanarak bir hedef Windows makinesine bağlanmak için kullanılan güçlü bir araçtır. Özellikle pentest ve Red Team çalışmalarında kullanılır.

---

## Gereksinimler

- Ruby yüklü bir sistem (Linux, macOS, Windows)
- Hedef sistemde açık olan WinRM (TCP 5985/5986 portları)
- Geçerli kullanıcı adı ve şifre veya bir Kerberos bileti

---

## Kurulum

### 1. Ruby'nin Yüklenmesi

Linux veya macOS için Ruby'yi yüklemek:
```bash
sudo apt-get install ruby # Debian/Ubuntu
sudo yum install ruby     # CentOS/RedHat
brew install ruby         # macOS (Homebrew ile)
```

Windows için Ruby indirin ve yükleyin: [https://rubyinstaller.org](https://rubyinstaller.org)

### 2. Evil-WinRM'nin Kurulumu

Evil-WinRM'yi RubyGems ile yükleyin:
```bash
gem install evil-winrm
```

Kurulum başarılı ise aşağıdaki komutla doğrulayabilirsiniz:
```bash
evil-winrm -h
```

---

## Kullanım

Evil-WinRM kullanarak hedefe bağlanmak için birkaç farklı yöntem mevcuttur:

### 1. Temel Kullanım

Kullanıcı adı ve şifre ile bağlantı:
```bash
evil-winrm -i <hedef_ip_adresi> -u <kullanıcı_adı> -p <şifre>
```

Örnek:
```bash
evil-winrm -i 192.168.1.10 -u administrator -p P@ssw0rd123
```

### 2. Kerberos Bileti ile Bağlantı

Kerberos bileti ile bağlanmak için kullanıcı adını ve IP adresini belirtin:
```bash
evil-winrm -i <hedef_ip_adresi> -u <kullanıcı_adı> -k
```

Örnek:
```bash
evil-winrm -i 192.168.1.10 -u administrator -k
```

### 3. Custom Script Yükleme

Hedef makineye script yüklemek ve çalıştırmak için:
```bash
upload <yerel_dosya_yolu> <hedef_dosya_yolu>
```

Örnek:
```bash
upload exploit.ps1 C:\Users\Public\exploit.ps1
```

Ardından PowerShell komutu ile çalıştırabilirsiniz:
```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\Public\exploit.ps1
```

### 4. Modülleri Kullanma

Evil-WinRM ile bazı ön tanımlı modülleri çalıştırabilirsiniz. Örneğin:
```bash
scriptcmd whoami
```

---

## Faydalı Komutlar

- **Yardım Menüsü:** Tüm komutları görmek için `help` yazın.
- **Dosya Yükleme:** Hedef makineye dosya yüklemek için `upload` kullanın.
- **Dosya İndirme:** Hedef makineden dosya indirmek için `download` kullanın.
- **Shell Çalıştırma:** PowerShell komutlarını doğrudan çalıştırabilirsiniz.

---

## Örnek Senaryo

Hedef: `192.168.1.10`
Kullanıcı Adı: `administrator`
Şifre: `P@ssw0rd123`

### 1. Bağlantı Kurma
```bash
evil-winrm -i 192.168.1.10 -u administrator -p P@ssw0rd123
```

### 2. Dosya Yükleme ve Çalıştırma
```bash
upload C:\exploit.ps1 C:\Users\Public\exploit.ps1
powershell -ExecutionPolicy Bypass -File C:\Users\Public\exploit.ps1
```

### 3. Dosya İndirme
```bash
download C:\Users\Administrator\Desktop\flag.txt flag.txt
```

---

## Hata Giderme

1. **Bağlantı Hatası (Connection Refused):**
   - Hedef sistemde WinRM'in açık ve yapılandırılmış olduğundan emin olun.
   - `5985` ve `5986` portlarının açık olduğunu kontrol edin.

2. **Erişim Reddedildi (Access Denied):**
   - Kullanıcı adının ve şifrenin doğru olduğundan emin olun.

3. **Kerberos ile Bağlanılamıyor:**
   - Sistem saati ve domain yapılandırmalarını kontrol edin.

---

## Kaynaklar

- Evil-WinRM GitHub Sayfası: [https://github.com/Hackplayers/evil-winrm](https://github.com/Hackplayers/evil-winrm)
- WinRM Hakkında Bilgi: [https://docs.microsoft.com/en-us/windows/winrm/](https://docs.microsoft.com/en-us/windows/winrm/)

---

**Hazırlayan:** Ahmet Ümit BAYRAM  
**Websitesi:** [https://exploitart.ist](https://exploitart.ist)
