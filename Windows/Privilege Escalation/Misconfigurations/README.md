**Windows Privilege Escalation: Exploiting Misconfigurations (Yanlış Yapılandırmalar)**

Yanlış yapılandırmalar, sistem yöneticilerinin yaptığı hatalardan veya varsayılan ayarların güvensiz olmasından kaynaklanır. Bu tür açıklardan faydalanarak kullanıcı yetkileri yükseltilebilir. Aşağıda en sık karşılaşılan yanlış yapılandırmalar ve bunların nasıl kullanılabileceğine dair detaylı bir rehber sunulmaktadır:

---

### **1.1. Unquoted Service Paths (Tırnaksız Hizmet Yolları)**

Windows hizmet yolları tırnaklarla çevrilmemişse, saldırganlar kötü niyetli bir dosya çalıştırabilir.

#### **Nasıl Çalışır?**
- Örneğin, bir servis şu şekilde yapılandırılmışsa:
  ```
  C:\Program Files\My App\MyService.exe
  ```
  Ancak bu yol tırnak işaretleriyle çevrilmemişse, Windows `C:\Program.exe` dosyasını çalıştırabilir.

#### **Tespit Yöntemi**
```cmd
wmic service get name,displayname,pathname,startmode | findstr /i "Auto" | findstr /i /v "C:\Windows\\" | findstr /i /v """
```

#### **Kötüye Kullanma**
1. Hedef klasöre erişiminiz varsa, `C:\Program.exe` adında bir dosya oluşturun.
2. Bu dosyaya kötü amaçlı bir payload yerleştirin.
3. Hizmeti yeniden başlatın:
   ```cmd
   net stop [service_name] && net start [service_name]
   ```

---

### **1.2. Weak Service Permissions (Zayıf Hizmet İzinleri)**

Servis dosyalarının veya çalıştırma izinlerinin zayıf olması, saldırganın dosyayı değiştirmesine olanak tanır.

#### **Nasıl Çalışır?**
- İlgili servis dosyasına yazma izni olan herhangi bir kullanıcı, dosyayı değiştirebilir ve zararlı kod çalıştırabilir.

#### **Tespit Yöntemi**
```cmd
accesschk.exe -uwcqv "Authenticated Users" * /svc
```
#### **Kötüye Kullanma**
1. Yazılabilir bir servis dosyası bulun.
2. Dosyayı bir reverse shell veya zararlı payload ile değiştirin.
3. Servisi yeniden başlatın.

---

### **1.3. DLL Hijacking (DLL Kaçırma)**

Windows, bir uygulama çalıştırılırken gerekli DLL dosyalarını belirli bir sırayla arar. Bu süreç manipüle edilebilir.

#### **Nasıl Çalışır?**
- Eğer bir uygulama, çalıştırma sırasında eksik bir DLL arıyorsa, saldırgan aynı adla kötü niyetli bir DLL oluşturabilir.

#### **Tespit Yöntemi**
- Eksik DLL'leri tespit etmek için:
  ```cmd
  procmon.exe
  ```

#### **Kötüye Kullanma**
1. Hedef uygulamanın aradığı eksik DLL'yi bulun.
2. Aynı adla bir zararlı DLL oluşturun (ör. `msfvenom` ile).
3. DLL'yi çalıştırılabilir bir yere yerleştirin ve uygulamayı çalıştırın.

---

### **1.4. Insecure Registry Permissions (Güvensiz Kayıt Defteri İzinleri)**

Kayıt defteri anahtarlarının zayıf izinlere sahip olması, saldırganın bu anahtarları değiştirmesine olanak tanır.

#### **Nasıl Çalışır?**
- Kritik kayıt defteri anahtarları değiştirilerek saldırgan kod çalıştırılabilir.

#### **Tespit Yöntemi**
```cmd
accesschk.exe -uwcqv "Authenticated Users" HKLM\System\CurrentControlSet\Services
```

#### **Kötüye Kullanma**
1. İzin verilen bir kayıt defteri anahtarını bulun.
2. Bu anahtara bir reverse shell veya zararlı bir komut ekleyin.

---

### **1.5. Insecure File Permissions (Güvensiz Dosya İzinleri)**

Bir uygulama dosyası veya yapılandırma dosyası yazılabilir durumdaysa, bu dosya kötüye kullanılabilir.

#### **Nasıl Çalışır?**
- Uygulama dosyaları veya yapılandırma dosyaları değiştirilerek zararlı kod çalıştırılabilir.

#### **Tespit Yöntemi**
```cmd
accesschk.exe -wvu "Users" C:\Path\to\File
```

#### **Kötüye Kullanma**
1. Yazılabilir bir dosya bulun.
2. Dosyayı bir reverse shell veya zararlı kod ile değiştirin.

---

### **1.6. Stored Credentials in Registry or Files (Kayıt Defteri veya Dosyalarda Saklanan Kimlik Bilgileri)**

Sistem veya uygulama şifreleri düz metin olarak saklanıyorsa, bunlar kullanılabilir.

#### **Nasıl Çalışır?**
- Uygulama veya servis şifreleri, kayıt defterinde veya konfigürasyon dosyalarında bulunabilir.

#### **Tespit Yöntemi**
```cmd
reg query HKLM /f password /t REG_SZ /s
```

#### **Kötüye Kullanma**
1. Bulunan şifreyi alın.
2. Şifreyi kullanarak sisteme veya başka bir servise erişim sağlayın.

---

### **Araçlar**
Bu yöntemlerin uygulanmasında yardımcı olacak araçlar:
- **Sysinternals AccessChk:** İzinleri kontrol etmek için.
- **Process Monitor (Procmon):** DLL kaçırma gibi süreçleri izlemek için.
- **Metasploit:** Payload oluşturma ve servislerde zafiyet testleri için.

---
