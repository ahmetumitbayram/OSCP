Windows için **Privilege Escalation** yöntemleri, çeşitli güvenlik açıkları, yanlış yapılandırmalar veya sistem özelliklerinin kötüye kullanılmasıyla elde edilebilir. İşte başlık başlık Windows için yaygın kullanılan privilege escalation yöntemleri:

---

### **1. Exploiting Misconfigurations (Yanlış Yapılandırmaları Kullanma)**
- **Unquoted Service Paths:** Hizmet yollarının tırnak işareti olmaması.
- **Weak Service Permissions:** Servis dosyalarının veya çalıştırma izinlerinin zayıf olması.
- **DLL Hijacking:** Sistem tarafından yüklenen DLL'lerin kontrol edilmesi ve kötü amaçlı DLL eklenmesi.
- **Insecure Registry Permissions:** Kritik kayıt defteri anahtarlarının izinlerinin zayıf olması.
- **Insecure File Permissions:** Sistem dosyalarının veya uygulama dosyalarının yazılabilir olması.
- **Stored Credentials in Registry or Files:** Şifrelerin düz metin olarak saklanması.

---

### **2. Exploiting Vulnerabilities (Zafiyetlerin Kullanılması)**
- **Kernel Exploits:** İşletim sisteminin çekirdeğinde bulunan zafiyetler (örn. CVE-2021-34527 - PrintNightmare).
- **MS16-032, MS14-068 Exploits:** Microsoft'un yamaladığı bilinen zafiyetler.
- **Token Impersonation Exploits:** Windows Token'larının ele geçirilmesi ve impersonation.

---

### **3. Credential Harvesting (Kimlik Bilgisi Toplama)**
- **SAM Database Dump:** SAM dosyasını dump ederek kullanıcı şifrelerinin kırılması.
- **LSASS Process Dumping:** LSASS (Local Security Authority Subsystem Service) işlemini dump ederek şifrelerin alınması.
- **Credential Managers and Vaults:** Credential Manager veya Password Vault'lardan şifreleri almak.

---

### **4. Abusing Scheduled Tasks and Cron Jobs**
- **Malicious Scheduled Tasks:** Var olan bir zamanlanmış görevin değiştirilmesi veya yenisinin eklenmesi.
- **Tampered Startup Applications:** Başlangıçta çalıştırılan uygulamalara zararlı ekleme yapılması.

---

### **5. Abusing Windows Features**
- **AlwaysInstallElevated:** Uygulama yükleme politikalarının kötüye kullanılması.
- **Bypassing UAC (User Account Control):** Kullanıcı Hesap Denetimi atlatma yöntemleri.
- **Windows Services:** Zayıf yapılandırılmış veya güvenli olmayan servislerin kullanılması.

---

### **6. Active Directory Abuse**
- **Kerberoasting:** Kerberos biletiyle kullanıcı hash'lerini elde etmek.
- **ASREPRoasting:** Asrep biletiyle şifre hash'lerini almak.
- **Abusing GPO Permissions:** Group Policy Object'lerdeki zayıflıkların kötüye kullanılması.
- **Pass-the-Hash:** Hash değerleriyle kimlik doğrulama yapma.
- **Pass-the-Ticket:** Kerberos biletlerini yeniden kullanma.

---

### **7. Software Exploitation**
- **Third-party Application Vulnerabilities:** Üçüncü taraf yazılımlardaki açıkların kullanılması.
- **Weak Updaters:** Güncelleme mekanizmalarının zayıf olması.
- **Reverse Engineering:** Yazılımların tersine mühendislik ile exploit edilmesi.

---

### **8. Exploiting Security Features**
- **SeDebugPrivilege Abuse:** Debug ayrıcalıklarını kötüye kullanmak.
- **SeImpersonatePrivilege Abuse:** Impersonate ayrıcalığını kullanmak (örn. PrintSpoofer, JuicyPotato).
- **SeBackupPrivilege Abuse:** Yedekleme ayrıcalığını kullanarak dosyalara erişim.

---

### **9. Network Exploitation**
- **SMB Relay Attacks:** SMB protokolündeki zafiyetlerin kullanılması.
- **RDP Hijacking:** Uzak Masaüstü oturumlarının ele geçirilmesi.
- **DLL Injection Over Network Shares:** Ağ paylaşımlarına kötü amaçlı DLL eklemek.

---

### **10. Physical Access Attacks**
- **Offline Password Cracking:** Sisteme fiziksel erişimle SAM dosyasını alıp şifreleri kırmak.
- **Boot-to-Live CD/USB Attacks:** Live OS kullanarak şifreleri değiştirmek veya dosyalara erişim sağlamak.

---

### **11. Privilege Escalation Through Malware**
- **Keylogging:** Yönetici oturumlarının loglanması.
- **Ransomware Escalation:** Dosyaların şifrelenmesiyle ayrıcalık elde edilmesi.

---

### **12. Miscellaneous Techniques**
- **Token Manipulation:** Erişim belirteçlerini manipüle ederek ayrıcalık artırma.
- **Environment Variable Exploits:** Çevresel değişkenlerdeki açıklardan faydalanma.
- **Abusing Windows Subsystem for Linux (WSL):** WSL'yi exploit ederek ayrıcalık artırma.

---
