# PetitPotam.exe Kullanım Rehberi

## PetitPotam.exe Nedir?

**PetitPotam.exe**, Windows ortamında NTLM relay saldırılarını kolaylaştıran bir araçtır. Bu araç, Windows sistemlerinde Microsoft’un EFSRPC (Encrypting File System Remote Protocol) API’sini kullanarak kimlik doğrulama mekanizmalarını tetiklemek için tasarlanmıştır. Özellikle Active Directory Certificate Services (AD CS) yapılandırmalarını hedef alır.

> **Önemli Not:** PetitPotam.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **NTLM Relay Tetikleme:**
   - EFSRPC protokolü üzerinden kimlik doğrulama tetikler.
2. **Active Directory Saldırıları:**
   - AD CS yapılandırmalarını hedef alarak saldırı fırsatlarını değerlendirir.
3. **Zafiyet Analizi:**
   - NTLM relay için potansiyel açıları test eder.

---

## İndirme ve Çalıştırma

PetitPotam.exe genellikle güvenlik araştırma toplulukları tarafından sağlanır:

- [PetitPotam GitHub Sayfası](https://github.com/topotam)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   PetitPotam.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   PetitPotam.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **Hedef Makine Belirleme**
- NTLM kimlik doğrulama tetiklemek için hedef makineyi belirtir.

  **Kullanım:**
  ```cmd
  PetitPotam.exe -i <hedef_ip>
  ```

### 2. **Loglama Seçeneği**
- Çıktıları bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  PetitPotam.exe -i <hedef_ip> -o log.txt
  ```

### 3. **Yardım Mesajını Görüntüleme**
- Kullanım bilgilerini listeler.

  **Kullanım:**
  ```cmd
  PetitPotam.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hedef Makineye NTLM Relay Tetikleme
```cmd
PetitPotam.exe -i 192.168.1.10
```

### 2. Çıktıları Log Dosyasına Kaydetme
```cmd
PetitPotam.exe -i 192.168.1.10 -o attack_log.txt
```

### 3. Yardım Mesajını Görüntüleme
```cmd
PetitPotam.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** PetitPotam.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [PetitPotam GitHub Sayfası](https://github.com/topotam)
- [Microsoft NTLM Relay Koruması](https://learn.microsoft.com/en-us/windows-server/security/kerberos/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
