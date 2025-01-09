# BloodyAD.exe Kullanım Rehberi

## BloodyAD.exe Nedir?

**BloodyAD.exe**, Active Directory ortamında güvenlik açıklarını tespit etmek ve saldırı simülasyonları gerçekleştirmek için kullanılan bir araçtır. Bu araç, AD içindeki zafiyetli yapılandırmaları hedef alır ve yetki yükseltme gibi saldırı yollarını analiz etmek için tasarlanmıştır.

> **Önemli Not:** BloodyAD.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Bilgi Toplama:**
   - Kullanıcı, grup, bilgisayar nesneleri ve izin yapılandırmalarını analiz eder.
2. **Zafiyet Tespiti:**
   - Active Directory ortamındaki potansiyel güvenlik açıklarını belirler.
3. **Saldırı Yolu Analizi:**
   - Yetki yükseltme veya hassas bilgilere erişim yollarını simüle eder.

---

## İndirme ve Çalıştırma

BloodyAD.exe GitHub üzerinden indirilebilir:

- [BloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/CravateRouge/bloodyAD.git
   cd bloodyAD
   ```

2. **Derleyin veya Hazır İkili Dosyayı Kullanın:**
   Visual Studio kullanarak projeyi derleyebilir veya yayınlanan ikili dosyayı doğrudan kullanabilirsiniz.

3. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   BloodyAD.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-d` veya `--domain`**
- Hedef Active Directory domain adını belirtir.

  **Kullanım:**
  ```cmd
  BloodyAD.exe -d example.local
  ```

### 2. **`-u` veya `--user`**
- Kullanıcı adını belirtir.

  **Kullanım:**
  ```cmd
  BloodyAD.exe -u username
  ```

### 3. **`-p` veya `--password`**
- Kullanıcı şifresini belirtir.

  **Kullanım:**
  ```cmd
  BloodyAD.exe -p password123
  ```

### 4. **`-a` veya `--attack`**
- Saldırı modunu başlatır ve potansiyel saldırı yollarını analiz eder.

  **Kullanım:**
  ```cmd
  BloodyAD.exe -a kerberoasting
  ```

### 5. **`-h` veya `--help`**
- Kullanım bilgilerini ve mevcut seçenekleri listeler.

  **Kullanım:**
  ```cmd
  BloodyAD.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Active Directory Domain Belirterek Çalıştırma
```cmd
BloodyAD.exe -d example.local -u admin -p password123
```

### 2. Kerberoasting Saldırısını Simüle Etme
```cmd
BloodyAD.exe -d example.local -a kerberoasting
```

### 3. Yardım Mesajını Görüntüleme
```cmd
BloodyAD.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** BloodyAD.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [BloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)
- [Active Directory Güvenlik Yönetimi](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
