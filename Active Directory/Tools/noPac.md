# noPac Kullanım Rehberi

## noPac Nedir?

**noPac**, Active Directory ortamlarında CVE-2021-42287 ve CVE-2021-42278 güvenlik açıklarını istismar ederek yetki yükseltme işlemi gerçekleştirmek için kullanılan bir araçtır. Bu açıklar, bir saldırganın Domain Controller üzerinde sistem hakları elde etmesine olanak tanır.

> **Önemli Not:** noPac yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **CVE-2021-42287 ve CVE-2021-42278 Zafiyet İstismarı:**
   - Bu güvenlik açıklarını birleştirerek Domain Admin yetkileri elde eder.
2. **Hedef Domain Controller’a Erişim Sağlama:**
   - Domain Controller üzerinde sistem seviyesinde erişim elde eder.
3. **Hızlı ve Etkili Çalışma:**
   - Zafiyet istismarını basit bir komutla gerçekleştirir.

---

## İndirme ve Çalıştırma

noPac aracı GitHub üzerinden indirilebilir:

- [noPac GitHub Sayfası](https://github.com/Ridter/noPac)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/Ridter/noPac.git
   cd noPac
   ```

2. **Gerekli Modülleri Kurun:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Python ile Çalıştırın:**
   ```bash
   python3 noPac.py <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-u` veya `--user`**
- Kullanıcı adını belirtir.

  **Kullanım:**
  ```bash
  python3 noPac.py -u username
  ```

### 2. **`-p` veya `--password`**
- Kullanıcı şifresini belirtir.

  **Kullanım:**
  ```bash
  python3 noPac.py -u username -p password123
  ```

### 3. **`-d` veya `--domain`**
- Hedef domain adını belirtir.

  **Kullanım:**
  ```bash
  python3 noPac.py -u username -p password123 -d example.local
  ```

### 4. **`--impersonate`**
- Taklit edilecek kullanıcıyı belirtir (örneğin Administrator).

  **Kullanım:**
  ```bash
  python3 noPac.py -u username -p password123 -d example.local --impersonate Administrator
  ```

### 5. **`-h` veya `--help`**
- Yardım mesajını görüntüler.

  **Kullanım:**
  ```bash
  python3 noPac.py -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Domain Admin Yetkisi Elde Etme
```bash
python3 noPac.py -u user -p Passw0rd! -d example.local --impersonate Administrator
```

### 2. Yardım Mesajını Görüntüleme
```bash
python3 noPac.py -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** noPac yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [noPac GitHub Sayfası](https://github.com/Ridter/noPac)
- [CVE-2021-42287 ve CVE-2021-42278 Hakkında Bilgi](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-42287)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
