# Ligolo-ng Kullanım Rehberi

## Giriş
Ligolo-ng, saldırganların bir iç ağda proxy tünelleme yaparak trafik yönlendirmesi gerçekleştirmesine olanak tanıyan modern bir tünelleme aracıdır. Hem hızlı hem de hafif olmasıyla öne çıkan bu araç, ağ sızma testlerinde sıklıkla kullanılmaktadır.

---

## Özellikler
- **Güvenli İletişim:** TLS kullanarak güvenli tüneller oluşturur.
- **Çoklu Platform Desteği:** Linux, Windows ve macOS gibi farklı platformlarda çalışabilir.
- **Yüksek Performans:** Düşük gecikme süresi ile veri aktarımı sağlar.
- **Basit Yapılandırma:** Minimum çabayla hızlı bir şekilde çalıştırılabilir.

---

## İndirme ve Kurulum

### Linux
1. [Ligolo-ng GitHub sayfasına](https://github.com/tnpitsecurity/ligolo-ng) gidin.
2. Son sürümün binary dosyasını indirin:
   ```bash
   wget https://github.com/tnpitsecurity/ligolo-ng/releases/download/<version>/ligolo-ng_proxy_linux_amd64
   wget https://github.com/tnpitsecurity/ligolo-ng/releases/download/<version>/ligolo-ng_agent_linux_amd64
   ```
3. Binary dosyalarına çalıştırma izni verin:
   ```bash
   chmod +x ligolo-ng_proxy_linux_amd64 ligolo-ng_agent_linux_amd64
   ```

### Windows
1. GitHub sayfasından Windows için uygun binary dosyasını indirin.
2. İndirilen dosyayı çalıştırmaya hazır hale getirin.

---

## Kullanım

### Temel Mimarisi
Ligolo-ng, **Proxy** ve **Agent** olmak üzere iki bileşenden oluşur:
- **Proxy:** Kontrol sunucusudur ve saldırgan makinesinde çalıştırılır.
- **Agent:** Hedef ağdaki sistemde çalıştırılır ve Proxy ile iletişim kurar.

### Proxy'yi Çalıştırma
1. Proxy'yi çalıştırmak için aşağıdaki komutu kullanın:
   ```bash
   ./ligolo-ng_proxy_linux_amd64 -bind 0.0.0.0:8888
   ```
   - `-bind`: Proxy'nin hangi IP ve port üzerinden dinleyeceğini belirtir.

### Agent'ı Çalıştırma
1. Agent'ı hedef makinede çalıştırın:
   ```bash
   ./ligolo-ng_agent_linux_amd64 -connect <proxy_ip>:8888
   ```
   - `<proxy_ip>`: Proxy'nin çalıştığı sunucunun IP adresi.

### Proxy Chains ile Kullanım
1. Proxychains ayar dosyasını düzenleyin:
   ```bash
   sudo nano /etc/proxychains.conf
   ```
2. Son satıra aşağıdaki satırı ekleyin:
   ```
   socks5 127.0.0.1 1080
   ```
3. Proxychains kullanarak tarama yapın:
   ```bash
   proxychains nmap -sT -Pn <hedef_ip>
   ```

---

## Gelişmiş Kullanım

### Sertifikalarla Güvenlik
Ligolo-ng varsayılan olarak kendi kendine imzalanan sertifikalar kullanır. Güvenliği artırmak için özel sertifikalar oluşturabilirsiniz:

1. OpenSSL ile bir CA oluşturun:
   ```bash
   openssl req -x509 -newkey rsa:4096 -keyout ca-key.pem -out ca-cert.pem -days 365 -nodes
   ```
2. Ligolo-ng için özel bir sertifika oluşturun:
   ```bash
   openssl req -new -key ca-key.pem -out server.csr
   openssl x509 -req -in server.csr -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -days 365
   ```
3. Sertifikaları Proxy ve Agent yapılandırmalarına ekleyin:
   ```bash
   ./ligolo-ng_proxy_linux_amd64 -bind 0.0.0.0:8888 -cert server-cert.pem -key ca-key.pem
   ./ligolo-ng_agent_linux_amd64 -connect <proxy_ip>:8888 -cert ca-cert.pem
   ```

---

## Sık Karşılaşılan Sorunlar

### 1. Agent Bağlanamıyor
- **Çözüm:** Firewall ve ağ yapılandırmasını kontrol edin. Proxy'nin dinlediği portun açık olduğundan emin olun.

### 2. Trafik Yönlendirilemiyor
- **Çözüm:** Proxychains ayarlarını tekrar gözden geçirin ve doğru SOCKS proxy'yi seçtiğinizden emin olun.

### 3. Performans Düşüklüğü
- **Çözüm:** Hedef sistemin ve saldırgan makinesinin ağ hızını kontrol edin. Daha düşük gecikme süreli bir ağ kullanın.

---

## Örnek Senaryo
1. Hedef sistemde Agent'ı çalıştırın:
   ```bash
   ./ligolo-ng_agent_linux_amd64 -connect 192.168.1.10:8888
   ```
2. Proxy'yi saldırgan makinesinde çalıştırın:
   ```bash
   ./ligolo-ng_proxy_linux_amd64 -bind 0.0.0.0:8888
   ```
3. Proxychains ile tarama yapın:
   ```bash
   proxychains nmap -sT -Pn 10.10.10.0/24
   ```

---

## Kaynaklar
- [Ligolo-ng Resmi GitHub Sayfası](https://github.com/tnpitsecurity/ligolo-ng)
- [Proxychains Ayarları](https://linux.die.net/man/1/proxychains)
- [OpenSSL Sertifika Kılavuzu](https://www.openssl.org/docs/man1.1.1/man1/openssl.html)
