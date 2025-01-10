# SharpUp Kullanım Rehberi

## SharpUp Nedir?

**SharpUp**, PowerUp aracının C# ile yeniden yazılmış bir sürümüdür. Windows sistemlerinde yerel zafiyetleri tespit etmek için kullanılan bir araçtır. SharpUp, sistemdeki zayıflıkları kontrol etmek için çeşitli işlevler sunar ancak şu anda herhangi bir silahlandırma (exploitation) işlevi içermez.

> **Önemli Not:** SharpUp yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Zafiyet Tespiti:**
   - Sistemdeki zafiyetleri ve yanlış yapılandırmaları kontrol eder.
2. **Geniş Kontrol Seçenekleri:**
   - Belirli kontrolleri çalıştırabilir veya tüm zafiyet kontrollerini denetleyebilir.
3. **Audit Modu:**
   - Yüksek yetkilere ihtiyaç duymadan tüm kontrolleri çalıştırır.

---

## İndirme ve Çalıştırma

SharpUp aracı GitHub üzerinden sağlanabilir:

- [SharpUp GitHub Sayfası](https://github.com/GhostPack/SharpUp)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/GhostPack/SharpUp.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpUp.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpUp.exe [audit] [kontrol1] [kontrol2]...
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpUp.exe [audit] [Kontroller]
```

### Desteklenen Kontroller
- **AlwaysInstallElevated:** Yanlış yapılandırılmış AlwaysInstallElevated ayarlarını kontrol eder.
- **CachedGPPPassword:** Group Policy Preferences şifrelerini kontrol eder.
- **DomainGPPPassword:** Domain bazlı Group Policy Preferences şifrelerini kontrol eder.
- **HijackablePaths:** Kullanıcı tarafından değiştirilebilen yolları kontrol eder.
- **ModifiableScheduledTask:** Değiştirilebilir zamanlanmış görevleri kontrol eder.
- **ModifiableServices:** Değiştirilebilir servisleri kontrol eder.
- **RegistryAutoLogons:** Otomatik oturum açma yapılandırmalarını kontrol eder.
- **UnattendedInstallFiles:** Yanlış yapılandırılmış unattended installation dosyalarını kontrol eder.
- **UnquotedServicePath:** Alıntılanmamış servis yollarını kontrol eder.

### Audit Modu
Audit modu, sistemdeki tüm zafiyetleri kullanıcı yetkileri ne olursa olsun denetler.

**Örnek Kullanım:**
```bash
SharpUp.exe audit
```

---

## Örnek Kullanım Senaryoları

### Tüm Kontrolleri Çalıştırma
```bash
SharpUp.exe audit
```

### Belirli Bir Kontrol Çalıştırma
Yanlış yapılandırılmış yolları kontrol etmek için:
```bash
SharpUp.exe HijackablePaths
```

### Audit Modunda Belirli Bir Kontrol Çalıştırma
Yanlış yapılandırılmış yolları audit modunda kontrol etmek için:
```bash
SharpUp.exe audit HijackablePaths
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpUp yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
