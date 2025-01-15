### Linux Yetki Yükseltme  
#### Tanımlama  
##### LinEnum Nedir?

LinEnum, yetki yükseltmeyle ilgili yaygın komutları çalıştıran basit bir bash scriptidir. Zaman kazandırır ve kök (root) yetkisi elde etmeye yönelik daha fazla çaba harcamanıza olanak tanır. LinEnum’un hangi komutları çalıştırdığını anlamak önemlidir. Çünkü LinEnum veya benzer scriptleri kullanamadığınız bir durumda, yetki yükseltme açıklarını manuel olarak keşfetme yeteneğine sahip olmanız gerekecek. Bu rehberde, LinEnum’un ne gösterdiği ve aynı işlemleri elle nasıl yapabileceğiniz açıklanacaktır.

---

### LinEnum’u Nereden Alabilirim?

LinEnum’un yerel bir kopyasını şu adresten indirebilirsiniz:  
**GitHub:**  
[LinEnum - RebootUser](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh)

```bash
wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
```

Bu scripti hatırlayacağınız bir yerde saklamaya değer, çünkü LinEnum paha biçilmez bir araçtır.

---

### LinEnum Hedef Makineye Nasıl Taşınır?

LinEnum’u hedef makineye taşımak için iki yöntem vardır:

1. **Python Web Sunucusu Kullanımı:**  
   LinEnum kopyasını sakladığınız dizine gidin ve aşağıdaki komutla bir Python web sunucusu başlatın:  
   ```bash
   python3 -m http.server 8000
   ```
   Daha sonra hedef makineden `wget` komutuyla ve yerel IP adresinizle dosyayı alabilirsiniz:  
   ```bash
   wget http://<yerel_ip_adresi>:8000/LinEnum.sh
   ```
   Ardından dosyayı çalıştırılabilir yapmak için şu komutu kullanın:  
   ```bash
   chmod +x FILENAME.sh
   ```

2. **Manuel Yöntem:**  
   Eğer dosyayı taşıyamıyorsanız, yetkiniz varsa LinEnum’un ham kodlarını yerel makineden kopyalayabilirsiniz. Ardından hedef makinede Vi veya Nano gibi bir editör kullanarak yeni bir dosyaya yapıştırabilirsiniz.  
   - Dosyayı `.sh` uzantısıyla kaydedin.  
   - Dosyayı çalıştırılabilir yapmak için şu komutu kullanın:  
     ```bash
     chmod +x FILENAME.sh
     ```

Bu şekilde, hedef makinede kendi çalıştırılabilir LinEnum kopyanızı oluşturmuş olursunuz.

---

### LinEnum Nasıl Çalıştırılır?

LinEnum, herhangi bir bash scripti gibi çalıştırılır. Scriptin bulunduğu dizine gidin ve şu komutu çalıştırın:  
```bash
./LinEnum.sh
```

---

### LinEnum Çıktısını Anlama

LinEnum çıktısı, aşağıdaki ana bölümlere ayrılmıştır:

1. **Kernel:**  
   Kernel bilgileri burada gösterilir. Bu makine için büyük olasılıkla bir kernel açığı mevcuttur.

2. **Hassas Dosyalara Okuma/Yazma İzinleri:**  
   Dünya yazılabilir dosyalar bu bölümde gösterilir. Bu dosyaların izinlerine bakarak, kullanıcıların yazmaması gereken hassas dosyalara yazma izni veren yanlış yapılandırmaları görebilirsiniz.

3. **SUID Dosyaları:**  
   SUID dosyalarının çıktısı bu bölümde gösterilir. Bu dosyalar, yetki yükseltmek için kesinlikle incelenmesi gereken ilginç dosyalardır.  
   **SUID (Set owner User ID up on execution):** Bir dosya sahibinin izinleriyle çalıştırılmasına izin veren özel bir dosya izni türüdür. Eğer dosyanın sahibi root ise, bu dosya root yetkileriyle çalışır. Bu, yetki yükseltmek için kullanılabilir.

4. **Crontab İçeriği:**  
   **Cron**, belirli bir zamanda komutların çalıştırılması için kullanılır. Bu planlanan komutlar veya görevler, "cron job" olarak bilinir. Bununla ilişkili olarak, `crontab` komutu, cron demonu tarafından çalıştırılacak komutları ve talimatları içeren bir crontab dosyası oluşturur. Bu bilgileri analiz ederek cronjob’ları istismar etmeye çalışabilirsiniz.

---

### SUID/SGID Dosyalarını İstismar Etme

#### SUID Dosyalarını Bulma ve İstismar Etme

Linux yetki yükseltmede ilk adım, SUID/SGID bit ayarlanmış dosyaları kontrol etmektir. Bu, dosya veya dosyaların sahibi/grubunun yetkileriyle çalıştırılabileceği anlamına gelir. Eğer bu dosyaların sahibi super-user (root) ise, bunları kullanarak root yetkili bir shell alabiliriz!

---

### İzinler ve Anlamları  

| **İzin Türü**        | **Dosyalar**                                   | **Dizinler**                             |
|-----------------------|-----------------------------------------------|------------------------------------------|
| **SUID Biti**         | Kullanıcı, dosyayı dosya sahibinin izinleriyle çalıştırır. | -                                        |
| **SGID Biti**         | Kullanıcı, dosyayı grup sahibinin izinleriyle çalıştırır. | Dizinde oluşturulan dosya aynı grup sahibine ait olur. |
| **Sticky Biti**       | Bir anlamı yoktur.                            | Kullanıcıların başkalarının dosyalarını silmeleri engellenir. |

---

### SUID Binary Nedir?

Linux’ta her şey bir dosyadır. Buna dizinler ve cihazlar da dahildir. Bu dosyalar üzerinde okuma/yazma/çalıştırma izinleri ayarlanabilir. Bir dosyaya izin verirken, izinlerin hangi kullanıcılar için geçerli olduğunu bilmeniz önemlidir.  

SUID bit ayarlanmış bir komut veya script çalıştırıldığında, çalıştıran kullanıcının kimliği yerine dosya sahibinin kimliği kullanılır. SGID izni ise benzerdir, ancak fark şudur: SGID ayarlı bir script çalıştırıldığında, dosyanın üye olduğu grubun üyesiymiş gibi çalıştırılır.

**Örnek İzinler:**
- **SUID:** `-rws-rwx-rwx`  
- **GUID:** `-rwx-rws-rwx`  
- **Her İkisi:** `-rwsr-sr-x`

Her izin, aşağıdaki şekilde ifade edilir:

| **Kullanıcı** | **Grup** | **Diğerleri** |
|---------------|----------|---------------|
| **rwx**       | **rwx**  | **rwx**       |
| **421**       | **421**  | **421**       |

Maksimum izinler: `777`  
Eğer `chmod 755` kullanırsanız: `-rwxr-xr-x`  
Ancak özel izinler (SUID/SGID) verildiğinde, izinler şu şekilde değişir:  
- **SUID:** `s` kullanıcının çalıştırma bitini değiştirir.
- **SGID:** `s` grup çalıştırma bitini değiştirir. 

---
#### SUID Binary’leri Bulma  

LinEnum taramasından sistemde SUID özelliğine sahip dosyalar olduğunu zaten biliyoruz. Ancak bunu manuel olarak yapmak istersek, aşağıdaki komutla SUID/SGID dosyalarını arayabiliriz:

```bash
find / -perm -u=s -type f 2>/dev/null
```

Bu komutu parçalayarak inceleyelim:  

- **find:** "find" komutunu başlatır.  
- **/**: Tüm dosya sistemini tarar.  
- **-perm:** Belirli izinlere sahip dosyaları arar.  
- **-u=s:** Belirtilen izin bitlerinin dosyada ayarlandığını kontrol eder (sembolik modlar bu formatta kabul edilir).  
- **-type f:** Yalnızca dosyaları arar.  
- **2>/dev/null:** Hataları bastırır.  

---

### Yazılabilir /etc/passwd Dosyasını İstismar Etme  

Kullanıcıları incelemeye devam ederken, **user7**'nin `gid 0` ile root grubunun bir üyesi olduğunu gördük. Ayrıca LinEnum taramasından, **/etc/passwd** dosyasının yazılabilir olduğunu biliyoruz. Bu gözlemden yola çıkarak, user7’nin /etc/passwd dosyasını düzenleyebileceğini anladık.

#### /etc/passwd Dosyası  

`/etc/passwd` dosyası, sistemde oturum açarken gerekli olan temel bilgileri saklar. Başka bir deyişle, kullanıcı hesap bilgilerini tutar. Bu dosya düz metin formatında bir dosyadır. Sistem hesaplarının bir listesini içerir ve her hesap için kullanıcı kimliği, grup kimliği, ev dizini, shell gibi yararlı bilgiler sağlar.

`/etc/passwd` dosyası genellikle okunabilir olmalıdır, çünkü birçok komut bu dosyayı kullanıcı kimliklerini kullanıcı adlarıyla eşlemek için kullanır. Ancak, **yazma izni yalnızca root/süper kullanıcı** ile sınırlı olmalıdır. Eğer bu izinler yanlışlıkla bir kullanıcıya verilirse, bir açık oluşur ve bu açık, root yetkileriyle giriş yapabileceğimiz bir root kullanıcı oluşturmamıza olanak sağlar.

---

#### /etc/passwd Formatı  

`/etc/passwd` dosyası, her kullanıcı (kullanıcı hesabı) için satır başına bir giriş içerir. Tüm alanlar `:` (iki nokta üst üste) ile ayrılmıştır. Toplam yedi alan vardır. Genel formatı şu şekildedir:  

```
test:x:0:0:root:/root:/bin/bash
```

Bu formatın alanları:  

1. **Kullanıcı Adı:** Kullanıcının oturum açarken kullandığı ad. 1 ile 32 karakter uzunluğunda olabilir.  
2. **Parola:** `x` karakteri, şifrelenmiş parolanın `/etc/shadow` dosyasında saklandığını gösterir. Parola karmasını (hash) oluşturmak veya güncellemek için `passwd` komutunu kullanabilirsiniz.  
3. **Kullanıcı ID (UID):** Her kullanıcıya atanmış benzersiz bir kimliktir.  
   - UID 0: root için ayrılmıştır.  
   - UID 1-99: Önceden tanımlanmış hesaplar için ayrılmıştır.  
   - UID 100-999: Sistem ve yönetici hesapları/grupları için ayrılmıştır.  
4. **Grup ID (GID):** Birincil grup kimliği (grup dosyasında saklanır).  
5. **Kullanıcı Bilgisi:** Kullanıcı adı, telefon numarası gibi ek bilgilerin eklendiği yorum alanı. `finger` komutu tarafından kullanılır.  
6. **Ev Dizini:** Kullanıcının oturum açtığında bulunacağı dizinin mutlak yolu. Bu dizin yoksa, kullanıcı dizini `/` olur.  
7. **Komut/Shell:** Komutun veya shell’in mutlak yolu. Bu genellikle bir shell’dir (`/bin/bash`).  

---

#### Yazılabilir /etc/passwd Dosyasını İstismar Etmek  

Eğer /etc/passwd dosyasını yazılabilir hale getirebilirsek, yukarıdaki formata uygun yeni bir satır ekleyerek yeni bir kullanıcı oluşturabiliriz! Parola hash’ini seçtiğimiz bir değerle oluşturup, UID, GID ve shell’i root olacak şekilde ayarlayabiliriz. Böylece, kendi oluşturduğumuz root kullanıcısıyla giriş yapabiliriz.

---

### Vi Editöründen Kaçış  
#### sudo -l  

Bu açık, kullanıcı hesabı taramasının ne kadar etkili yapıldığına bağlıdır. Bir CTF senaryosunda bir hesaba erişim sağladığınızda, her zaman şu komutla kullanıcının süper kullanıcı olarak çalıştırabileceği komutları listelemelisiniz:  
```bash
sudo -l
```

Bazen bu, root parolası olmadan belirli komutları root olarak çalıştırmanıza olanak tanır. Bu, yetki yükseltmek için bir fırsat sağlayabilir.

---

#### Vi Editöründen Kaçış  

`user8` hesabında yukarıdaki komut çalıştırıldığında, bu kullanıcının `vi` komutunu root yetkileriyle çalıştırabileceği görülür. Bu, **vim’den kaçarak root yetkileriyle bir shell açmamıza** olanak tanır.

---

### Yanlış Yapılandırılmış Binary’ler ve GTFOBins  

Eğer bir binary’nin yanlış yapılandırılmış olduğunu keşfederseniz, bu binary’yi nasıl istismar edeceğinizi öğrenmek için başvurabileceğiniz en iyi yer **GTFOBins**’dir.  
GTFOBins, bir saldırganın yerel güvenlik kısıtlamalarını atlamak için istismar edebileceği Unix binary’lerinin düzenlenmiş bir listesidir. Bir binary’yi nasıl istismar edeceğinizi adım adım açıklayan harika bir kaynaktır ve bir CTF veya pentest sırasında bulduğunuz her yanlış yapılandırılmış binary için ilk bakmanız gereken yer burasıdır.

GTFOBins adresi:  
[GTFOBins](https://gtfobins.github.io/)

---
### Cron'u İstismar Etme  
#### Cron Nedir?

**Cron daemon**, belirli tarih ve saatlerde komutları çalıştıran uzun süre çalışan bir süreçtir. Bunu, bir kerelik olaylar veya yinelenen görevler olarak etkinlikler planlamak için kullanabilirsiniz. **Crontab dosyası**, Cron daemon’un çalıştırması gereken komutları ve talimatları içerir.

---

#### Aktif Cronjob’lar Nasıl Görüntülenir?

Hangi cron job’ların planlandığını görmek için şu komut kullanılabilir:  
```bash
cat /etc/crontab
```

Bu, LinEnum veya benzeri bir script hiçbir şey bulamadığında bile her zaman manuel olarak kontrol etmeniz gereken bir şeydir.

---

#### Bir Cronjob’un Formatı  

Cronjob’lar belirli bir formatta bulunur. Bu formatı okuyabilmek, bir cron job’u istismar etmek istiyorsanız önemlidir.

| **#**   | **Anlamı**                                      |
|---------|-------------------------------------------------|
| **m**   | Dakika (0-59)                                   |
| **h**   | Saat (0-23)                                     |
| **dom** | Ayın günü (1-31)                                |
| **mon** | Ay (1-12)                                       |
| **dow** | Haftanın günü (0-7, 0 ve 7 pazar günü demektir) |
| **user**| Komutun hangi kullanıcı ile çalıştırılacağı      |
| **command** | Çalıştırılacak komut                         |

Örneğin:  
```bash
#  m   h dom mon dow user  command
17 *   1  *   *   *  root  cd / && run-parts --report /etc/cron.hourly
```

---

#### Bu Nasıl İstismar Edilir?  

Diyelim ki LinEnum taramasından, **user4**’ün **Masaüstü** dizinindeki `autoscript.sh` dosyasının her beş dakikada bir çalıştırıldığını öğrendik. Dosyanın sahibi root olduğundan, bu dosya root yetkileriyle çalıştırılacaktır. Ancak dosyayı yazma iznimiz varsa, bu dosyaya bir shell döndüren komut ekleyebiliriz. Dosya tekrar çalıştırıldığında, shell root yetkileriyle çalışır.

---

### PATH Değişkenini İstismar Etme  
#### PATH Nedir?

**PATH**, Linux ve Unix benzeri işletim sistemlerinde, çalıştırılabilir programların bulunduğu dizinleri belirten bir çevresel değişkendir. Kullanıcı terminalde bir komut çalıştırdığında, PATH değişkeni yardımıyla çalıştırılabilir dosyalar aranır.

Bir kullanıcının PATH’ini görmek oldukça basittir:  
```bash
echo $PATH
```

---

#### Bu Nasıl Yetki Yükseltmeye Olanak Sağlar?  

Bir **SUID binary** olduğunu varsayalım. Bu binary’yi çalıştırdığımızda, sistem shell’ini çağırarak basit bir işlem yaptığını görebiliriz (örneğin `ps` komutuyla süreç listesini görüntülemek). Önceki SUID örneğimizde olduğu gibi, bu durumda komut enjeksiyonu için bir argüman sağlayamıyorsak, bunu nasıl istismar edebiliriz?

**PATH değişkenini yeniden yazabiliriz!**  

Bu sayede, SUID binary’si sistem shell’ini çağırdığında, bizim yazdığımız bir executable çalıştırılır. Tıpkı diğer SUID dosyalarında olduğu gibi, bu komut da SUID dosyasının sahibinin yetkileriyle çalışacaktır. Eğer bu dosyanın sahibi root ise, bu yöntemle istediğimiz komutları root olarak çalıştırabiliriz.

---

### Gruplar  
Kullanıcı kimliğinizi ve üyesi olduğunuz grupları görmek için şu komutu kullanabilirsiniz:  
```bash
id
```

Kullanıcılar, root işlemleri çalıştırabilen grupların (örneğin **lxd**) üyeleri olabilir. Bu gruplar da yetki yükseltme için kullanılabilir.

---
