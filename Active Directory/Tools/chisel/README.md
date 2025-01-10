# Chisel Kullanım Rehberi

Chisel, hızlı TCP/UDP tünelleme oluşturmak ve ağ segmentlerini aşmak için kullanılan bir araçtır. Bu rehber, Chisel'in temel kurulumundan gelişmiş kullanım senaryolarına kadar kapsamlı bir kılavuz sağlar.

---

## İçindekiler

1. [Chisel Nedir?](#chisel-nedir)
2. [Chisel'in Özellikleri](#chiselin-özellikleri)
3. [Chisel Nasıl Kurulur?](#chisel-nasil-kurulur)
4. [Temel Kullanım](#temel-kullanim)
    - [Sunucu Modu](#sunucu-modu)
    - [İstemci Modu](#istemci-modu)
5. [İleri Düzey Kullanım](#ileri-duzey-kullanim)
    - [Dinamik Port Yönlendirme](#dinamik-port-yonlendirme)
    - [Sabit Port Yönlendirme](#sabit-port-yonlendirme)
    - [Ters Tünelleme](#ters-tunelleme)
6. [SSL/TLS Desteği](#ssltls-destegi)
7. [Hata Ayıklama ve Sorun Giderme](#hata-ayiklama-ve-sorun-giderme)
8. [Güvenlik Notları](#guvenlik-notlari)

---

## Chisel Nedir?

Chisel, hızlı ve güvenilir bir şekilde TCP/UDP tünelleri oluşturmak için kullanılan bir "port forwarding" aracıdır. Ağ segmentleri arasında erişim sağlamak için yaygın olarak kullanılmaktadır. Özellikle pentest ve güvenlik araştırmaları için idealdir.

---

## Chisel'in Özellikleri

- **Dinamik ve statik port yönlendirme**
- **Şifrelenmiş bağlantılar**
- **Hafif ve taşınabilir** (tek bir ikili dosya)
- **Açık kaynak**
- **Çapraz platform desteği** (Linux, macOS, Windows)

---

## Chisel Nasıl Kurulur?

### Linux/MacOS
```bash
wget https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_linux_amd64.gz
gzip -d chisel_1.10.1_linux_amd64.gz
chmod +x chisel_1.10.1_linux_amd64
sudo mv chisel_1.10.1_linux_amd64 /usr/local/bin/chisel
```

### Windows
1. [Chisel GitHub Releases](https://github.com/jpillora/chisel/releases) sayfasından uygun sürümü indirin.
2. İndirilen dosyayı bir klasöre çıkarın.
3. `chisel.exe` dosyasını çalıştırarak kullanabilirsiniz.

### Docker Kullanarak
```bash
docker pull jpillora/chisel
```

---

## Temel Kullanım

### Sunucu Modu
Sunucu modu, istemcilerle bağlantı kurmayı ve port yönlendirmeyi mümkün kılar.
```bash
chisel server --port 8000 --reverse
```
- `--port`: Sunucunun hangi portta çalışacağını belirtir.
- `--reverse`: Ters tünelleme için kullanılır.

### İstemci Modu
İstemci, sunucuya bağlanır ve yönlendirme kurar.
```bash
chisel client <server-ip>:<port> R:8080:localhost:80
```
- `R:8080:localhost:80`: Sunucunun 8080 portunu istemcideki localhost:80 portuna yönlendirir.

---

## İleri Düzey Kullanım

### Dinamik Port Yönlendirme
Dinamik port yönlendirme, proxy yapılandırmaları için kullanılır.

Sunucu:
```bash
chisel server --port 8000
```

İstemci:
```bash
chisel client <server-ip>:8000 socks
```
Bu yöntemle SOCKS5 proxy oluşturulur. Proxychains gibi araçlarla kullanılabilir.

### Sabit Port Yönlendirme
Sabit port yönlendirme, belirli bir portun yönlendirilmesi için kullanılır.

Sunucu:
```bash
chisel server --port 8000
```

İstemci:
```bash
chisel client <server-ip>:8000 8080:localhost:80
```
Bu komut, istemcinin 8080 portundaki trafiği sunucunun localhost:80 portuna iletir.

### Ters Tünelleme
Ters tünelleme, güvenlik duvarlarını aşmak için kullanılır.

Sunucu:
```bash
chisel server --port 8000 --reverse
```

İstemci:
```bash
chisel client <server-ip>:8000 R:8000:localhost:22
```
Bu komut, sunucunun 8000 portunu istemcideki SSH hizmetine yönlendirir.

---

## SSL/TLS Desteği

Chisel, varsayılan olarak şifrelenmiş bağlantılar sağlar. Ancak kendi sertifikalarınızı kullanabilirsiniz.

Sunucu:
```bash
chisel server --port 8000 --key server.key --cert server.crt
```

İstemci:
```bash
chisel client --fingerprint <server-fingerprint> <server-ip>:8000 socks
```

---

## Hata Ayıklama ve Sorun Giderme

1. **Bağlantı Sorunları**
   - Sunucunun ve istemcinin aynı portu kullandığından emin olun.
   - Güvenlik duvarı ayarlarını kontrol edin.

2. **Performans Sorunları**
   - Yüksek trafiği azaltmak için bağlantıları optimize edin.

3. **Loglama**
   - `--debug` seçeneği ile hata ayıklama loglarını görüntüleyebilirsiniz.
   ```bash
   chisel server --port 8000 --debug
   ```

---

## Güvenlik Notları

- Chisel ile oluşturulan tüneller, uygun şekilde yapılandırılmazsa güvenlik riski oluşturabilir.
- Şifreli bağlantılar kullanın.
- Erişim kontrolü uygulamak için güvenlik gruplarını ve güvenlik duvarlarını yapılandırın.

---

Chisel hakkında daha fazla bilgi için [resmi GitHub sayfasını](https://github.com/jpillora/chisel) ziyaret edebilirsiniz.

---

**Yazar:** Ahmet Ümit BAYRAM  
**Web:** [exploitart.ist](https://exploitart.ist)
