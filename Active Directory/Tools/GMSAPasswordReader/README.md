# GMSAPasswordReader Kullanım Rehberi

## GMSAPasswordReader Nedir?

**GMSAPasswordReader**, Group Managed Service Account (gMSA) hesaplarının parola blob'larını LDAP üzerinden okuyarak, bu verileri yeniden kullanım için hash'lere dönüştüren bir C# aracıdır. 

> **Önemli Not:** Bu araç, yalnızca yetkili test ortamlarında ve etik amaçlarla kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

- **Parola Blob'u Okuma:** Belirtilen gMSA hesabının parola blob'unu LDAP üzerinden okur.
- **Hash Dönüştürme:** Okunan parola verilerini NTLM/NTHash ve Kerberos anahtarlarına dönüştürür.

---

## Gereksinimler

- **.NET Framework 4.0 veya üzeri**
- **Windows İşletim Sistemi**

---

## İndirme ve Kurulum

GMSAPasswordReader aracını GitHub üzerinden edinebilirsiniz:

- [GMSAPasswordReader GitHub Sayfası](https://github.com/rvazarkar/GMSAPasswordReader)

### Kurulum Adımları

1. **Projeyi Klonlayın:**
   ```bash
   git clone https://github.com/rvazarkar/GMSAPasswordReader.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `GMSAPasswordReader.exe` dosyasını elde edeceksiniz.

---

## Kullanım

### Genel Kullanım

```bash
GMSAPasswordReader.exe --AccountName <GMSA_HESAP_ADI>
```

### Örnek Komut

Belirli bir gMSA hesabının parolasını ve ilgili hash değerlerini almak için:

```bash
GMSAPasswordReader.exe --AccountName myGMSAAccount
```

Bu komut, `myGMSAAccount` adlı gMSA hesabının mevcut ve önceki parolalarını okuyarak, bunları NTLM/NTHash ve Kerberos anahtarlarına dönüştürecektir.

---

## Önceki Çalışmalar ve Teşekkürler

Bu aracın geliştirilmesinde emeği geçenlere teşekkür ederiz:

- **Mark Gamache:** Parola yapılarının çözülmesindeki çalışmaları için.
- **Will Schroeder ve Benjamin Delpy:** Hash oluşturma kodları için.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
