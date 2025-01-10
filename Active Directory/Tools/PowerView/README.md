# PowerView.ps1 Kullanım Kılavuzu

## Giriş
PowerView.ps1, Active Directory ortamlarında bilgi toplama ve yanlış yapılandırmaları tespit etmek için kullanılan güçlü bir PowerShell betiğidir. Bu araç, özellikle yetki yükseltme ve ağ haritalama gibi işlemler için kırmızı takım (red team) ve pentest uzmanları tarafından yaygın olarak kullanılır.

Bu kılavuz, PowerView.ps1 aracını kullanarak Active Directory bilgi toplama işlemlerini adım adım açıklar.

---

## Gereksinimler
- Windows sistem
- PowerShell
- Active Directory ortamına erişim
- Betik çalıştırma kısıtlamalarını bypass etme yetkisi

---

## Özellikler
PowerView.ps1 aşağıdaki işlemleri gerçekleştirebilir:
- Etki alanı bilgilerini toplamak
- Active Directory kullanıcı ve grup bilgilerini listelemek
- Erişim izinlerini analiz etmek
- ACL (Access Control List) verilerini keşfetmek
- Oturum açmış kullanıcıları ve bilgisayarları tespit etmek
- Servis hesaplarını belirlemek

---

## Kullanım
### 1. **PowerView.ps1 Betiğini Çalıştırma**
#### Betiğin İndirilmesi
PowerView.ps1'i indirerek kullanabilirsiniz:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -OutFile PowerView.ps1
```

#### Betiğin Yüklenmesi
PowerShell oturumunuza betiği yüklemek için:
```powershell
Import-Module .\PowerView.ps1
```

### 2. **Bilgi Toplama**
#### Etki Alanı Bilgisi Toplama
Etki alanı hakkında temel bilgileri toplamak için:
```powershell
Get-NetDomain
```
Bu komut, mevcut etki alanı hakkında bilgi döndürür.

#### Kullanıcıları Listeleme
Etki alanındaki tüm kullanıcıları listelemek için:
```powershell
Get-NetUser
```

#### Grupları Listeleme
Etki alanındaki grupları listelemek için:
```powershell
Get-NetGroup
```

#### Bilgisayarları Listeleme
Etki alanındaki bilgisayarları listelemek için:
```powershell
Get-NetComputer
```

#### Oturum Açmış Kullanıcıları Tespit Etme
Bir bilgisayarda oturum açmış kullanıcıları tespit etmek için:
```powershell
Get-NetLoggedon -ComputerName "TARGET_COMPUTER"
```

#### ACL Bilgilerini Keşfetme
Belirli bir Active Directory nesnesinin ACL bilgilerini analiz etmek için:
```powershell
Get-ObjectAcl -SamAccountName "TARGET_OBJECT" -ResolveGUIDs
```

### 3. **Gelişmiş Kullanım**
#### Grup Üyelerini Listeleme
Belirli bir grubun üyelerini listelemek için:
```powershell
Get-NetGroupMember -GroupName "GROUP_NAME"
```

#### Servis Hesaplarını Bulma
Etki alanındaki servis hesaplarını tespit etmek için:
```powershell
Find-ManagedAccounts
```

#### Güvenlik Zafiyetlerini Araştırma
Zayıf ACL yapılandırmalarını keşfetmek için:
```powershell
Invoke-ACLScanner
```

---

## Örnek Senaryo
Bir Active Directory ortamında bilgi toplama yapmak istediğinizi varsayalım:

1. **Etki Alanı ve Kullanıcı Bilgilerini Toplama:**
   ```powershell
   Get-NetDomain
   Get-NetUser
   ```
   Bu komutlar, etki alanı ve kullanıcı bilgilerini döndürür.

2. **Bilgisayarları Listeleme:**
   ```powershell
   Get-NetComputer
   ```
   Etki alanındaki tüm bilgisayarları listeleyin.

3. **ACL Zayıflıklarını Analiz Etme:**
   ```powershell
   Invoke-ACLScanner
   ```
   Zayıf ACL yapılandırmalarını kontrol edin.

---

## Güvenlik Notları
PowerView.ps1 yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, yalnızca sistem yöneticilerinin güvenlik açıklarını tespit etmesine ve gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [PowerView.ps1 GitHub](https://github.com/PowerShellMafia/PowerSploit)
- [Resmi Belgeler](https://github.com/PowerShellMafia/PowerSploit)

---

Bu rehber, PowerView.ps1 betiğini kullanarak Active Directory ortamlarında bilgi toplama ve zafiyet analizi yapmanın temellerini kapsamaktadır. Daha fazla bilgi veya yardım için GitHub sayfasını ziyaret edin.
