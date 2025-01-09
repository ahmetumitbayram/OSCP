# bloodyAD Kullanım Rehberi

## bloodyAD Nedir?

**bloodyAD**, Active Directory ortamlarında güvenlik açıklarını analiz etmek ve çeşitli saldırı senaryolarını test etmek için kullanılan bir araçtır. Özellikle, yetki yükseltme ve kötü yapılandırılmış AD nesnelerini tespit etme konusunda güçlüdür.

> **Önemli Not:** bloodyAD yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Active Directory Güvenlik Testleri:**
   - AD ortamındaki kullanıcılar, gruplar ve izinler üzerindeki güvenlik açıklarını analiz eder.
2. **Yetki Yükseltme:**
   - Kötü yapılandırılmış nesneleri tespit ederek yetki yükseltme yollarını gösterir.
3. **Kolay Kullanım ve Esneklik:**
   - Farklı AD ortamlarında hızlı bir şekilde çalıştırılabilir.

---

## İndirme ve Çalıştırma

bloodyAD aracı GitHub üzerinden sağlanabilir:

- [bloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/CravateRouge/bloodyAD.git
   cd bloodyAD
   python3 -m pip install -r requirements.txt
   ```

2. **Çalıştırın:**
   ```bash
   python3 bloodyAD.py <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-u` veya `--user`**
- Active Directory kullanıcısını belirtir.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py -u username
  ```

### 2. **`-p` veya `--password`**
- Kullanıcı şifresini belirtir.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py -u username -p password123
  ```

### 3. **`-d` veya `--domain`**
- Hedef domain adını belirtir.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py -u username -p password123 -d example.local
  ```

### 4. **`--server`**
- Hedef Domain Controller'ın IP adresini belirtir.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py -u username -p password123 -d example.local --server 192.168.1.10
  ```

### 5. **`--check`**
- AD ortamında belirli güvenlik açıklarını kontrol eder.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py --check
  ```

### 6. **`-h` veya `--help`**
- Yardım mesajını görüntüler.

  **Kullanım:**
  ```bash
  python3 bloodyAD.py -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Active Directory Kullanıcısı ile Giriş Yapma
```bash
python3 bloodyAD.py -u user -p Passw0rd! -d example.local
```

### 2. Güvenlik Açıklarını Kontrol Etme
```bash
python3 bloodyAD.py --check
```

### 3. Belirli Bir Domain Controller'ı Hedefleme
```bash
python3 bloodyAD.py -u user -p Passw0rd! -d example.local --server 192.168.1.10
```

### 4. Yardım Mesajını Görüntüleme
```bash
python3 bloodyAD.py -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** bloodyAD yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [bloodyAD GitHub Sayfası](https://github.com/CravateRouge/bloodyAD)
- [Active Directory Güvenlik Rehberi](https://learn.microsoft.com/en-us/windows-server/identity/active-directory-domain-services)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
