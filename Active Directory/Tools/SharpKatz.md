# SharpKatz.exe Kullanım Rehberi

## SharpKatz.exe Nedir?

**SharpKatz.exe**, Windows ortamında kimlik bilgilerini çıkarmak ve analiz etmek için kullanılan bir araçtır. Mimikatz tabanlı olan bu araç, Local Security Authority Subsystem Service (LSASS) belleğinden hassas bilgileri çekerek, kimlik doğrulama işlemleri üzerinde analiz yapılmasına olanak tanır.

> **Önemli Not:** SharpKatz.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **LSASS Bellek Analizi:**
   - LSASS belleğinden kimlik bilgilerini ve diğer hassas verileri çıkarır.
2. **Mimikatz Özellikleri:**
   - Mimikatz'in yeteneklerini bir .NET uygulamasında sunar.
3. **Hafif ve Hızlı:**
   - Minimum sistem kaynakları kullanır.

---

## İndirme ve Çalıştırma

SharpKatz.exe genellikle GitHub gibi kaynaklardan sağlanır:

- [SharpKatz GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpKatz.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpKatz.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`dump`**
- LSASS belleğinden kimlik bilgilerini döker.

  **Kullanım:**
  ```cmd
  SharpKatz.exe dump
  ```

### 2. **`logonpasswords`**
- Oturum açma kimlik bilgilerini çıkarır.

  **Kullanım:**
  ```cmd
  SharpKatz.exe logonpasswords
  ```

### 3. **`-o` veya `--output`**
- Çıktıyı bir dosyaya kaydeder.

  **Kullanım:**
  ```cmd
  SharpKatz.exe dump -o credentials.txt
  ```

### 4. **`-h` veya `--help`**
- Kullanım bilgilerini ve mevcut seçenekleri listeler.

  **Kullanım:**
  ```cmd
  SharpKatz.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. LSASS Belleğinden Kimlik Bilgilerini Çıkarma
```cmd
SharpKatz.exe dump
```

### 2. Oturum Açma Kimlik Bilgilerini Listeleme
```cmd
SharpKatz.exe logonpasswords
```

### 3. Çıktıyı Dosyaya Kaydetme
```cmd
SharpKatz.exe dump -o credentials.txt
```

### 4. Yardım Mesajını Görüntüleme
```cmd
SharpKatz.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpKatz.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpKatz GitHub Sayfası](https://github.com)
- [Windows LSASS ve Güvenlik](https://learn.microsoft.com/en-us/windows/security/identity-protection/lsass/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
