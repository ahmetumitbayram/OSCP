# SharpChrome.exe Kullanım Kılavuzu

## Giriş
SharpChrome, Google Chrome tarayıcısında kayıtlı oturum bilgilerini ve şifreleri toplamak için kullanılan bir C# aracıdır. Bu arac, DPAPI (Data Protection API) üzerinden şifrelenmiş verileri çözmek için tasarlanmıştır.

---

## Özellikler
- **Google Chrome Verilerini Toplama**: Kayıtlı şifreler ve oturum bilgileri.
- **DPAPI Çözümleme**: Windows DPAPI kullanılarak şifreli verileri açar.
- **JSON Formatında Çıktı**: Toplanan veriler analiz için JSON formatında sunulur.

---

## Gereksinimler
- Windows işletim sistemi
- .NET Framework yüklenmiş olmalıdır

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpChrome'un yardım mesajını görmek için:
```cmd
SharpChrome.exe -h
```

### Tüm Chrome Verilerini Toplama
Tüm kayıtlı Chrome şifrelerini ve oturum bilgilerini toplamak için:
```cmd
SharpChrome.exe
```

### Belirli Bir Profil Dizini Belirtme
Belirli bir Chrome profil dizininden veri toplamak için:
```cmd
SharpChrome.exe --path "C:\\Users\\KullaniciAdiniz\\AppData\\Local\\Google\\Chrome\\User Data\\Default"
```

### JSON Formatında Kayıt
Toplanan verileri bir JSON dosyasına kaydetmek için:
```cmd
SharpChrome.exe --output "C:\\Temp\\chrome_data.json"
```

---

## Örnek Kullanımlar

### Oturum Bilgilerini Toplama
Google Chrome'daki kayıtlı oturum bilgilerini toplamak için:
```cmd
SharpChrome.exe --session
```

### Şifreleri Toplama
Chrome'da kayıtlı şifreleri toplamak için:
```cmd
SharpChrome.exe --password
```

### Belirli Bir Kullanıcı Profili Hedefleme
Belirli bir kullanıcı profiline odaklanmak için:
```cmd
SharpChrome.exe --user "KullaniciAdiniz"
```

---

## Derleme Talimatları
SharpChrome kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpChrome.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpChrome GitHub](https://github.com/GhostPack/SharpChrome)
- [GhostPack Belgeleri](https://posts.specterops.io/)

Bu rehber, SharpChrome aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
