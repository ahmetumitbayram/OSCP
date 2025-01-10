# PowerUpSQL.ps1 Kullanım Kılavuzu

## Giriş
PowerUpSQL.ps1, SQL Server ortamlarında güvenlik açıklarını tespit etmek ve kötüye kullanmak için tasarlanmış bir PowerShell betiğidir. Bu araç, özellikle yetki yükseltme, veri çıkarma ve SQL Server yanlış yapılandırmalarını keşfetmek için kullanılır.

Bu kılavuz, PowerUpSQL.ps1 aracını kullanarak nasıl bilgi toplayacağınızı ve SQL Server zafiyetlerini nasıl değerlendireceğinizi adım adım açıklar.

---

## Gereksinimler
- Windows sistem
- PowerShell
- SQL Server ortamına erişim
- Betik çalıştırma kısıtlamalarını bypass etme yetkisi

---

## Özellikler
PowerUpSQL.ps1 aşağıdaki işlemleri gerçekleştirebilir:
- SQL Server'ları taramak ve keşfetmek
- SQL Server kimlik doğrulama zafiyetlerini analiz etmek
- Yanlış yapılandırılmış SQL izinlerini tespit etmek
- Veri sızdırma ve SQL sorgularını kötüye kullanma
- SQL Server hizmet hesaplarını analiz etme

---

## Kullanım
### 1. **PowerUpSQL.ps1 Betiğini Çalıştırma**
#### Betiğin İndirilmesi
PowerUpSQL.ps1'i indirerek kullanabilirsiniz:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/NetSPI/PowerUpSQL/master/PowerUpSQL.ps1 -OutFile PowerUpSQL.ps1
```

#### Betiğin Yüklenmesi
PowerShell oturumunuza betiği yüklemek için:
```powershell
Import-Module .\PowerUpSQL.ps1
```

### 2. **Bilgi Toplama**
#### SQL Server Taraması
Ağdaki SQL Server'ları taramak için aşağıdaki komutu kullanın:
```powershell
Get-SQLInstanceDomain
```
Bu komut, etki alanında bulunan SQL Server'ları listeler.

#### SQL Server Kimlik Doğrulama Testi
Kimlik doğrulama testleri yapmak için:
```powershell
Invoke-SQLAudit -Instance "SQLSERVER01" -Verbose
```
Bu komut, belirtilen SQL Server üzerinde zafiyet değerlendirmesi yapar.

#### Hizmet Hesaplarını İnceleme
SQL Server hizmet hesaplarını analiz etmek için:
```powershell
Get-SQLServiceAccount -Instance "SQLSERVER01"
```
Bu komut, SQL Server hizmet hesaplarını ve yapılandırmalarını inceler.

### 3. **Zafiyetlerin Kötüye Kullanılması**
#### Veri Çıkarma
SQL Server'dan veri çıkarmak için:
```powershell
Invoke-SQLOSCmd -Instance "SQLSERVER01" -Command "SELECT * FROM master.sys.databases"
```
Bu komut, belirtilen SQL Server örneğinden veri çeker.

#### Yetki Yükseltme
SQL Server üzerinden yetki yükseltme denemesi yapmak için:
```powershell
Invoke-SQLPrivEsc -Instance "SQLSERVER01"
```
Bu komut, zafiyetleri kullanarak yetki yükseltmeyi dener.

---

## Örnek Senaryo
Bir SQL Server ortamında yetki yükseltme yapmayı denediğinizi varsayalım:
1. **SQL Server Taraması:**
   ```powershell
   Get-SQLInstanceDomain
   ```
   Bu komut, ağdaki SQL Server'ları listeler.

2. **Zafiyet Analizi:**
   ```powershell
   Invoke-SQLAudit -Instance "SQLSERVER01" -Verbose
   ```
   Zayıflıkları tespit etmek için bu komutu çalıştırın.

3. **Yetki Yükseltme:**
   ```powershell
   Invoke-SQLPrivEsc -Instance "SQLSERVER01"
   ```
   Belirtilen SQL Server üzerinde yetki yükseltmeyi deneyin.

---

## Güvenlik Notları
PowerUpSQL.ps1 yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, yalnızca sistem yöneticilerinin güvenlik açıklarını tespit etmesine ve gidermesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [PowerUpSQL.ps1 GitHub](https://github.com/NetSPI/PowerUpSQL)
- [Resmi Belgeler](https://github.com/NetSPI/PowerUpSQL)

---

Bu rehber, PowerUpSQL.ps1 betiğini kullanarak SQL Server ortamlarında zafiyet analizi ve yetki yükseltme denemeleri yapmanın temellerini kapsamaktadır. Daha fazla bilgi veya yardım için GitHub sayfasını ziyaret edin.
