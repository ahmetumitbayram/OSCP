### **nmapAutomator Kullanım Kılavuzu (Türkçe)**

nmapAutomator, pentest sırasında sıkça tekrarlanan tarama ve keşif (enumeration & recon) işlemlerini otomatikleştirerek zamandan tasarruf sağlamayı amaçlar. Bu araç, özellikle nmap taramalarını kolaylaştırır ve arka planda sürekli olarak keşif işlemlerini yürütür.

---

## **Özellikler**
1. **Otomatik Nmap Taramaları:**
   - Hızlı bir şekilde ağ ve port taramaları yapar.
   - Taramalar arka planda çalışırken manuel analiz yapılabilir.

2. **Taramalar:**
   - **Network:** Ağdaki tüm canlı cihazları (~15 saniye) gösterir.
   - **Port:** Açık olan tüm portları (~15 saniye) gösterir.
   - **Script:** Bulunan portlarda script taraması (~5 dakika) yapar.
   - **Full:** Tam kapsamlı port taraması yapar, ardından yeni portlar için detaylı tarama (~5-10 dakika) çalıştırır.
   - **UDP:** UDP taraması yapar (sudo yetkisi gerekir) (~5 dakika).
   - **Vulns:** CVE taraması ve nmap zafiyet taraması (~5-15 dakika).
   - **Recon:** Bulunan portlara yönelik otomatik öneriler sunar ve komutları çalıştırır.
   - **All:** Yukarıdaki tüm taramaları (~20-30 dakika) yürütür.

3. **Otomatik Keşif:**
   - Bulunan portlar için en uygun keşif araçlarını önerir ve çalıştırır.
   - Eksik araçlar tespit edilirse kurulum önerileri sunar.

4. **Herhangi bir Shell'de Çalışır:**
   - POSIX uyumlu olduğundan tüm Unix tabanlı makinelerde çalışabilir.
   - Uzak makinelerde kullanılabilir (statik bir nmap ikili dosyası indirmeniz gerekebilir).

5. **Uzak Mod (Beta):**
   - POSIX komutlarıyla tarama yapar.
   - Şu anda sadece aşağıdaki taramalar desteklenmektedir:
     - Ağ taraması (ping)
     - Port taraması
     - Tam tarama
     - UDP taraması
     - Keşif taraması

---

## **Kurulum**
### **1. Depoyu Klonlayın:**
```bash
git clone https://github.com/21y4d/nmapAutomator.git
```

### **2. Sembolik Link Oluşturun:**
```bash
sudo ln -s $(pwd)/nmapAutomator/nmapAutomator.sh /usr/local/bin/
```

---

## **Gereksinimler**
Aşağıdaki araçlar otomatik keşif işlemleri sırasında kullanılmaktadır. Eksik araçlar tespit edilirse kullanıcı bilgilendirilir:

- **Kurulması gereken araçlar:**
  ```bash
  sudo apt update
  sudo apt install ffuf gobuster -y
  ```
- **Desteklenen diğer araçlar:**
  - nmap Vulners
  - sslscan
  - nikto
  - joomscan
  - wpscan
  - droopescan
  - smbmap
  - enum4linux
  - dnsrecon
  - odat
  - smtp-user-enum
  - snmp-check
  - snmpwalk
  - ldapsearch

---

## **Kullanım**
### **Temel Kullanım:**
```bash
./nmapAutomator.sh -H/--host <HEDEF-IP> -t/--type <TARAMA-TİPİ>
```

### **Opsiyonel Parametreler:**
- `-r/--remote`: Uzak modda çalıştırır.
- `-d/--dns <DNS-Sunucusu>`: Özel bir DNS sunucusu tanımlar.
- `-o/--output <Çıktı-Dizini>`: Çıktıları belirli bir dizine kaydeder.
- `-s/--static-nmap <STATİK-NMAP-YOLU>`: Statik bir nmap ikili dosyası kullanır.

### **Taramalar:**
| **Taramalar** | **Açıklama** | **Süre** |
| ------------- | ------------ | -------- |
| `Network`     | Canlı cihazları listeler. | ~15 saniye |
| `Port`        | Açık portları tarar. | ~15 saniye |
| `Script`      | Script taraması yapar. | ~5 dakika |
| `Full`        | Tam kapsamlı port taraması. | ~5-10 dakika |
| `UDP`         | UDP taraması yapar. | ~5 dakika |
| `Vulns`       | CVE ve zafiyet taraması yapar. | ~5-15 dakika |
| `Recon`       | Otomatik keşif önerileri sunar. | Değişken |
| `All`         | Tüm taramaları çalıştırır. | ~20-30 dakika |

---

### **Örnek Taramalar:**
```bash
# Tüm tarama türlerini çalıştırır.
./nmapAutomator.sh -H 10.1.1.1 -t All

# Sadece temel keşif yapar.
./nmapAutomator.sh -H 10.10.10.10 -t network

# Belirli bir DNS sunucusu üzerinden recon taraması yapar.
./nmapAutomator.sh -H academy.htb -t Recon -d 1.1.1.1
```

---

## **Çıktı Yönetimi**
- Her tarama türü ayrı dosyalara kaydedilir.
- Tüm tarama çıktısı topluca kaydedilir ve şu şekilde görüntülenebilir:
  ```bash
  less -r <ÇIKTI-DİZİNİ>/nmapAutomator_<HEDEF>_<TİP>.txt
  cat <ÇIKTI-DİZİNİ>/nmapAutomator_<HEDEF>_<TİP>.txt
  ```

---

## **Yakında Gelecek Özellikler**
- URL/DNS desteği.
- HTTP keşfi için eklenti fuzzing.
- Nmap ilerleme çubuğu.
- Eksik araçları listeleme.
- Çıktı klasörünü değiştirme seçeneği.
- Performans ve verimlilik geliştirmeleri.
- Çoklu tarama tipi ve çoklu hedef desteği.

---

**Not:** Bu araç sadece keşif için tasarlanmıştır; herhangi bir exploitation gerçekleştirmez. 😊
