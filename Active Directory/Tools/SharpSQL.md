# SharpSQL.exe Kullanım Rehberi

## SharpSQL.exe Nedir?

**SharpSQL.exe**, Microsoft SQL Server ortamlarında güvenlik değerlendirmesi yapmak, yetki yükseltme yollarını analiz etmek ve veri tabanı zafiyetlerini tespit etmek için kullanılan bir güvenlik aracıdır. Bu araç, SQL Server'daki yapılandırmaları analiz eder ve potansiyel saldırı vektörlerini keşfetmek için tasarlanmıştır.

> **Önemli Not:** SharpSQL.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **SQL Server Keşfi:**
   - SQL Server örneklerini ve yapılandırmalarını analiz eder.
2. **Zafiyet Tespiti:**
   - SQL Server yapılandırmalarındaki güvenlik açıklarını belirler.
3. **Yetki Yükseltme Analizi:**
   - Potansiyel yetki yükseltme yollarını tespit eder.

---

## İndirme ve Çalıştırma

SharpSQL.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpSQL GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpSQL.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpSQL.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-discover`**
- SQL Server ortamını keşfeder ve mevcut yapılandırmaları listeler.

  **Kullanım:**
  ```cmd
  SharpSQL.exe -discover
  ```

### 2. **`-target`**
- Belirli bir SQL Server örneğini hedef alır.

  **Kullanım:**
  ```cmd
  SharpSQL.exe -target SQLServerName
  ```

### 3. **`-analyze`**
- Hedef SQL Server yapılandırmalarını analiz eder ve potansiyel zafiyetleri raporlar.

  **Kullanım:**
  ```cmd
  SharpSQL.exe -target SQLServerName -analyze
  ```

### 4. **`-query`**
- Belirli bir SQL sorgusunu çalıştırır ve çıktıyı döner.

  **Kullanım:**
  ```cmd
  SharpSQL.exe -target SQLServerName -query "SELECT * FROM sys.databases"
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpSQL.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. SQL Server Ortamını Keşfetme
```cmd
SharpSQL.exe -discover
```

### 2. Belirli Bir SQL Server Örneğini Hedefleme
```cmd
SharpSQL.exe -target SQLServerName
```

### 3. SQL Server Yapılandırmalarını Analiz Etme
```cmd
SharpSQL.exe -target SQLServerName -analyze
```

### 4. Belirli Bir Sorguyu Çalıştırma
```cmd
SharpSQL.exe -target SQLServerName -query "SELECT * FROM sys.databases"
```

### 5. Yardım Mesajını Görüntüleme
```cmd
SharpSQL.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpSQL.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpSQL GitHub Sayfası](https://github.com)
- [Microsoft SQL Server Documentation](https://learn.microsoft.com/en-us/sql/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
