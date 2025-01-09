# RestrictedAdmin.exe Kullanım Rehberi

## RestrictedAdmin.exe Nedir?

**RestrictedAdmin.exe**, Windows ortamlarında RDP (Remote Desktop Protocol) bağlantılarını daha güvenli bir şekilde test etmek ve Restricted Admin Mode özelliğini analiz etmek için kullanılan bir araçtır. Restricted Admin Mode, kullanıcı kimlik bilgilerini istemci tarafında saklamadan uzak masaüstü bağlantıları kurmaya olanak tanır. **RestrictedAdmin.exe**, bu özelliği test etmek ve zafiyetlerini belirlemek için tasarlanmıştır.

> **Önemli Not:** RestrictedAdmin.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **RDP Bağlantı Güvenliği:**
   - Restricted Admin Mode’un etkinliğini analiz eder.
2. **Kimlik Bilgisi Koruması:**
   - Kimlik bilgilerini istemci tarafında saklamadan bağlantı sağlar.
3. **Zafiyet Analizi:**
   - Restricted Admin Mode yapılandırmalarındaki olası açıkları test eder.

---

## İndirme ve Çalıştırma

RestrictedAdmin.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır ve GitHub gibi kaynaklardan edinilebilir.

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   RestrictedAdmin.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   RestrictedAdmin.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-r` veya `--rdp`**
- Restricted Admin Mode kullanarak RDP bağlantısı başlatır.

  **Kullanım:**
  ```cmd
  RestrictedAdmin.exe -r <hedef_ip>
  ```

### 2. **`-test`**
- Restricted Admin yapılandırmalarını test eder ve raporlar.

  **Kullanım:**
  ```cmd
  RestrictedAdmin.exe -test
  ```

### 3. **`-h` veya `--help`**
- Kullanım bilgilerini görüntüler.

  **Kullanım:**
  ```cmd
  RestrictedAdmin.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Restricted Admin Mode ile RDP Bağlantısı Başlatma
```cmd
RestrictedAdmin.exe -r 192.168.1.10
```

### 2. Restricted Admin Yapılandırmasını Test Etme
```cmd
RestrictedAdmin.exe -test
```

### 3. Yardım Mesajını Görüntüleme
```cmd
RestrictedAdmin.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** RestrictedAdmin.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Windows Restricted Admin Mode Hakkında](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/)
- [RestrictedAdmin GitHub Sayfası](https://github.com)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
