# SharpHound.exe Kullanım Kılavuzu

## Giriş
SharpHound, Active Directory ortamında bilgi toplamak ve BloodHound aracına veri sağlamak için kullanılan bir veri toplama aracıdır. BloodHound, bu verileri grafiksel olarak analiz etmek için kullanılır.

---

## Özellikler
- **Active Directory Keşfi**: Kullanıcılar, gruplar, bilgisayarlar ve oturumlar hakkında bilgi toplar.
- **CSV ve JSON Formatında Çıktı**: Toplanan veriler analiz için bu formatlarda kaydedilir.
- **Tüm Etki Alanına Erişim**: Domain Controller ve önemli AD varlıkları hakkında kapsamılı bilgi sağlar.

---

## Gereksinimler
- Windows veya Linux işletim sistemi
- BloodHound'un kurulu olduğu bir analiz ortamı

---

## Komut Satırı Kullanımı

### Yardım Mesajını Görüntüleme
SharpHound'un kullanılabilir tüm komutlarını görmek için:
```cmd
SharpHound.exe -h
```

### Veri Toplama
Varsayılan veri toplama modunu çalıştırmak için:
```cmd
SharpHound.exe -c All
```
Bu komut, Active Directory ortamında tüm kullanıcılar, oturumlar, gruplar ve bilgisayarları tarar.

### İleri Seviye Veri Toplama
Belirli bir toplama modunu çalıştırmak için:
```cmd
SharpHound.exe -c SessionLoop
```
Bu mod, oturum verilerini çevrimsel olarak toplar.

### Belirli Bir Domain Controller'dan Veri Toplama
Hedef bir Domain Controller belirlemek için:
```cmd
SharpHound.exe -c All --DomainController DC1.domain.local
```

### Sonuçları Belirli Bir Dizin Altında Kaydetme
Toplanan verileri belirli bir dizine kaydetmek için:
```cmd
SharpHound.exe -c All --OutputDirectory C:\BloodHound\Data
```

---

## Örnek Kullanımlar

### LDAP Protokolü Üzerinden Veri Toplama
LDAP protokolüyle Active Directory'den veri toplamak için:
```cmd
SharpHound.exe -c All --LdapOnly
```

### Zamanlayıcı ile Veri Toplama
Belirli aralıklarla veri toplamak için:
```cmd
SharpHound.exe -c All --Loop --LoopDuration 02:00:00
```
Bu komut, her iki saatte bir veri toplar.

---

## Çıktı Formatları
SharpHound, topladığı verileri aşağıdaki formatlarda kaydeder:
- **JSON**: BloodHound ile doğrudan analiz yapmak için uygundur.
- **ZIP**: Tüm çıktıları bir araya getirir.

---

## Derleme Talimatları
SharpHound kaynak koddan derlenebilir.

### Adımlar:
1. Visual Studio Community Edition'ı yükleyin.
2. Projeyi açın (`SharpHound.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Kaynaklar
- [SharpHound GitHub](https://github.com/BloodHoundAD/SharpHound)
- [BloodHound Resmi Belgeleri](https://bloodhound.readthedocs.io/)

Bu rehber, SharpHound aracını kullanmanın temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki bağlantılara göz atabilirsiniz.
