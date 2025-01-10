# SCMUACBypass Kullanım Kılavuzu

## Giriş
SCMUACBypass, Kerberos kimlik doğrulaması aracılığıyla Service Control Manager'a (SCM) erişim sağlayan ve bir hizmet ikili yükü kullanarak yerel yetki yükseltme (LPE) gerçekleştiren bir araçtır. Bu araç, özellikle Kerberos röle saldırı vektörleriyle birlikte kullanılmak üzere tasarlanmıştır. Araç, saldırı sırasında gerekli olan biletlerin önceden önbellekte bulunmasını gerektirir.

---

## Gereksinimler
- Windows ortamında çalışacak şekilde yapılandırılmış bir sistem
- Kerberos kimlik bilgileri ve saldırıya uygun biletler
- Cobalt Strike veya benzeri bir framework

---

## Özellikler
- Kerberos kimlik doğrulaması kullanarak SCM'ye erişim
- Hizmet tabanlı yükler ile LPE gerçekleştirme
- Cobalt Strike ile entegrasyon için Aggressor Script desteği

---

## Kullanım

### Yardım Mesajını Görüntüleme
SCMUACBypass komutlarının ve argümanlarının tam listesini görmek için:
```cmd
SCMUACBypass.exe -h
```

### Temel Kullanım
SCMUACBypass, bir hizmet yükü ile LPE gerçekleştirmek için şu şekilde kullanılabilir:
```cmd
SCMUACBypass.exe <target> <payload>
```

| Parametre       | Açıklama                                                              |
|-----------------|----------------------------------------------------------------------|
| `<target>`      | Saldırının hedefi olan sistemin adı veya IP adresi                  |
| `<payload>`     | Çalıştırılacak hizmet ikili dosyasının yolu                          |

---

## Örnek Kullanımlar

### 1. Temel Saldırı
Bir hedef üzerinde Kerberos kimlik bilgilerini kullanarak LPE gerçekleştirme:
```cmd
SCMUACBypass.exe 192.168.1.10 C:\Temp\malicious_service.exe
```

### 2. Cobalt Strike ile Kullanım
SCMUACBypass, Cobalt Strike içinde aşağıdaki gibi bir komutla kullanılabilir:
```cmd
beacon> elevate svc-exe-krb tcp-local
```
Komut, bir bağlantıyı başarıyla kurduğunda şu şekilde bir çıktı verir:
```
[+] established link to child beacon: 172.16.0.100
```

---

## Notlar
- Bu araç, yalnızca yasal ve etik amaçlarla kullanılmalıdır.
- Kerberos biletlerinin uygun şekilde ayarlanmış olması gerekir.
- Hizmet yükü, hedef sistemde uygun izinlerle çalıştırılabilmelidir.

---

## Kaynaklar
- [SCMUACBypass GitHub](https://github.com/rasta-mouse/SCMUACBypass)
- [Kerberos Hakkında Daha Fazla Bilgi](https://learn.microsoft.com/en-us/windows-server/identity/kerberos)

---

Bu rehber, SCMUACBypass aracını kullanarak Service Control Manager üzerinden yetki yükseltme saldırılarını gerçekleştirmenin temellerini kapsamaktadır. Daha fazla bilgi için yukarıdaki kaynaklara başvurabilirsiniz.
