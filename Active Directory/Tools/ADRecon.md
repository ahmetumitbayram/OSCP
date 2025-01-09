# ADRecon.ps1 Kullanım Rehberi

## ADRecon.ps1 Nedir?

**ADRecon.ps1**, Active Directory ortamlarında bilgi toplamak ve detaylı raporlar oluşturmak için kullanılan bir PowerShell scriptidir. Active Directory güvenlik denetimlerinde, sistem yöneticileri ve güvenlik profesyonelleri tarafından sıkça kullanılır. Script, sistem yapılandırmalarını ve ilişkili bilgileri bir araya getirerek analiz edilmesini kolaylaştırır.

> **Önemli Not:** ADRecon yalnızca yetkili erişimle ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Bilgi Toplama:**
   - Active Directory kullanıcıları, grupları, ve bilgisayar nesneleri hakkında bilgi toplar.
   - Grup İlkesi Nesnelerini (GPO) analiz eder.
   - Domain yapılandırmaları ve FSMO rolleri hakkında bilgi sağlar.
2. **Raporlama:**
   - Tüm bilgileri yapılandırılmış HTML ve CSV raporlarına dönüştürür.
3. **Kolay Entegrasyon:**
   - PowerShell uyumlu tüm Windows sistemlerinde çalışabilir.

---

## İndirme ve Çalıştırma

ADRecon.ps1, GitHub üzerinde bulunabilir:

- [https://github.com/sense-of-security/ADRecon](https://github.com/sense-of-security/ADRecon)

### Çalıştırma Adımları

1. **Script'i İndir:**
   ```bash
   git clone https://github.com/sense-of-security/ADRecon.git
   cd ADRecon
   ```
2. **PowerShell'de Çalıştır:**
   ```powershell
   .\ADRecon.ps1
   ```

---

## Kullanım Parametreleri

Aşağıda ADRecon'un yaygın kullanılan parametreleri açıklanmıştır.

### 1. **`-OutputPath`**
- Çıktı dosyalarının kaydedileceği yolu belirler.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -OutputPath "C:\ADReconOutput"
  ```

### 2. **`-CollectAll`**
- Active Directory'deki tüm bilgileri toplar.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -CollectAll
  ```

### 3. **`-DomainControllers`**
- Belirli Domain Controller'lar üzerinde çalıştırmak için kullanılır.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -DomainControllers "DC01,DC02"
  ```

### 4. **`-SkipGPO`**
- Grup İlkesi Nesneleri (GPO) analizini atlar.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -SkipGPO
  ```

### 5. **`-Verbose`**
- Çalışma sırasında detaylı bilgi verir.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -Verbose
  ```

### 6. **`-Help`**
- Script'in yardım mesajını gösterir.

  **Kullanım:**
  ```powershell
  .\ADRecon.ps1 -Help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm Active Directory Bilgilerini Toplama
```powershell
.\ADRecon.ps1 -CollectAll -OutputPath "C:\ADReconOutput"
```

### 2. Belirli Domain Controller Üzerinde Çalışma
```powershell
.\ADRecon.ps1 -DomainControllers "DC01" -OutputPath "C:\ADReconOutput"
```

### 3. Grup İlkesi (GPO) Analizini Atlayarak Çalıştırma
```powershell
.\ADRecon.ps1 -SkipGPO -OutputPath "C:\ADReconOutput"
```

### 4. Detaylı Bilgiyle Çalıştırma
```powershell
.\ADRecon.ps1 -Verbose
```

---

## Çıktı Formatları

ADRecon, aşağıdaki formatlarda çıktı üretebilir:

1. **HTML:** Görselleştirilmiş ve okunabilir raporlar için.
2. **CSV:** Daha fazla analiz ve dışa aktarma için yapılandırılmış veriler.

Çıktılar belirttiğiniz dizinde otomatik olarak oluşturulur.

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Script yalnızca Active Directory yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** İlk kez kullanmadan önce test ortamında çalıştırılması önerilir.
- **Loglama:** Script çalıştırıldığında sistemde loglanabilir. Gizliliğinizi koruyun.

---

## Kaynaklar

- [Resmi GitHub Sayfası](https://github.com/sense-of-security/ADRecon)
- [Microsoft Docs](https://learn.microsoft.com/en-us/powershell/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
