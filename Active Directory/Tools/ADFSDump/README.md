# ADFSDump Kullanım Rehberi

## ADFSDump Nedir?

**ADFSDump**, Active Directory Federation Services (AD FS) yapılandırma veritabanından bilgi toplamak için kullanılan bir C# aracıdır. Araç, AD FS yapılandırmasını analiz ederek sahte güvenlik belirteçleri (tokens) oluşturmak için gerekli bilgileri sağlar. ADFSDump, **ADFSpoof** aracı ile birlikte çalışmak üzere tasarlanmıştır.

> **Önemli Not:** ADFSDump yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Active Directory ve AD FS Veritabanı Keşfi:**
   - Active Directory ve AD FS yapılandırma veritabanından bilgi toplar.
2. **Sahte Token Hazırlığı:**
   - Sahte güvenlik belirteçleri oluşturmak için gereken bilgileri sağlar.
3. **Federated Uygulama Analizi:**
   - AD FS yapılandırmasındaki federated uygulamaları analiz eder ve önemli bilgileri döker.

---

## Gereksinimler

- **AD FS Hizmet Hesabı Yetkisi:**
  ADFSDump, yalnızca AD FS hizmet hesabı bağlamında çalıştırılabilir. AD FS yapılandırma veritabanına yalnızca bu hesap erişebilir.
- **Yerel Çalıştırma:**
  Araç, yalnızca AD FS sunucusunda çalıştırılabilir. AD FS web uygulama proxy’si desteklenmez.
- **Windows Internal Database (WID):**
  Araç, varsayılan olarak WID kullanır. Harici SQL sunucuları için ek yapılandırma gerekebilir.

---

## İndirme ve Derleme

ADFSDump aracı GitHub üzerinden sağlanabilir:

- [ADFSDump GitHub Sayfası](https://github.com/mandiant/ADFSDump)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/mandiant/ADFSDump.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `ADFSDump.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   ADFSDump.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
ADFSDump.exe /domain:<hedef_domain> /server:<hedef_DC> [opsiyonel_parametreler]
```

### Parametreler

- **/domain:** Hedef Active Directory domain adı. Varsayılan: Mevcut domain.
- **/server:** Hedef Domain Controller (DC). Varsayılan: Mevcut DC.
- **/nokey:** DKM anahtarının çıktısını devre dışı bırakır.
- **/database:** Harici SQL bağlantısı için bağlantı dizesi (örneğin: "/database:Data Source=sql.domain.com;Initial Catalog=AdfsConfigurationV4;Integrated Security=True").
- **/username:** Araç için kullanıcı adı (isteğe bağlı).
- **/password:** Belirtilen kullanıcı için parola (isteğe bağlı).

---

## Örnek Komutlar

### Mevcut Domain ve DC ile Çalıştırma
```bash
ADFSDump.exe /domain:test.local /server:dc1.test.local
```

### DKM Anahtarını Devre Dışı Bırakma
```bash
ADFSDump.exe /domain:test.local /server:dc1.test.local /nokey
```

### Harici SQL Sunucusu Kullanımı
```bash
ADFSDump.exe /database:"Data Source=sql.domain.com;Initial Catalog=AdfsConfigurationV4;Integrated Security=True"
```

### Kullanıcı Adı ve Parola ile Çalıştırma
```bash
ADFSDump.exe /domain:test.local /server:dc1.test.local /username:admin /password:Password123!
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** ADFSDump yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
