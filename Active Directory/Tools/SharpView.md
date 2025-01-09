# SharpView Kullanım Rehberi

## SharpView Nedir?

**SharpView**, PowerShell'deki **PowerView** aracının C# ile yeniden yazılmış bir sürümüdür. Active Directory (AD) ortamlarını keşfetmek ve yönetmek için kapsamlı bir dizi işlev sunar. AD üzerindeki kullanıcılar, gruplar, bilgisayarlar, politikalar ve daha fazlası hakkında bilgi toplamak için kullanılır.

> **Önemli Not:** SharpView yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Active Directory Keşfi:**
   - Domain yapısını, kullanıcıları, grupları ve diğer AD nesnelerini keşfeder.
2. **Kullanıcı ve Grup Yönetimi:**
   - Kullanıcı ve grup bilgilerini toplar ve manipüle eder.
3. **Politika ve Paylaşım Keşfi:**
   - Grup Politikalarını ve paylaşımları analiz eder.
4. **Zayıflık Keşfi:**
   - Hatalı yapılandırmalar ve potansiyel güvenlik açıklarını tespit eder.

---

## İndirme ve Çalıştırma

SharpView aracı GitHub üzerinden sağlanabilir:

- [SharpView GitHub Sayfası](https://github.com/tevora-threat/SharpView)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/tevora-threat/SharpView.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpView.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpView.exe <komut> [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpView.exe <Komut> [Parametreler]
```

### Örnek Komutlar

#### Domain Kontrolcüsü Bilgilerini Almak
```bash
SharpView.exe Get-DomainController -Domain test.local -Server dc.test.local -Credential admin@test.local/password
```

#### Kullanıcı Bilgilerini Almak
```bash
SharpView.exe Get-DomainUser -Domain test.local -Credential admin@test.local/password
```

#### Paylaşımları Listelemek
```bash
SharpView.exe Get-NetShare -Domain test.local
```

---

## Desteklenen Metotlar

### Kullanıcı ve Grup Yönetimi
- `Get-DomainUser`
- `Get-DomainGroup`
- `Get-DomainGroupMember`
- `Add-DomainGroupMember`
- `Set-DomainUserPassword`

### Domain ve Forest Keşfi
- `Get-Domain`
- `Get-DomainTrust`
- `Get-Forest`
- `Get-ForestTrust`
- `Get-DomainController`
- `Get-ForestGlobalCatalog`

### Politika ve Paylaşım Analizi
- `Get-DomainGPO`
- `Get-DomainPolicy`
- `Get-NetShare`
- `Find-DomainShare`

### Güvenlik ve Zayıflık Analizi
- `Invoke-Kerberoast`
- `Find-InterestingDomainAcl`
- `Invoke-ACLScanner`

---

## Örnek Kullanım Senaryoları

1. **Domain Kullanıcılarını Listeleme**:
   ```bash
   SharpView.exe Get-DomainUser -Domain example.local
   ```

2. **Domain Kontrolcülerini Keşfetme**:
   ```bash
   SharpView.exe Get-DomainController -Domain example.local
   ```

3. **Paylaşımları Keşfetme**:
   ```bash
   SharpView.exe Get-NetShare -Domain example.local
   ```

4. **Kerberoast Saldırısını Başlatma**:
   ```bash
   SharpView.exe Invoke-Kerberoast -Domain example.local
   ```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpView yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
