# Windapsearch Kullanım Kılavuzu

## Windapsearch Nedir?

Windapsearch, bir Windows domaini üzerindeki kullanıcıları, grupları ve bilgisayarları LDAP sorguları ile enumerasyon yapmak için kullanılan bir Python scriptidir. Bu aracın temel amacı, pentesterların sıkça kullanacağı LDAP sorgularını kolaylaştırmaktır.

### Temel Gereksinimler

Windapsearch, Python ortamında çalışır ve `python-ldap` modülünü gerektirir. Aşağıdaki adımlarla kurulumu gerçekleştirebilirsiniz:

```bash
$ git clone https://github.com/ropnop/windapsearch.git
$ pip install python-ldap
$ ./windapsearch.py
```

> **Not:** Son sürüm Python 3 ile çalışır. Python 2 kullanımı gerekiyorsa `windapsearch_py2.py` dosyasını kullanabilirsiniz.

---

## Kullanım

Komutun yardım ekranını açmak için:

```bash
$ python windapsearch.py -h
```

Komutla ilgili tüm seçenekler detaylandırılmıştır:

### Anahtar Seçenekler

#### 1. Domain Ayarları:

- **`-d` veya `--domain`**: Domain'in FQDN ismini belirtir (e.g., `lab.example.com`).
- **`--dc-ip`**: Domain Controller'ın IP adresini belirtir. Eğer belirtilmezse DNS üzerinden otomatik bulunmaya çalışılır.

#### 2. Bağlantı Ayarları:

- **`-u` veya `--user`**: LDAP bağlantısı için kullanılacak tam kullanıcı adı (e.g., `user@domain.com` veya `DOMAIN\user`).
- **`-p` veya `--password`**: Kullanıcının şifresi. Belirtilmezse komut şifreyi girmeyi ister.

#### 3. Enumerasyon Seçenekleri:

- **`-U` veya `--users`**: Tüm kullanıcıları listeler.
- **`-G` veya `--groups`**: Tüm grupları listeler.
- **`-C` veya `--computers`**: Tüm domain bilgisayarlarını listeler.
- **`--da`**: Domain Admins grubu üyelerini listeler.
- **`--user-spns`**: Kerberoasting için uygun Service Principal Name'leri olan kullanıcıları listeler.
- **`--unconstrained-users`**: Unconstrained delegation'a sahip kullanıcıları listeler.
- **`--unconstrained-computers`**: Unconstrained delegation'a sahip bilgisayarları listeler.
- **`-m <GROUP_NAME>`**: Belirtilen grubun üyelerini listeler.
- **`--gpos`**: Group Policy Objects (GPO'ları) listeler.

#### 4. Çıktı Ayarları:

- **`-r` veya `--resolve`**: Bilgisayar isimlerini DNS üzerinden IP adresine çözer.
- **`--attrs`**: Özel nitelikleri belirtmek için kullanılır (e.g., `badPwdCount,lastLogon`).
- **`--full`**: LDAP sorgularından gelen tüm nitelikleri döker.
- **`-o <output_dir>`**: Sonuçları belirli bir dizine TSV dosyası olarak kaydeder.

---

## Kullanım Senaryoları

### 1. Kullanıcı Listesi Enumerasyonu:

Tüm kullanıcıları listelemek için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -U
```

Ek olarak tüm nitelikleri görmek isterseniz:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -U --full
```

### 2. Grup Üyelerini Listeme:

Belirli bir grubun üyelerini görmek için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -m "Domain Admins"
```

### 3. Domain Admins Enumerasyonu:

Recursive olarak Domain Admins grubunu taramak için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password --da
```

### 4. Bilgisayar Listesi Enumerasyonu:

Domain üzerindeki bilgisayarları listelemek için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -C
```

Bilgisayar isimlerini IP adreslerine çevirmek için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -C -r
```

### 5. Fuzzy Search ile Arama:

Belirli bir kullanıcı veya grup aramak için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -s "admin"
```

Detaylı lookup yapmak için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -l "admin" --attrs "mail,telephoneNumber"
```

---

## Çıktı Formatları

Windapsearch, sonuçları hem ekranda gösterir hem de TSV formatında kaydedebilir. Dosya kaydetmek için:

```bash
$ ./windapsearch.py -d lab.example.com -u user@lab.example.com -p password -U -o ./results/
```

Sonuçlar `./results/` dizinine TSV dosyası olarak kaydedilecektir.

---

## Dikkat Edilmesi Gerekenler

1. **Anonymous Bind:** Anonim bağlantı bazı sorgular için yeterli olabilir ancak çoğu işlem için kimlik doğrulama gerekebilir.
2. **Büyük Domainler:** Kullanıcı ve bilgisayar sayısı çok fazla olan domainlerde çıktılar büyük boyutlu olabilir.
3. **Firewall ve Network Ayarları:** LDAP trafiği genellikle 389/tcp portunda çalışır. Ancak, özel network ayarları veya firewall engelleri nedeniyle sorun yaşanabilir.

---

Windapsearch, Active Directory pentestleri için hızlı ve kolay bir çözüm sunar. LDAP sorgularını otomatikleştirerek zamandan tasarruf eder ve detaylı bilgiler sunar.

