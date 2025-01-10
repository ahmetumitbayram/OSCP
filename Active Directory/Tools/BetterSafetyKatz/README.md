# BetterSafetyKatz Kullanım Rehberi

## BetterSafetyKatz Nedir?

**BetterSafetyKatz**, Mimikatz aracının dinamik olarak GitHub üzerinden çekilen en son sürümünü çalıştırmak için kullanılan bir araçtır. Aracın temel amacı, Mimikatz’ı bellek içinde çalıştırırken tespit edilmesini önlemek için imzaları rastgeleleştirmektir. 

BetterSafetyKatz, güvenlik araştırmaları ve zafiyet testlerinde Mimikatz işlevselliğini dinamik bir şekilde sunar.

> **Önemli Not:** BetterSafetyKatz yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Dinamik Mimikatz İndirme:**
   - Mimikatz’ın en son sürümünü GitHub üzerinden dinamik olarak indirir.
2. **İmza Rastgeleleştirme:**
   - Windows Defender tarafından algılanmasını önlemek için imzaları rastgeleleştirir.
3. **Bellekte Çalıştırma:**
   - SharpSploit DInvoke ile Mimikatz’ı bellek içinde çalıştırır.

---

## Gereksinimler

- **.NET Framework 4.5 veya üzeri**
- **Windows İşletim Sistemi**

---

## İndirme ve Kurulum

BetterSafetyKatz aracı GitHub üzerinden sağlanabilir:

- [BetterSafetyKatz GitHub Sayfası](https://github.com/Flangvik/BetterSafetyKatz)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/Flangvik/BetterSafetyKatz.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `BetterSafetyKatz.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   BetterSafetyKatz.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
BetterSafetyKatz.exe [yol]
```

### Parametreler

- **Yol (Opsiyonel):**
  - Lokal veya uzaktaki bir ZIP dosyasının yolu. Eğer belirtilmezse, araç GitHub’dan son sürümü indirir.

---

## Örnek Komutlar

### GitHub Üzerinden Son Sürümü Çalıştırma
```bash
BetterSafetyKatz.exe
```

### Lokal Bir ZIP Dosyası ile Çalıştırma
```bash
BetterSafetyKatz.exe "C:\Araçlar\mimikatz_trunk.zip"
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** BetterSafetyKatz yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
