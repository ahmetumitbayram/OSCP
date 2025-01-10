# NoPowerShell Kullanım Kılavuzu

## Giriş
NoPowerShell, PowerShell komutlarını yeniden oluşturmayı amaçlayan ve C# dilinde yazılmış bir araçtır. Bu araç, PowerShell komutlarını PowerShell'e özgü günlük mekanizmalarına yakalanmadan çalıştırmak için tasarlanmıştır. NoPowerShell, özellikle sınırlı ortamlarda veya PowerShell kullanımının kısıtlandığı durumlarda etkili bir çözüm sunar. 

NoPowerShell, aşağıdaki şekillerde kullanılabilir:
- **Cobalt Strike**'ın `execute-assembly` komutuyla.
- `rundll32.exe` aracılığıyla bir DLL olarak yüklenerek.

---

## Özellikler
- **Gizlilik**: PowerShell günlüklerinden kaçınır.
- **Esneklik**: PowerShell'in sunduğu komut setine aşina olan kullanıcılar için kolay kullanım.
- **Genişletilebilirlik**: C# ile kolayca yeni işlevler eklenebilir.
- **Cmdlet Desteği**: Active Directory ve diğer PowerShell modüllerinden birçok cmdlet'i destekler.

---

## Kullanım

### 1. **Cobalt Strike ile Kullanım**
NoPowerShell'i Cobalt Strike içinde kullanmak için aşağıdaki adımları takip edebilirsiniz:

#### Execute-Assembly Komutuyla Çalıştırma
```bash
execute-assembly /path/to/NoPowerShell.exe Get-Command
```
Bu komut, NoPowerShell'i yükler ve `Get-Command` cmdlet'ini çalıştırır.

#### BOF.NET ile Kullanım
1. [BOF.NET](https://github.com/CCob/BOF.NET) BOF'unu kurun.
2. BOF.NET runtime'ı yükleyin:
   ```bash
   bofnet_init
   ```
3. NoPowerShell modülünü yükleyin:
   ```bash
   bofnet_load /path/to/NoPowerShell.dll
   ```
4. Cmdlet'leri çalıştırın:
   ```bash
   bofnet_execute NoPowerShell.Program Get-Command
   ```

### 2. **Rundll32 ile Çalıştırma**
NoPowerShell'i `rundll32` ile kullanmak için:
1. NoPowerShell DLL dosyasına bir kısayol oluşturun.
2. Kısayolu aşağıdaki gibi düzenleyin:
   ```bash
   rundll32 C:\Path\to\NoPowerShell.dll,main
   ```
3. Kısayolu çift tıklayarak çalıştırın.

### 3. **Cmdlet Örnekleri**
#### Basit Cmdlet Kullanımı
```bash
NoPowerShell.exe Get-Command
```
Bu komut, desteklenen tüm cmdlet'leri listeler.

#### Active Directory Cmdlet'leri
```bash
NoPowerShell.exe Get-ADUser -Filter *
```
Bu komut, Active Directory'deki tüm kullanıcıları listeler.

#### Dosya Yönetimi
```bash
NoPowerShell.exe Get-ChildItem -Path C:\
```
Bu komut, belirtilen dizindeki dosyaları ve klasörleri listeler.

#### Ağ Testi
```bash
NoPowerShell.exe Test-NetConnection -ComputerName google.com
```
Bu komut, belirtilen bilgisayarla bağlantıyı test eder.

---

## Dikkat Edilmesi Gerekenler
- **Escape Karakterleri**: Pipe (`|`) karakteri kullanılırken komut satırında kaçış yapılması gerekebilir.
  - `cmd.exe`: `ls ^| select Name`
  - `PowerShell`: `ls \`| select Name`
- **TLS Desteği**: .NET Framework 2'de TLS 1.1+ desteği yoktur. Bu nedenle TLS 1.1 ve üstü kullanan sitelere bağlanırken hata alabilirsiniz.

---

## Bilinen Sorunlar ve İyileştirmeler
### Bilinen Sorunlar
- Pipe karakterlerinin etrafında boşluk gereklidir.
- TLS 1.1+ desteklenmez.

### İyileştirme Önerileri
- Parametre grupları için destek eklenebilir.
- Daha fazla hata ayıklama için istisna yönetimi geliştirilebilir.

---

## Kaynaklar
- [NoPowerShell GitHub Sayfası](https://github.com/bitsadmin/nopowershell)
- [Cmdlet Cheatsheet](https://github.com/bitsadmin/nopowershell/blob/master/CHEATSHEET.md)

---

## Lisans
NoPowerShell, BSD-3-Clause lisansı altında lisanslanmıştır.

---

## İletişim
Bu araç hakkında daha fazla bilgi almak veya geri bildirimde bulunmak için geliştiriciyle iletişime geçebilirsiniz:
- GitHub: [bitsadmin](https://github.com/bitsadmin)
