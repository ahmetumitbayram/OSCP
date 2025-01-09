# KrbRelay.exe Kullanım Rehberi

## KrbRelay.exe Nedir?

**KrbRelay.exe**, Windows ortamında Kerberos kimlik doğrulama protokolünü hedef alarak kimlik bilgisi tabanlı saldırılar gerçekleştirmek için kullanılan bir araçtır. Kerberos bileti yetkilendirme hatalarını veya zafiyetlerini kullanarak yetki yükseltme ve kimlik bilgisi ele geçirme gibi işlemler gerçekleştirebilir. Araç, Active Directory ortamlarında Kerberos protokolüyle ilgili güvenlik zafiyetlerini araştırmak için idealdir.

> **Önemli Not:** KrbRelay.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kerberos Bileti Yönlendirme (Relay):**
   - Kerberos kimlik doğrulama süreçlerini manipüle eder.
2. **Yetki Yükseltme:**
   - Hedef sistemde kullanıcıdan SYSTEM seviyesine yetki yükseltme işlemleri gerçekleştirir.
3. **Kimlik Bilgisi Ele Geçirme:**
   - Kerberos biletlerini ve kimlik bilgilerini yakalar ve çıkarır.

---

## İndirme ve Çalıştırma

KrbRelay.exe, genellikle güvenlik toplulukları tarafından geliştirilen bir araçtır ve [GitHub](https://github.com) gibi kaynaklardan indirilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   KrbRelay.exe dosyasını indirin ve hedef sisteme kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   KrbRelay.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-spn`**
- Hedef SPN (Service Principal Name) adresini belirtir.

  **Kullanım:**
  ```cmd
  KrbRelay.exe -spn HOST/target.domain.local
  ```

### 2. **`-target`**
- Hedef makineyi belirtir.

  **Kullanım:**
  ```cmd
  KrbRelay.exe -target target.domain.local
  ```

### 3. **`-forceauth`**
- Kimlik doğrulama sürecini zorla başlatır.

  **Kullanım:**
  ```cmd
  KrbRelay.exe -forceauth
  ```

### 4. **`-output`**
- Çıktıyı bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  KrbRelay.exe -output C:\Logs\krbrelay_output.txt
  ```

### 5. **`-help`**
- Araç ile ilgili yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  KrbRelay.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kerberos Bileti Yönlendirme
```cmd
KrbRelay.exe -spn HOST/target.domain.local -target target.domain.local
```

### 2. Çıktıyı Dosyaya Kaydetme
```cmd
KrbRelay.exe -spn HOST/target.domain.local -output C:\Logs\krbrelay_output.txt
```

### 3. Kimlik Doğrulama Sürecini Zorla Başlatma
```cmd
KrbRelay.exe -forceauth
```

### 4. Yardım Mesajını Görüntüleme
```cmd
KrbRelay.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** KrbRelay.exe yalnızca güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Sistem Logları:** Araç çalıştırıldığında sistem loglarına kaydedilebilir. Gizlilik ve yasalara uyum önemlidir.

---

## Kaynaklar

- [Kerberos Hakkında Microsoft Docs](https://learn.microsoft.com/en-us/windows-server/security/kerberos/)
- [GitHub'da Güvenlik Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
