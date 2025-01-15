**Windows Privilege Escalation: Network Exploitation (Ağ İle İlgili Açıklardan Faydalanma)**

Windows sistemlerinde ağ bağlantıları ve protokolleri genellikle yanlış yapılandırmalar veya zafiyetlere sahiptir. Saldırganlar, bu açıklardan faydalanarak ağ üzerinden privilege escalation gerçekleştirebilir. Aşağıda ağ tabanlı privilege escalation yöntemleri detaylı bir şekilde açıklanmıştır.

---

### **9.1. SMB Relay Attacks (SMB Yönlendirme Saldırıları)**

SMB protokolü, Windows ağ paylaşımları için kullanılır. SMB relay saldırıları, kimlik bilgilerini yakalayıp hedef bir makineye yeniden yönlendirme esasına dayanır.

#### **Tespit**
- SMB hizmetinin açık olup olmadığını kontrol edin:
  ```cmd
  nmap -p445 [target-ip]
  ```
- `Responder` gibi araçlarla hedef ağda SMB trafiğini analiz edin.

#### **Kötüye Kullanma**
1. **Responder** ile SMB kimlik bilgilerini yakalayın:
   ```bash
   responder -I eth0
   ```
2. Yakalanan kimlik bilgilerini kullanarak bir hedef makineye kimlik doğrulama yapın:
   ```cmd
   impacket-psexec user@target
   ```

---

### **9.2. RDP Hijacking (Uzak Masaüstü Kaçırma)**

RDP (Remote Desktop Protocol) oturumları, yanlış yapılandırıldığında veya yetersiz şekilde güvenli hale getirildiğinde saldırganlar tarafından ele geçirilebilir.

#### **Tespit**
- RDP’nin açık olup olmadığını kontrol edin:
  ```cmd
  nmap -p3389 [target-ip]
  ```
- Var olan oturumları kontrol etmek için:
  ```cmd
  qwinsta
  ```

#### **Kötüye Kullanma**
1. Var olan oturumu listeleyin ve ID’sini bulun.
2. Oturumu ele geçirmek için:
   ```cmd
   tscon [ID] /dest:console
   ```

---

### **9.3. LLMNR/NBT-NS Poisoning**

LLMNR (Link-Local Multicast Name Resolution) ve NBT-NS (NetBIOS Name Service), ağda isim çözümlemek için kullanılır. Bu protokoller zayıf güvenlik mekanizmalarına sahiptir ve zehirlenebilir.

#### **Kötüye Kullanma**
1. **Responder** kullanarak LLMNR/NBT-NS poisoning gerçekleştirin:
   ```bash
   responder -I eth0
   ```
2. Yakalanan hash’leri brute-force veya pass-the-hash saldırılarında kullanın.

---

### **9.4. LDAP Exploitation (LDAP İstismarları)**

LDAP (Lightweight Directory Access Protocol), Active Directory bilgilerinin alınması için kullanılır. Yanlış yapılandırıldığında hassas bilgiler ifşa edilebilir.

#### **Tespit**
- LDAP’in açık olup olmadığını kontrol edin:
  ```cmd
  nmap -p389 [target-ip]
  ```

#### **Kötüye Kullanma**
1. Anonim LDAP oturumlarını test edin:
   ```bash
   ldapsearch -x -h [target-ip] -b "dc=domain,dc=com"
   ```
2. Hassas bilgileri alın ve privilege escalation için kullanın (örneğin, kullanıcı hash’leri).

---

### **9.5. DNS Zone Transfer**

Yanlış yapılandırılmış DNS sunucuları, zone transfer işlemlerine izin verebilir. Bu işlem, tüm DNS kayıtlarının alınmasına olanak tanır.

#### **Kötüye Kullanma**
1. Zone transfer yapmaya çalışın:
   ```cmd
   nslookup
   server [dns-server-ip]
   ls -d domain.com
   ```

2. Elde edilen DNS kayıtlarını kullanarak diğer hedefleri belirleyin.

---

### **9.6. Network Shares Exploitation (Ağ Paylaşımlarının İstismarı)**

Yanlış yapılandırılmış ağ paylaşımları, saldırganların hassas bilgilere erişmesine izin verebilir.

#### **Tespit**
- Açık ağ paylaşımlarını kontrol edin:
   ```cmd
   net view \\[target-ip]
   ```

#### **Kötüye Kullanma**
1. Yazılabilir bir paylaşım bulun.
2. Paylaşıma zararlı bir dosya yerleştirin veya mevcut bir dosyayı değiştirin.

---

### **9.7. ARP Poisoning**

ARP (Address Resolution Protocol), yerel ağdaki IP adreslerini MAC adreslerine eşler. Bu protokol saldırganlar tarafından zehirlenebilir.

#### **Kötüye Kullanma**
1. **Ettercap** veya **Bettercap** kullanarak ARP poisoning gerçekleştirin:
   ```bash
   bettercap -iface eth0
   arp.spoof on
   ```
2. Hedef makinenin trafiğini manipüle edin veya kimlik bilgilerini yakalayın.

---

### **9.8. NTLM Relay**

NTLM protokolü, ağ üzerinde kimlik doğrulama için kullanılır. NTLM relay saldırılarında, kimlik bilgileri hedef bir sisteme yönlendirilerek yetki kazanılır.

#### **Kötüye Kullanma**
1. **Impacket ntlmrelayx** kullanarak kimlik bilgilerini yakalayın ve yönlendirin:
   ```bash
   ntlmrelayx.py -t smb://[target-ip]
   ```

---

### **9.9. Proxy Exploitation**

Bazı ağlarda proxy sunucuları güvenlik mekanizması olarak kullanılır. Yanlış yapılandırılmış proxy sunucuları privilege escalation için kullanılabilir.

#### **Kötüye Kullanma**
1. Proxy sunucusunu analiz edin.
2. Proxy üzerinden hassas servislere erişim sağlayın.

---

### **9.10. Tools for Network Exploitation**

- **Responder:** LLMNR/NBT-NS poisoning için.
- **Impacket Suite:** SMB, LDAP ve NTLM relay saldırıları için araçlar içerir.
- **Bettercap/Ettercap:** ARP poisoning için.
- **Nmap:** Port taraması ve ağ analizi için.
- **Metasploit Framework:** Ağ tabanlı exploit modülleri için.

---

### **Örnek Senaryo**

- **Hedef:** SMB relay saldırısı ile SYSTEM yetkisi elde etmek.
- **Adımlar:**
  1. Responder ile SMB kimlik bilgilerini yakalayın.
  2. Impacket psexec kullanarak yakalanan hash ile hedef sisteme bağlanın:
     ```bash
     psexec.py -hashes [LM_HASH]:[NTLM_HASH] user@target-ip
     ```

---
