# SharpView.exe Kullanım Rehberi

## SharpView.exe Nedir?

**SharpView.exe**, Windows Active Directory ortamlarında bilgi toplamak ve güvenlik değerlendirmesi yapmak için kullanılan bir araçtır. Bu araç, Active Directory ilişkilerini ve nesnelerini analiz ederek, güvenlik açıklarını ve potansiyel saldırı yollarını tespit etmeye yardımcı olur.

> **Önemli Not:** SharpView.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Bilgi Toplama:**
   - Kullanıcı, grup, bilgisayar ve diğer AD nesnelerini keşfeder.
2. **Yetki ve İzin Analizi:**
   - AD üzerindeki ilişkileri ve izin yapılandırmalarını analiz eder.
3. **Hızlı ve Etkili:**
   - Active Directory ortamında hızlı veri toplama ve analiz yapma yeteneğine sahiptir.

---

## İndirme ve Çalıştırma

SharpView.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpView GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpView.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpView.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-domain`**
- Hedef Active Directory domain adını belirtir.

  **Kullanım:**
  ```cmd
  SharpView.exe -domain example.local
  ```

### 2. **`-user`**
- Belirli bir kullanıcı hesabını hedef alır.

  **Kullanım:**
  ```cmd
  SharpView.exe -domain example.local -user username
  ```

### 3. **`-permissions`**
- AD üzerindeki izin yapılandırmalarını analiz eder.

  **Kullanım:**
  ```cmd
  SharpView.exe -permissions
  ```

### 4. **`-search`**
- Belirli bir nesneyi veya ilişkileri arar.

  **Kullanım:**
  ```cmd
  SharpView.exe -search "GroupPolicy"
  ```

### 5. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpView.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Domain Üzerinden Bilgi Toplama
```cmd
SharpView.exe -domain example.local
```

### 2. Belirli Bir Kullanıcıyı Hedefleme
```cmd
SharpView.exe -domain example.local -user admin
```

### 3. Active Directory İzinlerini Analiz Etme
```cmd
SharpView.exe -permissions
```

### 4. Belirli Bir Nesneyi Arama
```cmd
SharpView.exe -search "GroupPolicy"
```

### 5. Yardım Mesajını Görüntüleme
```cmd
SharpView.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpView.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpView GitHub Sayfası](https://github.com)
- [Active Directory Documentation](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
