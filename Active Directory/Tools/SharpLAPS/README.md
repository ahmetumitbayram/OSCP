# SharpLAPS Kullanım Kılavuzu

## Giriş
SharpLAPS, Active Directory'den LAPS (Local Administrator Password Solution) şifrelerini almak için tasarlanmış bir araçtır. Cobalt Strike gibi bir framework içerisinde `execute-assembly` komutuyla çalıştırılabilir. Araç, ms-MCS-AdmPwd özniteliğinde depolanan düz metin LAPS şifrelerini okur.

---

## Gereksinimler
SharpLAPS'i kullanmak için aşağıdaki yetkilerden birine sahip olmanız gereklidir:

- **ExtendedRight** ya da **Generic All Rights** erişimi olan bir hesap
- **Domain Admin** ayrıcalıkları

---

## Kullanım
Aşağıda SharpLAPS'in komut satırı seçenekleri açıklanmıştır:

### Gerekli Parametreler
- `/host:<1.1.1.1>`: Hedef LDAP sunucusu (genellikle Domain Controller IP'si)

### Opsiyonel Parametreler
- `/user:<username>`: Kullanıcı adı (Domain\User formatında yazılmalı)
- `/pass:<password>`: Kullanıcı parolası
- `/out:<file>`: Alınan kimlik bilgilerini bir dosyaya kaydetme
- `/ssl`: SSL (LDAPS) kullanımı

### Örnek Kullanım
SharpLAPS'in kullanımı basit ve etkilidir. Aşağıdaki örnekler, aracın kullanımına dair senaryoları göstermektedir:

#### Temel Kullanım
```bash
SharpLAPS.exe /user:DOMAIN\User /pass:MyP@ssw0rd123! /host:192.168.1.1
```
Bu komut, belirtilen kullanıcı adı ve parola ile hedef Domain Controller'a bağlanır ve LAPS şifresini alır.

#### SSL (LDAPS) Kullanımı
```bash
SharpLAPS.exe /user:DOMAIN\Admin /pass:AdminP@ss123 /host:dc.domain.com /ssl
```
Bu komut, LDAPS protokolü üzerinden güvenli bir bağlantı kurar.

#### Çıktıyı Dosyaya Kaydetme
```bash
SharpLAPS.exe /user:DOMAIN\User /pass:MyP@ssw0rd123! /host:192.168.1.1 /out:creds.txt
```
Bu komut, alınan LAPS şifresini `creds.txt` dosyasına kaydeder.

---

## Hata Ayıklama
Eğer SharpLAPS çalıştırılırken sorun yaşarsanız, aşağıdaki adımları kontrol edin:

1. **Doğru Yetkiler:** Kullanıcı hesabınızın gerekli yetkilere sahip olduğundan emin olun.
2. **Bağlantı Sorunları:** LDAP sunucusuna erişim için ağ bağlantınızı kontrol edin.
3. **SSL Ayarları:** SSL kullanıyorsanız, hedef sunucunun LDAPS desteği sunduğundan emin olun.
4. **Parametre Doğruluğu:** Komut satırı parametrelerinin doğru formatta yazıldığını kontrol edin.

---

## Lisans
SharpLAPS, MIT lisansı ile lisanslanmıştır. Kullanım ve dağıtım kuralları için lisans dosyasını inceleyebilirsiniz.

---

## İletişim
Bu araç hakkında daha fazla bilgi almak veya geri bildirimde bulunmak için GitHub sayfasını ziyaret edebilirsiniz: [SharpLAPS GitHub](https://github.com/swisskyrepo/SharpLAPS)
