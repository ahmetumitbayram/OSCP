**Linux Pentest Enumeration Rehberi**

Bu rehber, Linux pentest sürecinde önemli olan enumeration safhasını kapsamılı bir şekilde ele alır. Tüm güncel yöntemler, komutlar, trikler ve araçlar içerir. İlk adımdan itibaren, bir sısteme bağlantı kurduktan sonra hangi bilgilere odaklanmanız gerektiğini detaylandırır.

---

### 1. **Bağlantı Kontrolü**
Bağlandığınız sistemdeki çevreyi tanımak için başlangıçta aşağıdaki komutlar kullanılır:

#### Temel Sistem Bilgileri:
- Sistemin hostname bilgisini almak:
  ```bash
  hostname
  uname -a
  cat /etc/os-release
  lsb_release -a
  ```

- Kullanıcı bilgileri:
  ```bash
  whoami
  id
  cat /etc/passwd
  cat /etc/shadow  # Root yetkisi gerekiyorsa alternatif exploitler araştırılmalı.
  ```

#### Aktif Kullanıcılar ve Oturumlar:
- Şu an bağlı kullanıcıları görmek:
  ```bash
  who
  w
  last -a
  ```

- Bağlantı yapan IP adreslerini görmek:
  ```bash
  netstat -antp
  ss -tuln
  ```

---

### 2. **Dosya ve Dizin Yapısı**
Hangi dizinlerin ilginç olduğunu anlamak önemlidir.

#### Önemli Diziler:
- Root veya yetkili dosyalara erişim:
  ```bash
  find / -type f -perm -u=s 2>/dev/null
  find / -type f -name '*.conf' 2>/dev/null
  find /var/www -type f 2>/dev/null
  ```

#### Dosya Ayrıcalıkları:
- Kritik dosyalardaki yetkileri kontrol etmek:
  ```bash
  ls -la /etc/passwd
  ls -la /etc/shadow
  ```

#### Cron Jobları ve Zamanlanmış Görevler:
- Cron dosyaları:
  ```bash
  cat /etc/crontab
  ls -la /etc/cron.*
  ```
- Kullanıcıya özel cronlar:
  ```bash
  ls -la /var/spool/cron/crontabs
  ```

---

### 3. **Ağ Bilgisi Toplama**

#### Şebeke Arayüzleri ve Ayarları:
- Mevcut arayüzleri listelemek:
  ```bash
  ip addr
  ifconfig
  ```

#### DNS ve Host Bilgileri:
- DNS bilgilerini kontrol etmek:
  ```bash
  cat /etc/resolv.conf
  cat /etc/hosts
  ```

#### Bağlantılar:
- İşleyen servisleri ve portları görmek:
  ```bash
  netstat -tulpn
  lsof -i
  ss -tuln
  ```

---

### 4. **Servis ve Uygulama Bilgisi**

#### Yüklenen Servisler:
- Hangi servislerin aktif olduğunu kontrol etmek:
  ```bash
  systemctl list-units --type=service
  ps aux
  ```

#### Çalışan Uygulamalar:
- Aktif süreçler:
  ```bash
  ps -ef
  top
  ```

#### Web Servisleri:
- Web sunucusu dosyaları:
  ```bash
  ls -la /var/www/html
  cat /var/www/html/index.php
  ```

---

### 5. **Yetki Yükseltme Fırsatları**

#### SUID ve SGID Bitleri:
- Yetkili dosyaları taramak:
  ```bash
  find / -type f -perm /4000 2>/dev/null
  ```

#### Zafiyetli Yazılımlar:
- Sistemdeki yazılım sürümlerini kontrol etmek:
  ```bash
  dpkg -l
  rpm -qa
  ```

#### Kernel Sürümü:
- Kernel exploitlerini araştırmak:
  ```bash
  uname -r
  ```

---

### 6. **Araçlar ve Scriptler**

#### Linux Enumeration Araçları:
1. **LinPEAS**: Yetki yükseltme fırsatlarını otomatik tarar.
   ```bash
   wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
   chmod +x linpeas.sh
   ./linpeas.sh
   ```

2. **LinEnum**: Sistemin detaylı bilgilerini listeler.
   ```bash
   wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
   chmod +x LinEnum.sh
   ./LinEnum.sh
   ```

3. **Linux Exploit Suggester**: Kernel exploitleri tespit eder.
   ```bash
   wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh
   chmod +x linux-exploit-suggester.sh
   ./linux-exploit-suggester.sh
   ```

#### Genel Pentest Araçları:
- **Nmap**: Ağ taraması için kullanılır.
  ```bash
  nmap -sC -sV -oN output.txt <hedef_ip>
  ```

- **Hydra**: Brute force aracı.
  ```bash
  hydra -l admin -P password.txt ssh://<hedef_ip>
  ```

- **Metasploit**: Exploit çalıştırma ve oturum yönetimi.
  ```bash
  msfconsole
  ```

---

### 7. **Trick ve Püf Noktaları**
- **.bash_history**: Kullanıcının komut geçmişine erişim.
  ```bash
  cat ~/.bash_history
  ```

- **Dosya Sistemindeki Yedekler**: Yedek dosyalarda hassas bilgiler olabilir.
  ```bash
  find / -name '*.bak' 2>/dev/null
  ```

- **Hardcoded Credentials**: Konfigürasyon dosyalarında yer alan sabit şifreler.
  ```bash
  grep -r 'password' /etc/
  ```

---

Bu rehber, Linux pentest enumeration safhasında ihtiyacınız olan tüm metod ve yöntemleri kapsar. Her bir adımın, sistem üzerindeki bilgilerle daha derine inmek için nasıl kullanılabileceği detaylandırılmıştır.

