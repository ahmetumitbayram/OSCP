# SharpHound.exe Kullanım Rehberi

## SharpHound.exe Nedir?

**SharpHound.exe**, Active Directory (AD) ortamında bilgi toplamak ve ilişkisel veri analizi yapmak için kullanılan bir araçtır. Bu araç, BloodHound ile uyumlu bir veri toplayıcıdır ve AD içerisindeki ilişkiler, kullanıcı izinleri ve grup üyelikleri gibi bilgileri analiz etmek için tasarlanmıştır.

> **Önemli Not:** SharpHound.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Bilgi Toplama:**
   - Kullanıcı, grup, bilgisayar ve ilişkisel bilgileri toplar.
2. **BloodHound ile Entegrasyon:**
   - Toplanan verileri BloodHound arayüzünde analiz etmek için JSON formatında çıktılar sağlar.
3. **Özelleştirilebilir Toplama Modları:**
   - Belirli bir veri kümesi veya tüm domain üzerinden veri toplayabilir.

---

## İndirme ve Çalıştırma

SharpHound.exe genellikle BloodHound araç setiyle birlikte gelir:

- [BloodHound GitHub Sayfası](https://github.com/BloodHoundAD/BloodHound)

### Çalıştırma Adımları

1. **BloodHound Araçlarını İndirin:**
   ```bash
   git clone https://github.com/BloodHoundAD/BloodHound.git
   cd BloodHound/Collectors
   ```

2. **SharpHound.exe Dosyasını Çalıştırın:**
   ```cmd
   SharpHound.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-c` veya `--collectionmethods`**
- Toplama yöntemlerini belirtir. Mevcut yöntemler: `Default`, `LocalAdmin`, `Session`, `Trusts`, `RDP`.

  **Kullanım:**
  ```cmd
  SharpHound.exe -c All
  ```

### 2. **`-d` veya `--domain`**
- Hedef Active Directory domain adını belirtir.

  **Kullanım:**
  ```cmd
  SharpHound.exe -d example.local
  ```

### 3. **`-o` veya `--outputdirectory`**
- Çıktı dosyalarının kaydedileceği dizini belirtir.

  **Kullanım:**
  ```cmd
  SharpHound.exe -o C:\BloodHoundData
  ```

### 4. **`-h` veya `--help`**
- Kullanım bilgilerini ve mevcut seçenekleri listeler.

  **Kullanım:**
  ```cmd
  SharpHound.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Tüm Veri Toplama Yöntemlerini Çalıştırma
```cmd
SharpHound.exe -c All -d example.local -o C:\BloodHoundData
```

### 2. Yerel Yönetici Haklarını Toplama
```cmd
SharpHound.exe -c LocalAdmin -o C:\BloodHoundData
```

### 3. Belirli Bir Domain’den Veri Toplama
```cmd
SharpHound.exe -d example.local -c Default -o C:\BloodHoundData
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpHound.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpHound.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [BloodHound Resmi GitHub Sayfası](https://github.com/BloodHoundAD/BloodHound)
- [Active Directory Güvenlik Yönetimi](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
