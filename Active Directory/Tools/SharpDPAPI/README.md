c# SharpDPAPI.exe Kullanım Kılavuzu

## Giriş
SharpDPAPI, Windows Data Protection API (DPAPI) tarafından korunan verileri çözmek için kullanılan bir araçtır. Bu araç, şifrelenmiş parolaları, tarayıcı verilerini, dosya sistemlerini ve daha fazlasını çözmek için tasarlanmıştır.

---

## Özellikler
- **DPAPI Master Key Çözme**: Kullanıcı veya sistem düzeyinde DPAPI master anahtarlarını çözer.
- **Korumalı Verilere Erişim**: Chrome, IE/Edge, RDP gibi uygulamalarda depolanan verileri toplar.
- **JSON Formatında Çıktı**: Çözülmüş verileri analiz için JSON formatında sağlar.

---

## Gereksinimler
- Windows işletim sistemi
- .NET Framework yüklenmiş olmalıdır

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpDPAPI'nin yardım mesajını görmek için:
```cmd
SharpDPAPI.exe -h
```

### Kullanıcı Master Keylerini Çözme
Bir kullanıcının DPAPI master keylerini çözmek için:
```cmd
SharpDPAPI.exe masterkeys /user
```

### Sistem Master Keylerini Çözme
Sistem DPAPI master keylerini çözmek için:
```cmd
SharpDPAPI.exe masterkeys /system
```

### Chrome Şifrelerini Çözme
Google Chrome tarayıcısında kayıtlı şifreleri çözmek için:
```cmd
SharpDPAPI.exe credentials /chrome
```

### RDP Kimlik Bilgilerini Çözme
RDP (Uzak Masaüstü Protokolü) oturum bilgilerini çözmek için:
```cmd
SharpDPAPI.exe credentials /rdg
```

### JSON Formatında Çıktı
Toplanan verileri bir JSON dosyasına kaydetmek için:
```cmd
SharpDPAPI.exe credentials /chrome /format:json /output:"C:\Temp\chrome_data.json"
```

---

## Örnek Kullanımlar

### Tüm Kullanıcı Master Keylerini Listeleme
Bilgisayardaki tüm kullanıcıların master keylerini listelemek için:
```cmd
SharpDPAPI.exe masterkeys /all
```

### Dosyaları Çözme
Belirli bir dosyanın DPAPI ile şifrelenmiş verilerini çözmek için:
```cmd
SharpDPAPI.exe blob /unprotect /in:"C:\Temp\encrypted_blob.bin"
```

### Tarayıcı Verilerini Çözme
Chrome ve Edge tarayıcı verilerini çözmek için:
```cmd
SharpDPAPI.exe credentials /browser
```

---

## Derleme Talimatları
SharpDPAPI kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpDPAPI.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpDPAPI GitHub](https://github.com/GhostPack/SharpDPAPI)
- [GhostPack Belgeleri](https://posts.specterops.io/)

Bu rehber, SharpDPAPI aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
