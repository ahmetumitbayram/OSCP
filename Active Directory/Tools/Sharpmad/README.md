# SharpMad Kullanım Rehberi

## SharpMad Nedir?

**SharpMad**, PowerMad aracının C# ile yeniden yazılmış bir versiyonudur. Active Directory (AD) ortamlarında DNS güncellemeleri, makine hesabı yönetimi gibi işlemleri gerçekleştirmek için kullanılır. Araç, AD'deki hatalı yapılandırmaları değerlendirmek ve güvenlik açıklarını analiz etmek için tasarlanmıştır.

> **Önemli Not:** SharpMad yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

### ADIDNS Modülü
- ADIDNS (Active Directory Integrated DNS) ile DNS kayıtlarını yönetir.
- Kullanılabilecek işlemler:
  - **AddACE:** DNS kaydına ACE (Access Control Entry) ekler.
  - **Disable:** DNS kaydını pasifleştirir.
  - **GetDACL:** DNS kaydının DACL (Discretionary Access Control List) değerini alır.
  - **New:** Yeni bir DNS kaydı oluşturur.
  - **Remove:** DNS kaydını siler.
  - **SetOwner:** DNS kaydının sahibini değiştirir.

### MachineAccountQuota (MAQ) Modülü
- Makine hesaplarını yönetir.
- Kullanılabilecek işlemler:
  - **AgentSmith:** Rekürsif olarak makine hesapları oluşturur.
  - **New:** Yeni bir makine hesabı ekler.
  - **Remove:** Mevcut bir makine hesabını kaldırır.
  - **SetAttribute:** Makine hesabı özniteliklerini ayarlar.

---

## İndirme ve Çalıştırma

SharpMad aracı GitHub üzerinden sağlanabilir:

- [SharpMad GitHub Sayfası](https://github.com/Kevin-Robertson/Sharpmad)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/Kevin-Robertson/Sharpmad.git
   ```

2. **Derleme:**
   - Visual Studio veya benzeri bir IDE kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpMad.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpMad.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### Ortak Parametreler
- **Append:** Bir öznitelik değerini üzerine yazmak yerine ekler.
- **Attribute:** LDAP özniteliğini belirtir.
- **Clear:** Öznitelik değerini temizler.
- **DistinguishedName:** AD nesnesinin Distinguished Name (DN) değerini belirtir.
- **Domain:** Hedef domain (örneğin: `example.local`).
- **DomainController:** Hedef Domain Controller adresi.
- **Username:** LDAP kullanıcı adı (örneğin: `domain\user`).
- **Password:** LDAP kullanıcısının şifresi.

### ADIDNS Parametreleri
- **Node:** DNS kaydının adı.
- **Zone:** ADIDNS bölgesi.
- **Type:** DNS kaydı türü (örneğin: `A`, `AAAA`, `CNAME`).
- **TTL:** DNS kaydı için TTL (Time to Live) değeri.

### MachineAccountQuota Parametreleri
- **MachineAccount:** Makine hesabı adı.
- **MachinePassword:** Makine hesabı şifresi.
- **Container:** AD konteyneri.

---

## Örnek Kullanım Senaryoları

### ADIDNS Kullanımı
Yeni bir DNS kaydı oluşturmak için:
```bash
SharpMad.exe ADIDNS -Action New -Node test.example.local -Zone example.local -Type A -TTL 3600
```

### Makine Hesabı Oluşturma
Yeni bir makine hesabı eklemek için:
```bash
SharpMad.exe MAQ -Action New -MachineAccount test -MachinePassword Password123
```

### Makine Hesabı Silme
Bir makine hesabını kaldırmak için:
```bash
SharpMad.exe MAQ -Action Remove -MachineAccount test
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpMad yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
