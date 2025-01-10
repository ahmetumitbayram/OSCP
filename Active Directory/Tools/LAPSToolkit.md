# LAPSToolkit.ps1 Kullanım Kılavuzu

## Hakkında

**LAPSToolkit.ps1**, Active Directory ortamlarında Local Administrator Password Solution (LAPS) kullanımıyla ilgili bilgileri toplamak, analiz etmek ve çeşitli zafiyetlerden faydalanmak için tasarlanmış bir PowerShell scriptidir. 

Bu script, PowerView ve diğer güvenlik analiz araçlarından esinlenerek şu işlevleri gerçekleştirir:
- LAPS ile korunan bilgisayarları listeleme
- Parolalara erişim izinlerini analiz etme
- Yetki devri gruplarını belirleme

---

## Özellikler

- **LAPS Bilgisayar Listesi:** LAPS özelliği etkinleştirilmiş bilgisayarları bulur.
- **Parola Yetki Analizi:** Parolaya erişim hakkı olan kullanıcı ve grupları görüntüler.
- **Yetki Devri Grupları:** LAPS parolalarını okuma izni olan grupları belirler.

---

## Kullanım

### Çalıştırma Gereksinimleri

- PowerShell 2.0 veya daha yeni bir sürüm.
- Active Directory modülü yüklenmiş olmalıdır.

### Komutlar ve Parametreler

#### **Find-AdmPwdExtendedRights**

**Açıklama:**

LAPS etkinleştirilmiş bilgisayarların "ms-Mcs-AdmPwd" niteliklerine erişim izni olan kullanıcıları ve grupları bulur.

**Kullanım Formatı:**
```powershell
Find-AdmPwdExtendedRights -Domain <DomainAdi> -DomainController <DC> -Filter <LDAP_Filtre>
```

**Örnekler:**
```powershell
Find-AdmPwdExtendedRights
Find-AdmPwdExtendedRights -ComputerName victim1.testlab.local
```

---

#### **Find-LAPSDelegatedGroups**

**Açıklama:**

LAPS parolalarına erişim izni olan grupları belirler. Active Directory organizasyon birimlerini (OU) tarar.

**Kullanım Formatı:**
```powershell
Find-LAPSDelegatedGroups -Domain <DomainAdi> -DomainController <DC>
```

**Örnekler:**
```powershell
Find-LAPSDelegatedGroups
```

---

#### **Get-LAPSComputers**

**Açıklama:**

LAPS etkinleştirilmiş bilgisayarların listesini döner. Erişim izniniz varsa parolaları da görüntüler.

**Kullanım Formatı:**
```powershell
Get-LAPSComputers -Domain <DomainAdi> -DomainController <DC>
```

**Örnekler:**
```powershell
Get-LAPSComputers
Get-LAPSComputers -ComputerName victim1.testlab.local
```

---

## Hata Kodları ve Sorun Giderme

### Hata 1: "Access Denied"
**Sebep:** Yeterli izinlere sahip değilsiniz.
**Çözüm:** Yetkili bir hesap kullanarak tekrar deneyin.

### Hata 2: "No LAPS-enabled Computers Found"
**Sebep:** Belirtilen filtreye uyan bilgisayar bulunamadı.
**Çözüm:** Filtre parametrelerini doğrulayın.

---

## Katkılar ve Teşekkürler

- **Will Schroeder (@harmj0y)** – PowerView işlevleri
- **Sean Metcalf (@pyrotek3)** – Active Directory zafiyetleri
- **Karl Fosaaen (@kfosaaen)** – LAPS analiz metotları

---

## Lisans

**LAPSToolkit.ps1**, sadece eğitim ve yetkili test ortamlarında kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.
