# CheckPort.exe Kullanım Rehberi

## CheckPort.exe Nedir?

**CheckPort.exe**, ağ bağlantılarını ve port durumlarını kontrol etmek için kullanılan basit bir araçtır. Özellikle belirli bir IP adresinde ve portta bağlantı olup olmadığını hızlıca test etmek için kullanılır. Sistem yöneticileri, güvenlik uzmanları ve ağ mühendisleri tarafından ağ sorunlarını teşhis etmek ve port durumlarını doğrulamak için tercih edilir.

> **Önemli Not:** Bu araç yalnızca yetkili sistemlerde kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Port Durumu Kontrolü:**
   - Belirli bir IP ve portun açık mı kapalı mı olduğunu kontrol eder.
2. **Bağlantı Testi:**
   - Hedef sunucuya TCP bağlantısı gerçekleştirerek port üzerinden iletişim olup olmadığını test eder.
3. **Hızlı ve Hafif:**
   - Küçük boyutlu ve hızlı sonuç veren bir araçtır.

---

## İndirme ve Çalıştırma

CheckPort.exe, çeşitli güvenlik araçları koleksiyonlarında veya ağ yönetim araçlarında bulunabilir. Kullanılabilir bir sürüm için [GitHub](https://github.com) gibi kaynaklardan indirilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   CheckPort.exe’yi sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell Üzerinden Çalıştırma:**
   ```cmd
   CheckPort.exe <parametreler>
   ```

---

## Kullanım Parametreleri

Aşağıda CheckPort.exe’nin temel komutları ve parametreleri açıklanmıştır:

### 1. **`-ip`**
- Hedef IP adresini belirtir.

  **Kullanım:**
  ```cmd
  CheckPort.exe -ip <IP_Adresi>
  ```

  **Örnek:**
  ```cmd
  CheckPort.exe -ip 192.168.1.1
  ```

### 2. **`-port`**
- Kontrol edilecek port numarasını belirtir.

  **Kullanım:**
  ```cmd
  CheckPort.exe -port <Port_Numarası>
  ```

  **Örnek:**
  ```cmd
  CheckPort.exe -port 80
  ```

### 3. **`-timeout`**
- Zaman aşımı süresini (milisaniye cinsinden) belirler.

  **Kullanım:**
  ```cmd
  CheckPort.exe -timeout <Süre>
  ```

  **Örnek:**
  ```cmd
  CheckPort.exe -timeout 5000
  ```

### 4. **`-help`**
- Tüm komutlar ve parametreler hakkında bilgi sağlar.

  **Kullanım:**
  ```cmd
  CheckPort.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Belirli Bir IP ve Port Kontrolü
```cmd
CheckPort.exe -ip 192.168.1.1 -port 443
```

### 2. Zaman Aşımı Belirleyerek Kontrol
```cmd
CheckPort.exe -ip 10.0.0.5 -port 22 -timeout 3000
```

### 3. Yardım Mesajını Görüntüleme
```cmd
CheckPort.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** CheckPort.exe yalnızca yetkili kullanıcılar tarafından kullanılmalıdır.
- **Firewall Kuralları:** Eğer hedef port kapalı görünüyorsa, bu durum firewall kuralları nedeniyle olabilir.
- **Test Ortamı:** Üretim ortamında kullanmadan önce test ortamında çalıştırılması önerilir.

---

## Kaynaklar

- CheckPort.exe hakkında daha fazla bilgi için kullanma kılavuzlarını inceleyin.
- Ağ yönetim araçları hakkında bilgi almak için:
  - [Microsoft Docs](https://docs.microsoft.com/)
  - [GitHub](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
