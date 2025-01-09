# KrbRelayUp.exe Kullanım Rehberi

## KrbRelayUp.exe Nedir?

**KrbRelayUp.exe**, Windows ortamlarında Kerberos protokolünü hedef alarak yetki yükseltme (privilege escalation) saldırıları gerçekleştirmek için kullanılan bir araçtır. Bu araç, Kerberos kimlik doğrulama protokolündeki zafiyetlerden faydalanarak kullanıcı oturumunu SYSTEM yetkisine yükseltmeyi amaçlar. **KrbRelayUp**, özellikle Active Directory ortamlarında Kerberos ile ilgili güvenlik açıklarını analiz etmek ve istismar etmek için tasarlanmıştır.

> **Önemli Not:** KrbRelayUp.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kerberos Bileti Yönlendirme (Relay):**
   - Kerberos kimlik doğrulama süreçlerini manipüle eder.
2. **Yetki Yükseltme:**
   - Düşük yetkili kullanıcı oturumlarından SYSTEM yetkisine geçiş sağlar.
3. **Hızlı ve Kolay Kullanım:**
   - Basit parametrelerle etkili sonuçlar sunar.

---

## İndirme ve Çalıştırma

KrbRelayUp.exe, genellikle güvenlik toplulukları tarafından sağlanır. Araç, [GitHub](https://github.com) gibi platformlardan indirilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   KrbRelayUp.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   KrbRelayUp.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-spn`**
- Hedef SPN (Service Principal Name) adresini belirtir.

  **Kullanım:**
  ```cmd
  KrbRelayUp.exe -spn HOST/target.domain.local
  ```

### 2. **`-target`**
- Hedef makineyi belirtir.

  **Kullanım:**
  ```cmd
  KrbRelayUp.exe -target target.domain.local
  ```

### 3. **`-relay`**
- Kerberos bileti yönlendirme işlemini etkinleştirir.

  **Kullanım:**
  ```cmd
  KrbRelayUp.exe -relay
  ```

### 4. **`-output`**
- Çıktıyı belirtilen bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  KrbRelayUp.exe -output C:\Logs\krbrelayup_output.txt
  ```

### 5. **`-help`**
- Araç kullanımına ilişkin yardım mesajını görüntüler.

  **Kullanım:**
  ```cmd
  KrbRelayUp.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kerberos Bileti Yönlendirme
```cmd
KrbRelayUp.exe -spn HOST/target.domain.local -relay
```

### 2. Yetki Yükseltme ve Çıktıyı Kaydetme
```cmd
KrbRelayUp.exe -target target.domain.local -output C:\Logs\krbrelayup_output.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
KrbRelayUp.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** KrbRelayUp.exe yalnızca yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Sistem Logları:** Araç, çalıştırıldığında sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Kerberos ve Kimlik Doğrulama Protokolleri](https://learn.microsoft.com/en-us/windows-server/security/kerberos/)
- [GitHub'da Güvenlik Araçları](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
