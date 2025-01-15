# OSCP Linux Enumeration Rehberi

Bu rehber, OSCP sınavında karşılaşılabilecek Linux standalone makinelerde enumeration aşamasında izlenecek adımları detaylı olarak ele alır. Her adım için kullanılacak komutlar verilmiştir.

## 1. **Sistem Bilgileri Toplama**

### 1.1 Hostname ve Kullanıcı Bilgileri
```bash
hostname
whoami
id
who
w
```

### 1.2 Sistem Bilgileri
```bash
uname -a
cat /etc/os-release
cat /proc/version
```

### 1.3 Ağ Bilgileri
```bash
ifconfig
ip a
ip r
cat /etc/hosts
arp -a
netstat -tulnp
ss -tulnp
```

---

## 2. **Kullanıcı ve Grup Bilgileri**

### 2.1 Kullanıcılar
```bash
cat /etc/passwd
cat /etc/group
```

### 2.2 Şifre Dosyaları
```bash
cat /etc/shadow # Yetki varsa
```

### 2.3 Aktif Kullanıcılar
```bash
who
w
last
```

---

## 3. **Dosya ve Dizin Analizi**

### 3.1 Yetkiler
```bash
ls -la /
find / -perm -4000 2>/dev/null
find / -type d -perm -2000 2>/dev/null
find / -type f -perm -2000 2>/dev/null
```

### 3.2 Konfigürasyon Dosyaları
```bash
find /etc -type f -name "*.conf" 2>/dev/null
```

### 3.3 Log Dosyaları
```bash
find /var/log -type f 2>/dev/null
cat /var/log/syslog
cat /var/log/auth.log
```

---

## 4. **Servis ve Proses Analizi**

### 4.1 Çalışan Prosesler
```bash
ps aux
ps -ef
```

### 4.2 Servisler
```bash
systemctl list-units --type=service
service --status-all
```

### 4.3 Crontab
```bash
crontab -l
ls -la /etc/cron*
cat /etc/cron.d/*
cat /var/spool/cron/crontabs/*
```

---

## 5. **Ağ ve Servis Bilgileri**

### 5.1 Açık Portlar
```bash
netstat -tulnp
ss -tulnp
lsof -i
```

### 5.2 SSH ve Diğer Servisler
```bash
cat /etc/ssh/sshd_config
cat /etc/xinetd.conf
```

---

## 6. **Ekstra Bilgiler**

### 6.1 Kernel Exploitleri Kontrolü
```bash
uname -r
searchsploit $(uname -r)
```

### 6.2 Güvenlik Mekanizmaları
```bash
dmesg | grep -i 'segmentation fault'
cat /proc/sys/kernel/randomize_va_space
```

---

## 7. **Ek Araçlarla Enumeration**

### 7.1 LinPEAS
```bash
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
chmod +x linpeas.sh
./linpeas.sh
```

### 7.2 LinEnum
```bash
wget https://github.com/rebootuser/LinEnum/raw/master/LinEnum.sh
chmod +x LinEnum.sh
./LinEnum.sh
```

### 7.3 pspy
```bash
wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64
chmod +x pspy64
./pspy64
```

---

Bu rehberde verilen komutlar ve yöntemler, enumeration aşamasında kapsamlı bir veri toplama süreci sağlayacaktır. Gerektiğinde otomatik araçlar kullanarak daha fazla bilgi edinilebilir.
