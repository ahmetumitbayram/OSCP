# BloodHound Kullanım Kılavuzu

## Giriş
BloodHound, Active Directory (AD) ortamlarındaki ilişkilendirmeleri ve saldırı yollarını görselleştirmek için kullanılan güçlü bir açık kaynaklı araçtır. Neo4j tabanlı bir veritabanını kullanır ve bir saldırganın AD ortamında hak yükseltme yollarını keşfetmesini sağlar. Bu kılavuz, BloodHound'un kurulumu, kullanımı ve ileri düzey özelliklerini ele alır.

---

## Kurulum

### 1. Gereksinimler
- **Desteklenen İşletim Sistemleri:** Linux, Windows, macOS
- **Bağımlılıklar:**
  - Neo4j (veritabanı)
  - BloodHound uygulaması
  - Collectors (SharpHound vb.)

### 2. Kurulum Adımları

#### Linux
```bash
sudo apt update
sudo apt install -y bloodhound neo4j
```

#### Windows
1. BloodHound'u [resmi GitHub sayfasından](https://github.com/BloodHoundAD/BloodHound) indir.
2. Neo4j veritabanını yükle.
3. Neo4j servisini başlat ve BloodHound uygulamasını çalıştır.

#### macOS
Homebrew kullanarak kurulum yapabilirsiniz:
```bash
brew install --cask bloodhound
```

### Neo4j Veritabanını Ayarlama
1. Neo4j servisini başlat:
   ```bash
   sudo neo4j start
   ```
2. Web arayüzüne erişin: [http://localhost:7474](http://localhost:7474)
3. Varsayılan kullanıcı adı ve şifre `neo4j`'dir. İlk girişte şifreyi değiştirmeniz istenir.

---

## Temel Kullanım

### 1. SharpHound ile Veri Toplama
SharpHound, BloodHound için veri toplayan bir araçtır. Hedef ortamda çalıştırarak verileri toplar ve `.zip` formatında bir dosya üretir.

#### SharpHound'u Çalıştırma
```bash
SharpHound.exe -c All
```
- `-c All`: Tüm veri toplama yöntemlerini kullanır.
- Alternatif komutlar:
  - `-c Group`: Grup ilişkilerini toplar.
  - `-c ObjectProps`: Nesne özelliklerini toplar.

### 2. Verileri BloodHound'a Aktarma
1. Toplanan `.zip` dosyasını BloodHound uygulamasına yükleyin.
2. Uygulamada **Upload Data** seçeneğini kullanarak dosyayı yükleyin.

### 3. Grafikleri İnceleme
BloodHound, ilişkileri ve saldırı yollarını grafiksel olarak gösterir. Önemli grafik tipleri:
- **Shortest Path to Domain Admins**: Domain Admin grubuna en kısa saldırı yolu.
- **Kerberoastable Users**: Kerberoasting saldırılarına açık kullanıcılar.
- **Owned Principals**: Zafiyetlerden yararlanarak ele geçirilen hesaplar.

---

## Gelişmiş Özellikler

### Sorgular
BloodHound, Cypher sorgu dili ile güçlü analizler yapmanızı sağlar. Örnek sorgular:

- **Tüm Domain Admin Kullanıcıları:**
  ```cypher
  MATCH (n:User)-[:MemberOf*1..]->(:Group {name:"Domain Admins"}) RETURN n
  ```

- **Zayıf Şifre Politikaları:**
  ```cypher
  MATCH (n:User {dontreqpreauth:true}) RETURN n
  ```

### Özelleştirilmiş Veritabanı
Kendi Cypher sorgularınızı yazarak özel analizler yapabilirsiniz.

---

## İpuçları

### Performans Optimizasyonu
- **Veri Toplama Sınırlandırması:**
  Büyük bir ortamda performansı artırmak için veri toplama kapsamını daraltabilirsiniz:
  ```bash
  SharpHound.exe -c Group -d hedef.com
  ```

- **Neo4j Veritabanını Optimize Etme:**
  Veritabanını düzenli olarak yeniden indeksleyin:
  ```bash
  :schema await
  ```

### Export ve Yedekleme
- BloodHound veritabanını yedeklemek için Neo4j veri dizinini kopyalayın:
  ```bash
  cp -r /var/lib/neo4j /yedekleme/yolu
  ```

---

## Örnek Senaryolar

### Domain Admin Bulma
1. SharpHound ile veri toplayın.
2. BloodHound uygulamasına verileri yükleyin.
3. **Shortest Path to Domain Admins** grafiğini inceleyin.

### Kerberoasting Saldırısı
1. Cypher sorgusu ile Kerberoastable kullanıcıları bulun:
   ```cypher
   MATCH (u:User {hasspn:true}) RETURN u
   ```
2. Hedef kullanıcıların SPN bilgilerini kullanarak saldırıyı gerçekleştirin.

---

## Sorun Giderme

### BloodHound Uygulaması Çalışmıyor
1. Neo4j servisini kontrol edin:
   ```bash
   sudo neo4j status
   ```
2. BloodHound uygulamasını yeniden başlatın.

### "No Data Returned from Query" Hatası
- Veri setinizin eksik olmadığından emin olun.
- Veri toplama işlemini tekrar gerçekleştirin.

### SharpHound Hataları
- **Erişim reddedildi:** Kullanıcı hesabınızın yeterli izinlere sahip olduğundan emin olun.
- **Timeout:** Büyük ortamlar için `--Throttle` parametresini kullanarak sorgu hızını azaltın:
  ```bash
  SharpHound.exe -c All --Throttle 2000
  ```

---

## Ek Kaynaklar
- [BloodHound Resmi GitHub](https://github.com/BloodHoundAD/BloodHound)
- [SharpHound Kullanım Belgeleri](https://bloodhound.readthedocs.io/)
- [Neo4j Cypher Sorgu Dili](https://neo4j.com/developer/cypher/)

---

## Katkıda Bulunanlar
Bu kılavuz, BloodHound kullanımını detaylı bir şekilde ele almak için hazırlanmıştır. Sorularınız veya önerileriniz için lütfen iletişime geçin!
