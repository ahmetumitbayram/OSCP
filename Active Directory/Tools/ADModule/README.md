# ADModule Kullanım Kılavuzu

## Giriş
ADModule, PowerShell kullanarak Active Directory yönetimi için geliştirilmiş bir araçtır. "Microsoft.ActiveDirectory.Management.dll" dosyası, bu modülün temel bileşenlerinden biridir ve Active Directory ortamındaki nesneleri yönetmek için gerekli işlevleri sağlar.

Bu rehberde, ADModule'un nasıl kullanılacağı, nasıl yükleneceği ve örnek komutlarla neler yapılabileceği açıklanmaktadır.

---

## Gereksinimler
- PowerShell (sürüm 5.1 veya üstü)
- Active Directory ortamına erişim yetkisi olan bir kullanıcı hesabı
- ADModule dosyaları (örneğin, `Microsoft.ActiveDirectory.Management.dll`)

---

## Modülün Yüklenmesi
ADModule, PowerShell üzerine manuel olarak yüklenir. Aşağıdaki adımları takip ederek modülü yükleyebilirsiniz:

### 1. DLL Dosyasını İçe Aktarma
ADModule'u kullanmak için önce DLL dosyasını PowerShell'e içe aktarmanız gerekir. Bunun için şu komutu çalıştırın:

```powershell
Import-Module -Name "C:\Path\To\Microsoft.ActiveDirectory.Management.dll"
```
> Not: `C:\Path\To\` kısmını DLL dosyanızın bulunduğu dizinle değiştirin.

### 2. Modülün Başarıyla Yüklendiğini Doğrulama
Aşağıdaki komutu çalıştırarak modülün yüklendiğini doğrulayabilirsiniz:

```powershell
Get-Module -ListAvailable
```
Çıktıda `Microsoft.ActiveDirectory.Management` modülünü görmelisiniz.

---

## Temel Komutlar ve Kullanım
ADModule, Active Directory kullanıcılarını, gruplarını ve diğer nesneleri yönetmek için çeşitli komutlar sağlar. Aşağıda sık kullanılan komutlardan bazıları verilmiştir.

### 1. **Active Directory Kullanıcıları Listeleme**
Active Directory'deki tüm kullanıcıları listelemek için:

```powershell
Get-ADUser -Filter *
```

### 2. **Yeni Kullanıcı Oluşturma**
Yeni bir kullanıcı eklemek için:

```powershell
New-ADUser -Name "Ahmet Ümit BAYRAM" -GivenName "Ahmet" -Surname "BAYRAM" -SamAccountName "abayram" -UserPrincipalName "abayram@domain.com" -Path "OU=Users,DC=domain,DC=com" -AccountPassword (ConvertTo-SecureString "Password123" -AsPlainText -Force) -Enabled $true
```

### 3. **Kullanıcı Bilgilerini Güncelleme**
Var olan bir kullanıcının bilgilerini güncellemek için:

```powershell
Set-ADUser -Identity "abayram" -EmailAddress "abayram@domain.com" -Title "Senior Engineer"
```

### 4. **Kullanıcıyı Silme**
Bir kullanıcıyı Active Directory'den silmek için:

```powershell
Remove-ADUser -Identity "abayram"
```

### 5. **Active Directory Gruplarını Listeleme**
Active Directory'deki tüm grupları listelemek için:

```powershell
Get-ADGroup -Filter *
```

### 6. **Yeni Grup Oluşturma**
Yeni bir grup oluşturmak için:

```powershell
New-ADGroup -Name "Pentest Team" -SamAccountName "PentestTeam" -GroupCategory Security -GroupScope Global -Path "OU=Groups,DC=domain,DC=com"
```

### 7. **Bir Kullanıcıyı Gruba Ekleme**
Bir kullanıcıyı belirli bir gruba eklemek için:

```powershell
Add-ADGroupMember -Identity "Pentest Team" -Members "abayram"
```

---

## Hata Ayıklama
Eğer ADModule veya komutları çalıştırırken hata alıyorsanız, aşağıdaki kontrolleri yapın:

1. **Bağlantı Sorunları:**
   Active Directory sunucusuna erişim için ağ bağlantınızı kontrol edin.

2. **Yetki Sorunları:**
   Active Directory'deki işlemleri gerçekleştirmek için yeterli izinlere sahip olduğunuzdan emin olun.

3. **DLL Dosyasının Konumu:**
   `Import-Module` komutunda doğru yolu kullandığınızdan emin olun.

---

## Lisans
ADModule, açık kaynaklı bir yazılımdır ve ilgili lisans koşulları GitHub deposunda belirtilmiştir.

---

## İletişim
Bu araç hakkında daha fazla bilgi almak veya geri bildirimde bulunmak için GitHub sayfasını ziyaret edebilirsiniz: [ADModule GitHub](https://github.com/samratashok/ADModule)
