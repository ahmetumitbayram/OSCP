# Invoke-ADEnum.ps1 Kullanım Rehberi

## Invoke-ADEnum.ps1 Nedir?

**Invoke-ADEnum.ps1**, PowerShell tabanlı bir araçtır ve Active Directory (AD) ortamlarında bilgi toplamak için kullanılır. Bu araç, saldırganların veya güvenlik test uzmanlarının, AD yapısını anlamalarına ve potansiyel zafiyetleri tespit etmelerine olanak tanır. Özellikle kullanıcılar, gruplar, bilgisayarlar ve diğer AD nesneleri hakkında detaylı bilgi sağlar.

> **Önemli Not:** Bu araç yalnızca yetkili sistemlerde ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Tarama:**
   - Kullanıcı, grup, bilgisayar, ve GPO bilgilerini toplar.
2. **Erişim Hakları Analizi:**
   - Kullanıcıların ve grupların erişim yetkilerini analiz eder.
3. **Tüm AD Yapısının Haritasını Çıkarma:**
   - AD içerisindeki ilişkileri anlamak için eksiksiz bir harita sunar.

---

## İndirme ve Çalıştırma

Invoke-ADEnum.ps1, GitHub üzerinden indirilebilir:

- [https://github.com](https://github.com)

### Çalıştırma Adımları

1. **Script’i İndirin:**
   ```bash
   git clone https://github.com/path/to/Invoke-ADEnum.git
   cd Invoke-ADEnum
   ```
2. **PowerShell'de Script'i Çalıştırın:**
   ```powershell
   Import-Module .\Invoke-ADEnum.ps1
   Invoke-ADEnum
   ```

---

## Kullanım Parametreleri

### 1. **`-Domain`**
- Hedef alınacak domain adı.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -Domain example.com
  ```

### 2. **`-User`**
- Kullanıcı bilgilerini toplar.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -User
  ```

### 3. **`-Group`**
- Grup bilgilerini toplar.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -Group
  ```

### 4. **`-Computer`**
- Bilgisayar nesnelerini listeler.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -Computer
  ```

### 5. **`-GPO`**
- Grup İlkesi Nesnelerini (GPO) toplar.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -GPO
  ```

### 6. **`-Output`**
- Çıktıyı belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -Output "C:\AD_Enum_Results.txt"
  ```

### 7. **`-Help`**
- Script'in kullanım kılavuzunu gösterir.

  **Kullanım:**
  ```powershell
  Invoke-ADEnum -Help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kullanıcı ve Grup Bilgilerini Toplama
```powershell
Invoke-ADEnum -User -Group
```

### 2. Tüm Bilgileri Belirli Bir Domain'de Toplama
```powershell
Invoke-ADEnum -Domain example.com
```

### 3. GPO Bilgilerini Çıktıya Kaydetme
```powershell
Invoke-ADEnum -GPO -Output "C:\AD_Enum_GPO.txt"
```

### 4. Yardım Mesajını Görüntüleme
```powershell
Invoke-ADEnum -Help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Invoke-ADEnum.ps1 yalnızca Active Directory yöneticileri veya yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir, bu nedenle dikkatli olunmalıdır.

---

## Kaynaklar

- [GitHub Sayfası](https://github.com)
- [Active Directory Hakkında Microsoft Dokümantasyonu](https://learn.microsoft.com/en-us/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
