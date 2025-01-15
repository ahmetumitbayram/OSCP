**Windows Privilege Escalation: Exploiting Vulnerabilities (Zafiyetlerin Kullanılması)**

Windows sistemlerinde, yazılım veya işletim sisteminin farklı versiyonlarında bulunan güvenlik zafiyetleri, saldırganların yetkilerini artırmasına olanak tanır. Bu bölümde yaygın olarak kullanılan zafiyet türleri ve bunların nasıl sömürülebileceği detaylı şekilde açıklanmıştır.

---

### **2.1. Kernel Exploits (Çekirdek Zafiyetleri)**

Windows işletim sisteminin çekirdeğinde bulunan güvenlik açıkları, genellikle kullanıcıdan sistem veya çekirdek (kernel) düzeyine yetki yükseltmek için kullanılır.

#### **Örnekler**
- **CVE-2021-34527 (PrintNightmare):** Print Spooler servisindeki zafiyet, uzaktan kod çalıştırma ve yetki yükseltme için kullanılır.
- **CVE-2018-8120:** Hatalı erişim kontrolü nedeniyle kernel seviyesine çıkılabilir.

#### **Tespit Yöntemi**
- İşletim sistemi versiyonunu öğrenmek için:
  ```cmd
  systeminfo
  ```
- Çalışan yamaları görmek için:
  ```cmd
  wmic qfe list
  ```

#### **Kötüye Kullanma**
1. Zafiyeti araştırın ve kullanılabilir exploitleri belirleyin.
2. Exploit scriptini veya aracı çalıştırarak yetki yükseltin.

---

### **2.2. Microsoft Patch Exploits**

Microsoft tarafından yamalanmış eski zafiyetler, güncellenmemiş sistemlerde hala kullanılabilir.

#### **Örnekler**
- **MS16-032:** Windows Task Scheduler'daki zafiyet, sistem hakları kazandırabilir.
- **MS14-068 (Kerberos Vulnerability):** Domain ortamında Kerberos biletlerini manipüle ederek Domain Admin yetkisi alınabilir.

#### **Tespit Yöntemi**
- Exploit veritabanlarında kullanılabilir zafiyetleri arayın.
  - **Windows Exploit Suggester:** Güncel olmayan yamaları tespit eder.
  - **Metasploit:** Exploit modüllerini çalıştırır.

#### **Kötüye Kullanma**
1. İlgili exploitin metasploit modülünü çalıştırın:
   ```cmd
   msfconsole
   use exploit/windows/local/ms16_032_secondary_logon_handle_privesc
   set SESSION [session_id]
   run
   ```

---

### **2.3. Token Impersonation (Erişim Belirteçlerini Ele Geçirme)**

Windows'ta erişim belirteçleri (tokens), yetkilendirme için kullanılır. Zafiyetli sistemlerde belirteçler taklit edilebilir.

#### **Nasıl Çalışır?**
- Saldırgan, `SeImpersonatePrivilege` veya `SeAssignPrimaryTokenPrivilege` ayrıcalığını kullanarak yetkili bir kullanıcının belirtecini ele geçirebilir.

#### **Araçlar**
- **JuicyPotato / PrintSpoofer:** Belirteç manipülasyonu için kullanılır.

#### **Kötüye Kullanma**
1. SeImpersonatePrivilege yetkisine sahip olup olmadığınızı kontrol edin:
   ```cmd
   whoami /priv
   ```
2. JuicyPotato veya PrintSpoofer çalıştırarak SYSTEM yetkisi kazanın:
   ```cmd
   JuicyPotato.exe -l 1337 -p cmd.exe -t *
   ```

---

### **2.4. Uygulama Zafiyetleri (Third-party Software Vulnerabilities)**

Üçüncü taraf yazılımlardaki zafiyetler, sistem üzerinde yetki artırmak için kullanılabilir.

#### **Örnekler**
- **Adobe Acrobat:** Eski sürümlerinde uzaktan kod çalıştırma zafiyetleri.
- **VMware Tools:** Yanlış yapılandırmalar veya eski sürüm exploitleri.

#### **Tespit Yöntemi**
1. Yüklü programları kontrol edin:
   ```cmd
   wmic product get name,version
   ```
2. Exploit veritabanlarından zafiyetleri araştırın:
   - [Exploit-DB](https://www.exploit-db.com/)
   - [CVE Details](https://www.cvedetails.com/)

---

### **2.5. Exploiting Security Features (Güvenlik Özelliklerini Kötüye Kullanma)**

Windows'un güvenlik özellikleri bazen yanlış yapılandırılır veya zafiyet barındırır. Bu özelliklerin kötüye kullanılması privilege escalation sağlayabilir.

#### **Örnekler**
- **UAC Bypass (User Account Control):**
  - UAC koruması zayıf ayarlandığında, saldırgan kodu yönetici yetkisiyle çalıştırabilir.
- **SeDebugPrivilege Abuse:**
  - Sistem üzerindeki işlemleri debug ederek kod eklenebilir.

#### **Kötüye Kullanma**
- UAC atlatma örneği (metasploit ile):
  ```cmd
  msfconsole
  use exploit/windows/local/bypassuac
  set SESSION [session_id]
  run
  ```

---

### **2.6. Exploit Frameworks**

Zafiyetleri tespit etmek ve exploit çalıştırmak için birçok framework kullanılabilir:
- **Metasploit Framework:** Yaygın zafiyetlerin exploitleri için.
- **Cobalt Strike:** Post-exploitation framework.
- **Windows Exploit Suggester:** Güncel olmayan yamaları tespit etmek için.

---

### **Araçlar ve Komutlar**
- **Mimikatz:** Şifre ve belirteç bilgilerini çalmak için.
- **Metasploit:** Exploitler için güçlü bir framework.
- **Windows Exploit Suggester:** Güncellenmemiş yamaları kontrol eder.

---

Bu zafiyetlerin çoğu, sistemin yamalarının güncellenmemesi veya güvenlik özelliklerinin yanlış yapılandırılmasından kaynaklanır. Hangi yöntemi derinlemesine öğrenmek isterseniz, size özel bir rehber hazırlayabilirim. 😊
