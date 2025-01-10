# Seatbelt.exe Kullanım Kılavuzu

## Giriş
Seatbelt, güvenlik odaklı bir "host survey" aracıdır. Hem saldırı hem de savunma açısından kritik bilgileri toplamak için çeşitli modüller sunar. Bu araç, sistemdeki güvenlik açıklarını ve potansiyel tehditleri belirlemek için kullanılabilir.

---

## Özellikler
- **Kapsamlı Kontroller**: Sistem, kullanıcı, ağ ve diğer bileşenlere yönelik birçok komut sağlar.
- **Uzaktan Kullanım**: Bazı komutlar uzaktan kullanım için optimize edilmiştir.
- **JSON veya TXT Çıktı**: Çıktıyı JSON veya TXT formatında alabilirsiniz.
- **Modüler Yapı**: Ekstra komut modülleri kolayca eklenebilir.

---

## Gereksinimler
- Windows işletim sistemi
- .NET Framework 3.5 veya daha üstü
- Visual Studio Community Edition (derleme için)

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
Tüm mevcut komutları ve grupları listelemek için:
```cmd
Seatbelt.exe -h
```

### Belirli Bir Komutu Çalıştırma
Bir veya daha fazla komut çalıştırmak için:
```cmd
Seatbelt.exe <Command1> <Command2>
```
Örnek:
```cmd
Seatbelt.exe AMSIProviders AntiVirus
```

### Komut Gruplarını Çalıştırma
Tüm grup komutlarını çalıştırmak için:
```cmd
Seatbelt.exe -group=<group_name>
```
Örnek:
```cmd
Seatbelt.exe -group=system
```

### Uzaktan Kullanım
Bir sistemi uzaktan taramak için:
```cmd
Seatbelt.exe -group=remote -computername=COMPUTER.DOMAIN.COM -username=DOMAIN\USER -password=PASSWORD
```

---

## Komut Grupları

### System (Sistem)
Sisteme ait bilgileri toplar:
- **OSInfo**: İşletim sistemi bilgileri
- **PowerShell**: Yüklü PowerShell sürümleri
- **Processes**: Çalışan süreçler

Komut:
```cmd
Seatbelt.exe -group=system
```

### User (Kullanıcı)
Kullanıcı profili ile ilgili bilgileri toplar:
- **Certificates**: Sertifika bilgileri
- **MappedDrives**: Haritalanmış sürücüler

Komut:
```cmd
Seatbelt.exe -group=user
```

### Misc (Çeşitli)
Çeşitli kontrolleri çalıştırır:
- **InterestingFiles**: İlginç dosyaları arar
- **Printers**: Yüklü yazıcılar

Komut:
```cmd
Seatbelt.exe -group=misc
```

---

## Örnek Kullanımlar

### Tüm Kontrolleri Çalıştırma
Sistemdeki tüm kontrolleri çalıştırmak için:
```cmd
Seatbelt.exe -group=all
```

### Belirli Bir Komutu Argümanla Çalıştırma
Son 30 günlük oturum açma etkinliklerini listelemek için:
```cmd
Seatbelt.exe "LogonEvents 30"
```

### JSON Formatında Çıktı Alma
Sistem kontrollerini çalıştır ve JSON formatında kaydet:
```cmd
Seatbelt.exe -group=system -outputfile="C:\Temp\output.json"
```

---

## Derleme Talimatları
Seatbelt, Visual Studio kullanılarak derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`Seatbelt.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [Seatbelt GitHub](https://github.com/GhostPack/Seatbelt)

Bu rehber, Seatbelt aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantıya göz atabilirsiniz.
