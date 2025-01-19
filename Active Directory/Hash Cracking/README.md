### Hashcat Modlarıyla Hash Kırma Rehberi

**Hashcat**, hash kırma işlemleri için kullanılan güçlü bir araçtır. Farklı hash türlerini kırmak için doğru modları ve parametreleri kullanmak gerekir. Bu rehberde, çeşitli hash türleri için Hashcat modları ve kullanım örnekleri sunulmaktadır.

---

## **Hashcat Kullanımı: Genel Format**
```bash
hashcat -m <mod> -a <attack_mode> <hash_file> <wordlist_or_mask>
```

### **Parametreler**
- **`-m`**: Hash türünü belirler (örneğin, NTLM için 1000, Kerberos için 13100).
- **`-a`**: Saldırı modunu belirler.
  - `0`: Dictionary Attack
  - `1`: Combination Attack
  - `3`: Mask Attack (brute-force)
  - `6`: Dictionary + Mask
  - `7`: Mask + Dictionary

---

## **1. NTLM Hash Kırma**
- **Mod**: `1000`
- **Hash Formatı**: `aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c`
- **Komut**:
  ```bash
  hashcat -m 1000 -a 0 hashes.txt wordlist.txt
  ```
- **Örnek**: Kullanıcı şifresi `Password123` ise hashcat, bunu hızlıca çözebilir çünkü NTLM MD4 tabanlıdır.

---

## **2. Kerberos TGS (Ticket Granting Service) Hash Kırma**
- **Mod**: `13100`
- **Hash Formatı**:
  ```
  $krb5tgs$23$*user$realm$SPN*$abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890
  ```
- **Komut**:
  ```bash
  hashcat -m 13100 -a 0 kerberos_hashes.txt wordlist.txt
  ```
- **Not**: Kerberos hash’lerinin kırılması, hedefte servis hesabı ve parolalarına erişim sağlar.

---

## **3. NetNTLMv1 Hash Kırma**
- **Mod**: `5500`
- **Hash Formatı**: 
  ```
  USER::DOMAIN:1122334455667788:99AABBCCDDEEFF:112233445566778899AABBCCDDEEFF1122:0102030405060708090A0B0C0D0E0F
  ```
- **Komut**:
  ```bash
  hashcat -m 5500 -a 0 netntlmv1_hashes.txt wordlist.txt
  ```

---

## **4. NetNTLMv2 Hash Kırma**
- **Mod**: `5600`
- **Hash Formatı**:
  ```
  USER::DOMAIN:1122334455667788:0102030405060708090A0B0C0D0E0F:abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890
  ```
- **Komut**:
  ```bash
  hashcat -m 5600 -a 0 netntlmv2_hashes.txt wordlist.txt
  ```

---

## **5. Kerberos AS-REP Roasting (Type 23)**
- **Mod**: `18200`
- **Hash Formatı**:
  ```
  $krb5asrep$23$<user>@<realm>:<cipher_text>
  ```
- **Komut**:
  ```bash
  hashcat -m 18200 -a 0 kerberos_asrep_hashes.txt wordlist.txt
  ```

---

## **6. MD5 Hash Kırma**
- **Mod**: `0`
- **Hash Formatı**: `098f6bcd4621d373cade4e832627b4f6` (örnek şifre: `test`)
- **Komut**:
  ```bash
  hashcat -m 0 -a 0 md5_hashes.txt wordlist.txt
  ```

---

## **7. SHA1 Hash Kırma**
- **Mod**: `100`
- **Hash Formatı**: `5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8` (örnek şifre: `password`)
- **Komut**:
  ```bash
  hashcat -m 100 -a 0 sha1_hashes.txt wordlist.txt
  ```

---

## **8. WPA/WPA2 PSK Hash Kırma (Wi-Fi)**
- **Mod**: `22000` (PMKID veya .hccapx formatı)
- **Komut**:
  ```bash
  hashcat -m 22000 -a 0 wifi_hash.hc22000 wordlist.txt
  ```

---

## **9. SHA256 Crypt (Unix)**
- **Mod**: `7400`
- **Hash Formatı**: `$5$rounds=5000$salt$hash`
- **Komut**:
  ```bash
  hashcat -m 7400 -a 0 sha256_hashes.txt wordlist.txt
  ```

---

## **10. SHA512 Crypt (Unix)**
- **Mod**: `1800`
- **Hash Formatı**: `$6$salt$hash`
- **Komut**:
  ```bash
  hashcat -m 1800 -a 0 sha512_hashes.txt wordlist.txt
  ```

---

## **11. bcrypt (Blowfish) Hash Kırma**
- **Mod**: `3200`
- **Hash Formatı**: `$2a$10$somesalt$hash`
- **Komut**:
  ```bash
  hashcat -m 3200 -a 0 bcrypt_hashes.txt wordlist.txt
  ```

---

## **12. HMAC-SHA1**
- **Mod**: `150`
- **Komut**:
  ```bash
  hashcat -m 150 -a 0 hmac_sha1_hashes.txt wordlist.txt
  ```

---

## **13. HMAC-SHA256**
- **Mod**: `1450`
- **Komut**:
  ```bash
  hashcat -m 1450 -a 0 hmac_sha256_hashes.txt wordlist.txt
  ```

---

## **14. Ethereum Wallet Kırma**
- **Mod**: `15700`
- **Komut**:
  ```bash
  hashcat -m 15700 -a 0 ethereum_wallet_hashes.txt wordlist.txt
  ```

---

### **İpuçları ve Ekstra Bilgiler**
1. **Mask Attack (Brute-force)**:
   - Örnek:
     ```bash
     hashcat -m 1000 -a 3 hashes.txt ?d?d?d?d?d?d?d?d
     ```
   - `?d`: Sayı, `?l`: Küçük harf, `?u`: Büyük harf, `?s`: Özel karakter.

2. **Benchmark Testi**:
   - Hashcat performansını test etmek için:
     ```bash
     hashcat -b
     ```

3. **Hızlandırma ve İşlemci Kullanımı**:
   - GPU kullanımı: `--force` bayrağı ile GPU'nuzu zorlayabilirsiniz.
   - İşlemci çekirdeklerini sınırlama: `--cpu-affinity` kullanabilirsiniz.

4. **Hash Formatını Doğrulama**:
   - Hash formatını anlamak için: https://hashcat.net/wiki/doku.php?id=example_hashes adresinden destek alabilirsiniz.

---



Hashcat modlarının ve saldırı türlerinin detaylı açıklamalarıyla artık farklı hash türlerini kırmaya hazırsınız! Yardım veya daha fazla detay isterseniz, lütfen belirtin. 😊
