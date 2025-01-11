# OSCP Sınavı İçin Password Spraying Araç ve Yöntemleri

Bu doküman, OSCP sınavına hazırlık için password spraying (parola spreyi) süreçlerinde kullanılabilecek tüm araç ve yöntemleri kapsar. Her araç ve yöntemin kullanımı detaylı bir şekilde anlatılmıştır.

---

## 1. Password Spraying Nedir?

**Password Spraying**, bir grup kullanıcı hesabında yaygın olarak kullanılan bir parolayı deneme yöntemidir. Bu yöntemde, kullanıcı adları listesine tek bir parola uygulanarak hesap kilitlenme riskini azaltır.

---

## 2. Password Spraying Araçları

### 2.1. Hydra
- **Tanıtım:** Hydra, çok yönlülü ve popüler bir brute force aracıdır. SSH, FTP, HTTP, RDP ve daha fazlasını destekler.
- **Kurulum:**
  ```bash
  sudo apt install hydra
  ```
- **Kullanım:**
  ```bash
  hydra -L kullanici_listesi.txt -P parola.txt hedef_ip ssh
  ```

### 2.2. CrackMapExec
- **Tanıtım:** Active Directory ortamında password spraying için kullanılan bir çok yönlülü aracıdır.
- **Kurulum:**
  ```bash
  pip install crackmapexec
  ```
- **Kullanım:**
  ```bash
  cme smb hedef_ip -u kullanici_listesi.txt -p "123456"
  ```

### 2.3. Ruler
- **Tanıtım:** Outlook Web Access (OWA) ve Exchange sunucularında password spraying yapabilir.
- **Kurulum:**
  ```bash
  go install github.com/sensepost/ruler@latest
  ```
- **Kullanım:**
  ```bash
  ruler spray -d domain.com -u kullanici_listesi.txt -p "Password123"
  ```

### 2.4. Metasploit Framework
- **Tanıtım:** Metasploit, yerleşik modülleri ile password spraying yapabilir.
- **Kurulum:**
  ```bash
  sudo apt install metasploit-framework
  ```
- **Kullanım:**
  ```bash
  use auxiliary/scanner/http/owa_login
  set RHOSTS hedef_ip
  set USER_FILE kullanici_listesi.txt
  set PASS_FILE parola.txt
  run
  ```

### 2.5. Kerbrute
- **Tanıtım:** Kerberos ortamlarında SPN ve username spraying için kullanılır.
- **Kurulum:**
  ```bash
  go install github.com/ropnop/kerbrute@latest
  ```
- **Kullanım:**
  ```bash
  kerbrute spray -d domain.com -U kullanici_listesi.txt -p "Password123"
  ```

### 2.6. Nmap
- **Tanıtım:** Nmap betikleriyle SSH, SMB gibi servislerde password spraying yapabilirsiniz.
- **Kurulum:**
  ```bash
  sudo apt install nmap
  ```
- **Kullanım:**
  ```bash
  nmap --script ssh-brute --script-args userdb=kullanici_listesi.txt,passdb=parola.txt -p 22 hedef_ip
  ```

### 2.7. Impacket
- **Tanıtım:** SMB, Kerberos ve LDAP için kullanılabilecek Python tabanlı bir kütüphane seti.
- **Kurulum:**
  ```bash
  pip install impacket
  ```
- **Kullanım:**
  ```bash
  smbclient.py -target-ip hedef_ip -username kullanici -password parola
  ```

---

## 3. Password Spraying Yöntemleri

### 3.1. Kullanıcı Adı ve Parola Formatları
- Kullanıcı adlarını tahmin ederken şu formatlar denenebilir:
  - isim.soyisim
  - isim_soyisim
  - isimsoyisim
  - i.soyisim
- Parola formatları:
  - Password123
  - CompanyName2023
  - Welcome123

### 3.2. Zamanlama ve Kilitlenme Kontrolü
- Maksimum deneme sayısını geçmemeye dikkat edin.
- Her deneme arasında 1-2 saniye bekleme kullanın.

### 3.3. Tespit Edilmekten Kaçınma
- Araçların log oluşturabileceği unutulmamalıdır.
- Proxy veya VPN kullanılabilir.

---

## 4. Ek Kaynaklar
- [HackTricks: Password Spraying](https://book.hacktricks.xyz/)
- [CrackMapExec Documentation](https://github.com/byt3bl33d3r/CrackMapExec)
- [Kerbrute GitHub](https://github.com/ropnop/kerbrute)

---

Bu rehber OSCP sınavınıza hazırlıkta size yardımcı olması için hazırlanmıştır. Hedef sistemlerde etik kuralları ihlal etmemeye özen gösterin.
