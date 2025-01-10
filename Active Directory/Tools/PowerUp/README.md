# PowerUp.ps1 Kullanım Kılavuzu

## Giriş
PowerUp.ps1, Windows sistemlerinde yerel yetki yükseltme (privilege escalation) denemeleri yapmak için tasarlanmış bir PowerShell betiğidir. Bu araç, sistemdeki yanlış yapılandırmaları, zayıf izinleri ve diğer güvenlik açıklarını tespit ederek saldırganların SYSTEM veya Administrator yetkilerine yükselmesini kolaylaştırır.

Bu kılavuz, PowerUp.ps1 aracını kullanarak nasıl bilgi toplayacağınızı ve zafiyetleri nasıl değerlendireceğinizi adım adım açıklamaktadır.

---

## Gereksinimler
- Windows sistem (7/8/10/11 veya Server)
- PowerShell (en az v2.0)
- Sistem üzerinde PowerShell betiği çalıştırma izni
- Betik çalıştırma kısıtlamalarını bypass etmek için gereken bilgiler

---

## Özellikler
PowerUp.ps1 aşağıdaki işlemleri gerçekleştirebilir:
- Eksik veya zayıf dosya/dizin izinlerini tespit etme
- Hizmet yapılandırmalarındaki zafiyetleri kontrol etme
- Zayıf Registry anahtarlarını analiz etme
- Planlanmış görevlerdeki açıkları bulma
- DLL arama yolundaki zafiyetleri belirleme
- Kullanıcı tarafından çalıştırılabilir hizmetleri analiz etme

---

## Kullanım
### 1. **PowerUp.ps1 Betiğini Çalıştırma**
#### Betiğin İndirilmesi
PowerUp.ps1'i indirerek kullanabilirsiniz:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 -OutFile PowerUp.ps1
```

#### Betiğin Yüklenmesi
PowerShell oturumunuza betiği yüklemek için:
```powershell
Import-Module .\PowerUp.ps1
```

### 2. **Bilgi Toplama**
#### Tüm Sistem Zafiyetlerini Tespit Etme
Tüm olası zafiyetleri taramak için aşağıdaki komutu kullanın:
```powershell
Invoke-AllChecks
```
Bu komut, sistemdeki potansiyel zafiyetlerin kapsamlı bir listesini döndürür.

#### Hizmet Analizi
Hizmet yapılandırmalarını incelemek için:
```powershell
Get-ServiceUnquoted
```
Bu komut, alıntılanmamış hizmet yollarını (unquoted service paths) kontrol eder.

#### DLL Arama Yolu Zafiyetleri
DLL arama yolundaki zafiyetleri analiz etmek için:
```powershell
Get-ModifiablePath
```
Bu komut, DLL arama yolunda kullanıcı tarafından değiştirilebilir dizinleri kontrol eder.

#### Planlanmış Görevler
Planlanmış görevlerdeki zafiyetleri belirlemek için:
```powershell
Get-SchedTask
```

#### Registry Anahtarları
Zayıf Registry anahtarlarını kontrol etmek için:
```powershell
Get-RegAlwaysInstallElevated
```

### 3. **Manuel Zafiyet Analizi**
PowerUp.ps1, belirli zafiyetleri manuel olarak analiz etme imkanı da sunar. Örneğin, spesifik bir dosya veya hizmet üzerinde izin analizini çalıştırabilirsiniz:
```powershell
Get-ModifiableServiceFile -Verbose
```

---

## Örnek Senaryo
Bir sistemde yetki yükseltme yapmayı denediğinizi varsayalım:
1. **Sistemi Taramak İçin:**
   ```powershell
   Invoke-AllChecks
   ```
   Bu komut, sistemdeki tüm potansiyel zafiyetleri döndürür.

2. **Zayıf Hizmetleri Belirlemek İçin:**
   ```powershell
   Get-ServiceUnquoted
   ```
   Alıntılanmamış hizmet yolları tespit edilirse, bunları kötüye kullanabilirsiniz.

3. **DLL Zafiyetlerini Kontrol Etmek İçin:**
   ```powershell
   Get-ModifiablePath
   ```
   Değiştirilebilir yollar bulunursa, kendi kötü amaçlı DLL’inizi bu yola yerleştirerek SYSTEM yetkisi elde edebilirsiniz.

---

## Güvenlik Notları
PowerUp.ps1 gibi araçlar yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, yalnızca sistem yöneticilerinin güvenlik açıklarını tespit etmesine ve gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [PowerUp.ps1 GitHub](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc)
- [Resmi Belgeler](https://github.com/PowerShellMafia/PowerSploit)

---

Bu rehber, PowerUp.ps1 betiğini kullanarak sistemlerde yetki yükseltme denemeleri yapmanın temellerini kapsamaktadır. Daha fazla bilgi veya yardım için GitHub sayfasını ziyaret edin.
