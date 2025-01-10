# Koh.exe Kullanım Rehberi

## Koh Nedir?

**Koh**, C# ile geliştirilmiş bir araç olup, Beacon Object File (BOF) desteğiyle kullanıcının oturum belirteçlerini (token) ve giriş oturumlarını hedef alarak bu materyalleri yakalamayı sağlar. Bu süreçte belirli oturum belirteçlerinin ve kimlik doğrulama materyallerinin ele geçirilmesi hedeflenir.

- **Geliştiriciler:** @HarmJ0y ve @tifkin_
- **Lisans:** BSD 3-Clause

## Özellikler

- **Token ve Oturum İzleme:** Yeni oturumları izler ve oturumlarla ilişkili belirteçleri toplar.
- **Filtreleme:** Belirli grup SID'lerine sahip oturumlar üzerinde işlem yapar.
- **Beacon Entegrasyonu:** Cobalt Strike Beacon ortamıyla tam uyumlu çalışır.

---

## Derleme

Koh.exe için önceden derlenmiş bir binary paylaşılmamaktadır. Aşağıdaki adımları izleyerek kendiniz derleyebilirsiniz:

### Gereksinimler

- **.NET Framework 4.7.2**
- **Visual Studio 2019 Community Edition** veya daha yeni bir sürüm

### Derleme Adımları

1. **Proje Dosyasını Açın:** `Koh.sln` dosyasını Visual Studio ile açın.
2. **Yayın Modunu Seçin:** Derleme modunu "Release" olarak ayarlayın.
3. **Derleyin:** Projeyi derleyin. Çıktılar `Koh.exe` ve `Koh.bin` olarak ana dizine kaydedilecektir.

---

## Kullanım

Koh.exe aşağıdaki temel komutlarla çalıştırılabilir:

```plaintext
Koh.exe <list | monitor | capture> [GroupSID...]
```

### Komutlar

- **list:** Mevcut giriş oturumlarını listeler.
- **monitor:** Yeni giriş oturumlarını izler.
- **capture:** Belirli oturumlar için belirteçleri toplar.
- **GroupSID:** Belirli grup SID'lerine sahip oturumları hedefler.

### Örnekler

#### Giriş Oturumlarını Listeleme

```bash
Koh.exe list
```

#### Yeni Oturumları İzleme

Belirli bir grup SID'i için izleme:

```bash
Koh.exe monitor S-1-5-21-937929760-3187473010-80948926-512
```

#### Belirteç Yakalama

```bash
Koh.exe capture
```

---

## BOF İstemcisi Kullanımı

Koh, Cobalt Strike Beacon ile kullanılabilir. BOF istemcisi `./Clients/BOF/` dizininde bulunur.

### Komutlar

- **koh list:** Yakalanan belirteçleri listeler.
- **koh groups LUID:** Belirli bir LUID için grup SID'lerini listeler.
- **koh impersonate LUID:** Belirli bir LUID ile oturum belirtecini taklit eder.
- **koh release LUID:** Belirli bir LUID ile ilişkilendirilmiş belirteci serbest bırakır.

---

## IOC'lar (Göstergeler)

Koh kullanımı sırasında aşağıdaki göstergeler tespit edilebilir:

- **Named Pipe:** `\\.\pipe\imposecost` adında bir named pipe kullanılır.
- **GUID:** `4d5350c8-7f8c-47cf-8cde-c752018af17e` benzersiz TypeLib GUID'si Koh için kullanılır.

---

## Mitigasyonlar

- **Protected Users Security Group:** Hassas kullanıcılar için bu grup kullanılmalıdır.
- **TokenLeakDetectDelaySecs:** Bu değerin bir süre (örneğin 30 saniye) olarak ayarlanması önerilir.

---

## Kaynaklar

- [Koh Projesi](https://github.com/GhostPack/Koh)
- [Koh: The Token Stealer](https://posts.specterops.io/koh-the-token-stealer)

Bu dokümantasyon, Koh.exe'nin kullanımı ve yetenekleri hakkında temel bilgileri sağlamaktadır. Daha fazla destek için GitHub sayfasını ziyaret edebilirsiniz.
