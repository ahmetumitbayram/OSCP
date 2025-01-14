# Active Directory Pentest Tools Guide

Bu rehberde, yukarıdaki araçların hangi aşamalarda, ne için ve hangi sırayla kullanılabileceğini detaylı bir şekilde inceleyeceğiz.

---

## 1. **Keşif ve Bilgi Toplama (Enumeration)**
Active Directory ortamındaki bilgileri toplamak ve sistemin yapısını anlamak için kullanılır.

### Araçlar:
- **ADFSDump**: ADFS bilgilerini dump etmek.
- **BloodHound**: AD yapısını grafiksel olarak analiz etmek.
- **SharpHound**: BloodHound için veri toplar.
- **ADRecon**: Detaylı AD raporları oluşturur.
- **ADModule**: PowerShell ile AD enumeration yapar.
- **ldapsearch**: LDAP protokolü ile bilgi toplar.
- **ldapdomaindump**: LDAP bilgilerinin dump edilmesi.
- **Invoke-ADEnum**: AD üzerindeki kullanıcı, grup ve GPO bilgilerini toplar.
- **Powerview**: PowerShell ile kullanıcılar, gruplar ve ACL bilgileri toplar.
- **Kerbrute**: Kerberos brute force ve kullanıcı doğrulama.
- **Manspider**: Dosya sistemini tarayıp duyarlı bilgileri toplar.

### Sıralama:
1. Kerbrute ile kullanıcı doğrulama.
2. Powerview ve ADModule ile kullanıcı ve grup bilgisi toplama.
3. ldapsearch veya ldapdomaindump ile LDAP bilgisi toplama.
4. SharpHound ile BloodHound verilerini toplama.

---

## 2. **Zafiyet Analizi ve Exploitation**
Sistem üzerinde zafiyetleri bulmak ve sömürmek için kullanılır.

### Araçlar:
- **Certify**: Active Directory Certificate Services (ADCS) zafiyetlerini tespit eder.
- **ForgeCert**: Sahte sertifika oluşturur.
- **PetitPotam**: NTLM relay saldırılarını tetikler.
- **PrintSpoofer**: Print Spooler hizmeti üzerinden yetki yükseltme.
- **KrbRelay** / **KrbRelayUp**: Kerberos relay saldırıları.
- **NoPac**: MS-PAC zafiyetinden faydalanır.
- **JuicyPotato** / **GodPotato** / **SharpEfsPotato**: Local privilege escalation için.
- **bloodyAD**: Active Directory ortamında yetki yükseltme ve ACL değişiklikleri.
- **NetworkServiceExploit**: Network Service account üzerinden yetki yükseltme.
- **SCMUACBypass**: UAC bypass yöntemleri.
- **PassTheCert**: Sertifika tabanlı yetkilendirme saldırıları.
- **LockLess**: AD ACL manipülasyonu.
- **SpoolSample**: Print Spooler saldırılarını test etme.

### Sıralama:
1. Certify ile ADCS zafiyetlerini tarama.
2. PetitPotam veya PrintSpoofer ile relay saldırısı deneme.
3. JuicyPotato, SharpEfsPotato ile local privilege escalation.
4. NoPac veya KrbRelayUp ile domain admin yetkisi alma.

---

## 3. **Yetki Yükseltme (Privilege Escalation)**
Yerel ve domain üzerinde yetkilerin artırılması.

### Araçlar:
- **Rubeus**: Kerberos bileti manipülasyonu.
- **Seatbelt**: Sistem yapılandırmasını analiz eder.
- **PowerUp**: Yerel yetki yükseltme yöntemlerini tarar.
- **SharpUp**: Windows ortamında local privilege escalation.
- **SafetyKatz** / **BetterSafetyKatz**: Mimikatz alternatifi olarak.
- **KeeTheft**: KeePass parolalarını çalma.
- **LAPSToolkit**: LAPS yönetici parolalarını alma.
- **GMSAPasswordReader**: Grup yönetici hesaplarının parolalarını alma.
- **Whisker**: Yetki yükseltme testleri.

### Sıralama:
1. Seatbelt ile bilgi toplama.
2. PowerUp veya SharpUp ile zafiyet arama.
3. Rubeus ile Kerberos biletlerini manipüle etme.
4. SafetyKatz veya Mimikatz ile kimlik bilgilerini ele geçirme.

---

## 4. **Hareket (Lateral Movement)**
Bir makineden diğerine geçiş ve erişim genişletme.

### Araçlar:
- **evil-winrm**: Windows makinelerde uzak bağlantı sağlama.
- **impacket**: Farklı protokoller üzerinden etkileşim.
- **Invoke-Command**: PowerShell komutlarını çalıştırma.
- **Chisel** / **Ligolo**: Tünelleme ve proxy.
- **Responder**: NTLM bilgilerini toplama.
- **SharpMove**: AD ortamında lateral movement saldırıları.
- **SharpWMI**: WMI tabanlı lateral movement.

### Sıralama:
1. Responder ile kimlik bilgilerini toplama.
2. evil-winrm veya impacket araçlarıyla kimlik bilgilerini kullanarak oturum açma.
3. Chisel veya Ligolo ile tünelleme yapma.
4. SharpMove veya SharpWMI ile lateral movement.

---

## 5. **Parola ve Hash İşlemleri**
Sistemden toplanan parolaları analiz etme ve kırma işlemleri.

### Araçlar:
- **hashcat**: Hash kırma.
- **john**: Hash analiz ve parola kırma.
- **KeeTheft**: KeePass parolalarını çalma.
- **LAPSToolkit**: LAPS parolalarını alma.
- **GMSAPasswordReader**: Grup yönetici hesaplarının parolalarını alma.
- **Hydra**: Brute force saldırıları.
- **RunasCs**: RunAs komutunu kullanarak oturum açma.
- **RestrictedAdmin**: RDP bağlantılarında kimlik bilgisi paylaşımını önler.

### Sıralama:
1. SafetyKatz ile hash çıkarma.
2. hashcat veya john ile hash kırma.
3. LAPSToolkit ile LAPS parola okuma.
4. KeeTheft ile KeePass parola toplama.
5. Hydra ile brute force denemeleri.

---

## 6. **Raporlama**
Sonuçları düzenleyerek rapor haline getirme.

### Araçlar:
- **ADRecon**: Otomatik raporlama.
- **BloodHound**: Görsel raporlar.
- **SharpDPAPI**: DPAPI bilgilerini analiz eder.

---

Bu rehber, araçların etkin bir şekilde kullanılmasını sağlamak için hazırlanmıştır. Active Directory test süreçlerinizde referans olarak kullanabilirsiniz.
