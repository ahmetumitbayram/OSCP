# SharpSCCM.exe Kullanım Rehberi

## SharpSCCM.exe Nedir?

**SharpSCCM.exe**, Microsoft System Center Configuration Manager (SCCM) yapılandırmalarını analiz etmek ve zafiyetleri tespit etmek için kullanılan bir güvenlik aracıdır. Bu araç, SCCM üzerinden güvenlik değerlendirmeleri yapmak ve potansiyel saldırı vektörlerini keşfetmek için tasarlanmıştır.

> **Önemli Not:** SharpSCCM.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **SCCM Keşfi:**
   - SCCM yapılandırmalarını, istemci ve sunucu iletişimlerini analiz eder.
2. **Zafiyet Tespiti:**
   - SCCM yapılandırmalarındaki güvenlik açıklarını belirler.
3. **Saldırı Yolu Analizi:**
   - SCCM üzerinden potansiyel yetki yükseltme ve lateral movement yollarını tespit eder.

---

## İndirme ve Çalıştırma

SharpSCCM.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpSCCM GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpSCCM.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpSCCM.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-discover`**
- SCCM ortamını keşfeder ve mevcut yapılandırmaları listeler.

  **Kullanım:**
  ```cmd
  SharpSCCM.exe -discover
  ```

### 2. **`-target`**
- Belirli bir SCCM istemcisi veya sunucusunu hedef alır.

  **Kullanım:**
  ```cmd
  SharpSCCM.exe -target SCCMServerName
  ```

### 3. **`-analyze`**
- Hedef SCCM yapılandırmalarını analiz eder ve potansiyel zafiyetleri raporlar.

  **Kullanım:**
  ```cmd
  SharpSCCM.exe -target SCCMServerName -analyze
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpSCCM.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. SCCM Ortamını Keşfetme
```cmd
SharpSCCM.exe -discover
```

### 2. Belirli Bir SCCM Sunucusunu Hedefleme
```cmd
SharpSCCM.exe -target SCCMServerName
```

### 3. SCCM Yapılandırmalarını Analiz Etme
```cmd
SharpSCCM.exe -target SCCMServerName -analyze
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpSCCM.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpSCCM.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpSCCM GitHub Sayfası](https://github.com)
- [Microsoft SCCM Documentation](https://learn.microsoft.com/en-us/mem/configmgr/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
