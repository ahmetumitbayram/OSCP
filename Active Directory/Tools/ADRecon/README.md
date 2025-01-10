# ADRecon Kullanım Rehberi

## ADRecon Nedir?

**ADRecon**, Active Directory (AD) ortamından kapsamlı bilgiler toplamak için kullanılan bir PowerShell aracıdır. Bu araç, AD ortamının mevcut durumunu analiz etmek ve raporlamak için çeşitli bilgileri toplar. ADRecon, özellikle güvenlik denetimleri, adli bilişim incelemeleri ve penetrasyon testleri sırasında kullanılabilir.

> **Önemli Not:** ADRecon yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Active Directory Bilgi Toplama:**
   - Forest, domain, kullanıcılar, gruplar, GPO’lar, ACL’ler ve daha fazlasını toplar.
2. **Kapsamlı Raporlama:**
   - Toplanan bilgileri Microsoft Excel biçiminde veya çeşitli diğer formatlarda (CSV, JSON, HTML, vb.) raporlar.
3. **Non-Privileged Kullanıcı Desteği:**
   - Standart bir domain kullanıcısı ile çalıştırılabilir.
4. **RSAT Entegrasyonu:**
   - Remote Server Administration Tools (RSAT) kullanarak daha kapsamlı bilgi toplama.

---

## Gereksinimler

- **PowerShell 2.0 veya üstü** (Windows 7 ve sonrası).
- **.NET Framework 3.0 veya üstü.**
- **Windows İşletim Sistemi:** Linux ve macOS desteklenmez.
- **Microsoft Excel (opsiyonel):** Rapor oluşturmak için gerekli.
- **RSAT (opsiyonel):** Daha fazla bilgi toplamak için kullanılabilir.

---

## İndirme ve Kurulum

ADRecon aracı GitHub üzerinden sağlanabilir:

- [ADRecon GitHub Sayfası](https://github.com/adrecon/ADRecon)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/adrecon/ADRecon.git
   ```

2. **PowerShell ile Çalıştırma:**
   - PowerShell oturumunu açın ve script’i çalıştırın.
   ```powershell
   .\ADRecon.ps1
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```powershell
.\ADRecon.ps1 [Parametreler]
```

### Parametreler

- **-Method:** Kullanılacak yöntem (ADWS varsayılan). Geçerli değerler: ADWS, LDAP.
- **-DomainController:** Hedef Domain Controller’ın IP adresi veya FQDN’i.
- **-Credential:** Domain kullanıcı adı ve şifre bilgisi.
- **-OutputDir:** Çıktı dosyalarının kaydedileceği klasör.
- **-Collect:** Toplanacak modüller (örneğin: Forest, Domain, Groups).
- **-OutputType:** Çıktı formatı (örneğin: CSV, Excel, JSON).
- **-DormantTimeSpan:** Kullanıcıların etkin olmadıkları süre (varsayılan: 90 gün).
- **-PassMaxAge:** Makine hesabı parolası için maksimum yaş (varsayılan: 30 gün).
- **-Threads:** İşlem sırasında kullanılacak thread sayısı (varsayılan: 10).

---

## Örnek Komutlar

### Domain Üyesi Host Üzerinde Çalıştırma
```powershell
.\ADRecon.ps1
```

### Belirli Bir Domain Controller ile Çalıştırma
```powershell
.\ADRecon.ps1 -DomainController dc1.test.local -Credential test\admin
```

### LDAP ile Çalıştırma
```powershell
.\ADRecon.ps1 -Method LDAP -DomainController dc1.test.local -Credential test\admin
```

### Özel Modüller ile Çalıştırma
```powershell
.\ADRecon.ps1 -Collect Forest,Domain,Groups -OutputType CSV
```

### Excel Raporu Oluşturma
```powershell
.\ADRecon.ps1 -GenExcel C:\Raporlar\ADRecon-Report.xlsx
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** ADRecon yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
