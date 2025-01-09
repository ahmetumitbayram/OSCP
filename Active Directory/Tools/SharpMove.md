# SharpMove.exe Kullanım Rehberi

## SharpMove.exe Nedir?

**SharpMove.exe**, Windows ortamında dosya ve dizin taşıma işlemlerini etkili bir şekilde gerçekleştirmek için kullanılan bir araçtır. Bu araç, özellikle Active Directory ortamlarında büyük çaplı dosya taşıma işlemlerini otomatikleştirmek ve güvenli bir şekilde gerçekleştirmek için tasarlanmıştır.

> **Önemli Not:** SharpMove.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Dosya ve Dizin Taşıma:**
   - Hedef dosya ve dizinleri belirli bir hedefe taşır.
2. **Gelişmiş Kontrol:**
   - Dosya taşıma işlemleri için esnek ve özelleştirilebilir seçenekler sunar.
3. **Hızlı ve Güvenli İşlem:**
   - Minimum sistem kaynağı kullanarak hızlı taşıma işlemleri gerçekleştirir.

---

## İndirme ve Çalıştırma

SharpMove.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpMove GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpMove.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpMove.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-source`**
- Taşınacak dosya veya dizin yolunu belirtir.

  **Kullanım:**
  ```cmd
  SharpMove.exe -source "C:\Kaynak\Dosya.txt"
  ```

### 2. **`-destination`**
- Dosya veya dizinin taşınacağı hedef yolu belirtir.

  **Kullanım:**
  ```cmd
  SharpMove.exe -source "C:\Kaynak\Dosya.txt" -destination "D:\Hedef\"
  ```

### 3. **`-recursive`**
- Alt dizinlerdeki tüm dosyaları da taşır.

  **Kullanım:**
  ```cmd
  SharpMove.exe -source "C:\Kaynak\" -destination "D:\Hedef\" -recursive
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpMove.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Belirli Bir Dosyayı Taşımak
```cmd
SharpMove.exe -source "C:\Kaynak\Dosya.txt" -destination "D:\Hedef\"
```

### 2. Alt Dizinlerle Birlikte Tüm Dosyaları Taşımak
```cmd
SharpMove.exe -source "C:\Kaynak\" -destination "D:\Hedef\" -recursive
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SharpMove.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpMove.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpMove GitHub Sayfası](https://github.com)
- [Windows File Management](https://learn.microsoft.com/en-us/windows-server/administration/file-management/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
