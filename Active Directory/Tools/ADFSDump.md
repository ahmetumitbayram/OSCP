# ADFSDump Kullanım Rehberi

## ADFSDump.exe Nedir?

**ADFSDump.exe**, Active Directory Federasyon Hizmetleri (ADFS) yapılandırmalarını incelemek ve çıkarımlar yapmak için kullanılan bir araçtır. ADFSDump, özellikle güvenlik profesyonelleri ve saldırganlar tarafından ADFS ortamlarını analiz etmek, yapılandırma hatalarını tespit etmek ve hassas bilgileri elde etmek amacıyla kullanılır.

> **Önemli Not:** ADFSDump yalnızca yetkili sistemlerde ve etik amaçlarla kullanılmalıdır. Aksi takdirde yasa dışı sonuçlara yol açabilir.

---

## Ana Özellikleri

1. **ADFS Yapılandırmalarını Dökme:**
   - Token Signing ve Token Decryption sertifikalarını çıkarır.
   - Relying Party Trust (RPT) bilgilerini listeler.
2. **Relying Party Trust (RPT) Analizi:**
   - Uygulamaların erişim izinlerini kontrol eder.
3. **Gizli Anahtarları ve Sertifikaları İnceleme:**
   - Token şifreleme anahtarlarını döker.
4. **Kimlik Doğrulama Yöntemlerini Listeleme:**
   - Kullanılan kimlik doğrulama mekanizmalarını gösterir.

---

## İndirme ve Çalıştırma

ADFSDump, GitHub üzerinde bulunabilir:

- [https://github.com/dirkjanm/adfsdump](https://github.com/dirkjanm/adfsdump)

### Çalıştırma Adımları

1. **İndir ve Ayıkla:**
   ```bash
   git clone https://github.com/dirkjanm/adfsdump.git
   cd adfsdump
   ```
2. **Çalıştır:**
   Python ya da PowerShell kullanarak aracı çalıştırabilirsiniz.
   ```cmd
   ADFSDump.exe
   ```

---

## Kullanım Parametreleri

Aşağıda ADFSDump'ın temel komutları ve parametreleri açıklanmıştır.

### 1. **`--list-rpt`**
- Relying Party Trust (RPT) yapılandırmalarını döker.

  ```cmd
  ADFSDump.exe --list-rpt
  ```
  **Açıklama:** ADFS sunucusunda yapılandırılmış tüm RPT bilgilerini listeler.

### 2. **`--export-certs`**
- Token Signing ve Token Decryption sertifikalarını dışa aktarır.

  ```cmd
  ADFSDump.exe --export-certs
  ```
  **Not:** Bu sertifikalar, token manipülasyonu için kullanılabilir.

### 3. **`--auth-methods`**
- Kullanılan kimlik doğrulama yöntemlerini listeler.

  ```cmd
  ADFSDump.exe --auth-methods
  ```
  **Örnek Çıktı:** NTLM, Kerberos, Forms Authentication gibi yöntemler.

### 4. **`--export-keys`**
- Token şifreleme ve imzalama anahtarlarını döker.

  ```cmd
  ADFSDump.exe --export-keys
  ```
  **Uyarı:** Bu anahtarların yetkisiz kullanımı güvenlik sorunlarına yol açabilir.

### 5. **`--dump-config`**
- ADFS yapılandırma dosyasını detaylı olarak döker.

  ```cmd
  ADFSDump.exe --dump-config
  ```

### 6. **`--help`**
- Tüm kullanılabilir komutları ve parametreleri gösterir.

  ```cmd
  ADFSDump.exe --help
  ```

---

## Örnek Kullanım Senaryoları

### 1. RPT Listesini Görüntüleme
```cmd
ADFSDump.exe --list-rpt
```

### 2. Sertifikaların ve Anahtarların Dışa Aktarılması
```cmd
ADFSDump.exe --export-certs
ADFSDump.exe --export-keys
```

### 3. Yapılandırmanın Detaylı İncelenmesi
```cmd
ADFSDump.exe --dump-config
```

### 4. Kimlik Doğrulama Yöntemlerini Listeleme
```cmd
ADFSDump.exe --auth-methods
```

---

## Güvenlik ve Önlemler

- ADFSDump yalnızca test ortamlarında veya izninizin olduğu sistemlerde kullanılmalıdır.
- ADFS yapılandırmalarını dökerken hassas bilgilerin ifşa olmaması için dikkatli olun.
- Sistem yöneticileri, ADFS yapılandırmalarında gereksiz izinleri ve zayıflıkları gidermelidir.

---

## Kaynaklar

- [Resmi GitHub Sayfası](https://github.com/dirkjanm/adfsdump)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
