# Certify Kullanım Rehberi

## Certify Nedir?

**Certify**, Active Directory Certificate Services (AD CS) üzerindeki yanlış yapılandırmaları tespit etmek ve kötüye kullanmak için geliştirilmiş bir C# aracıdır. Bu araç, AD CS ile ilgili güvenlik araştırmaları için kapsamlı işlevler sunar.

> **Önemli Not:** Certify yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **CA ve Sertifika Şablonu Taraması:**
   - Domain içerisindeki tüm Sertifika Yetkililerini (CA) ve etkin sertifika şablonlarını listeler.
2. **Yanlış Yapılandırma Tespiti:**
   - Güvenlik açıkları olan şablonları otomatik olarak belirler.
3. **Sertifika Talebi ve Kullanımı:**
   - Mevcut kullanıcı bağlamında sertifika talep etme ve alternatif adlarla (SAN) çalışma yeteneği.

---

## Gereksinimler

- **.NET Framework 4.0 veya üzeri**
- **Windows İşletim Sistemi**

---

## İndirme ve Kurulum

Certify aracı GitHub üzerinden sağlanabilir:

- [Certify GitHub Sayfası](https://github.com/GhostPack/Certify)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/GhostPack/Certify.git
   ```

2. **Derleme:**
   - Visual Studio 2019 veya üzeri kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `Certify.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   Certify.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
Certify.exe [komut] [parametreler]
```

### Örnek Komutlar

#### Tüm Sertifika Yetkililerini (CA) Listeleme
```bash
Certify.exe cas
```

#### Etkin Sertifika Şablonlarını Listeleme
```bash
Certify.exe find
```

#### Güvenlik Açığı Olan Şablonları Bulma
```bash
Certify.exe find /vulnerable
```

#### Mevcut Kullanıcı Bağlamında Sertifika Talep Etme
```bash
Certify.exe request /ca:SERVER\CA_NAME /template:TEMPLATE_NAME
```

#### Alternatif Ad (SAN) ile Sertifika Talebi
```bash
Certify.exe request /ca:SERVER\CA_NAME /template:TEMPLATE_NAME /altname:USERNAME
```

#### Mevcut Bir Sertifikayı İndirme
```bash
Certify.exe download /ca:SERVER\CA_NAME /id:CERTIFICATE_ID
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Certify yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
