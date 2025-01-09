# SharpGPO.exe Kullanım Rehberi

## SharpGPO.exe Nedir?

**SharpGPO.exe**, Windows ortamında Grup İlkesi Nesnelerini (Group Policy Objects - GPO) yönetmek, düzenlemek ve analiz etmek için kullanılan bir güvenlik aracıdır. SharpGPO, Active Directory ortamında GPO’ları hedef alarak zafiyetleri analiz etmek veya yapılandırmaları değiştirmek için etkili bir çözümdür.

> **Önemli Not:** SharpGPO.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **GPO Manipülasyonu:**
   - Mevcut GPO’ları düzenleme ve analiz etme.
2. **Bilgi Toplama:**
   - Active Directory ortamındaki GPO yapılandırmalarını listeler.
3. **Yetkilendirme Testleri:**
   - GPO üzerinden güvenlik yapılandırmalarını test eder.

---

## İndirme ve Çalıştırma

SharpGPO.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [SharpGPO GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpGPO.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpGPO.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-list`**
- Mevcut GPO’ları listeler.

  **Kullanım:**
  ```cmd
  SharpGPO.exe -list
  ```

### 2. **`-info`**
- Belirli bir GPO hakkında ayrıntılı bilgi sağlar.

  **Kullanım:**
  ```cmd
  SharpGPO.exe -info <GPO_ID>
  ```

### 3. **`-add`**
- Yeni bir GPO ekler veya mevcut bir GPO’ya ayar ekler.

  **Kullanım:**
  ```cmd
  SharpGPO.exe -add <GPO_ID> -setting <Ayar_Detayları>
  ```

### 4. **`-delete`**
- Belirtilen bir GPO’yu siler.

  **Kullanım:**
  ```cmd
  SharpGPO.exe -delete <GPO_ID>
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpGPO.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm GPO’ları Listeleme
```cmd
SharpGPO.exe -list
```

### 2. Belirli Bir GPO Hakkında Bilgi Alma
```cmd
SharpGPO.exe -info "{GPO_GUID}"
```

### 3. GPO’ya Yeni Bir Ayar Ekleme
```cmd
SharpGPO.exe -add "{GPO_GUID}" -setting "New Setting Details"
```

### 4. Belirli Bir GPO’yu Silme
```cmd
SharpGPO.exe -delete "{GPO_GUID}"
```

### 5. Yardım Mesajını Görüntüleme
```cmd
SharpGPO.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpGPO.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpGPO GitHub Sayfası](https://github.com)
- [Windows Group Policy Management](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
