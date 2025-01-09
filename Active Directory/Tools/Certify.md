# Certify.exe Kullanım Rehberi

## Certify.exe Nedir?

**Certify.exe**, Windows ortamlarında sertifika yetkilendirme (Certificate Authority - CA) yapılandırmalarını analiz etmek ve potansiyel zafiyetleri tespit etmek için kullanılan bir araçtır. Active Directory Certificate Services (AD CS) ortamlarını hedef alarak yanlış yapılandırmalar ve zafiyetlerden yararlanmak için bilgi toplar. 

Bu araç, özellikle güvenlik araştırmacıları ve saldırganlar tarafından kullanılarak yetki yükseltme ve lateral movement (yanal hareket) gibi senaryoları test etmek için değerlendirilir.

> **Önemli Not:** Certify.exe yalnızca yetkili sistemlerde ve etik kullanım amaçlı çalıştırılmalıdır. Aksi takdirde yasa dışı olabilir.

---

## Ana Özellikleri

1. **Sertifika Şablonlarını (Templates) Listeleme ve Analiz:**
   - Mevcut CA şablonlarını analiz eder.
2. **Yanlış Yapılandırmaların Tespiti:**
   - Sertifika kayıt (enrollment) izinlerini analiz eder.
3. **Sertifika Yetki Zincirlerini (Certificate Chain) Sorgulama:**
   - Mevcut sertifikaların yetki zincirlerini denetler.
4. **Etki Alanı (Domain) Kullanıcıları Üzerinde Sertifika Yetkilerini Kontrol Etme:**
   - Hangi kullanıcıların hangi haklara sahip olduğunu gösterir.

---

## İndirme ve Çalıştırma

Certify.exe, [SpecterOps](https://github.com/GhostPack/Certify) tarafından geliştirilmiştir. Aşağıdaki bağlantıdan indirebilirsiniz:

- [https://github.com/GhostPack/Certify](https://github.com/GhostPack/Certify)

### Çalıştırma Adımları

1. **İndir ve Hazırla:**
   Certify.exe’yi hedef sisteme indirin veya transfer edin.

2. **PowerShell veya CMD ile Çalıştırma:**
   ```cmd
   Certify.exe <parametreler>
   ```

---

## Kullanım Parametreleri

Aşağıda Certify.exe’nin temel komutları ve parametreleri açıklanmıştır:

### 1. **`find`**
- Mevcut sertifika yetkilendirme yapılandırmalarını ve şablonlarını listeler.

  **Kullanım:**
  ```cmd
  Certify.exe find
  ```

### 2. **`find /vulnerable`**
- Yanlış yapılandırmaları ve zafiyet içeren şablonları tespit eder.

  **Kullanım:**
  ```cmd
  Certify.exe find /vulnerable
  ```

### 3. **`request`**
- Bir sertifika talebinde bulunur.

  **Kullanım:**
  ```cmd
  Certify.exe request /template:<TemplateName>
  ```

  **Parametreler:**
  - `/template`: Hedef alınacak şablon adı.

### 4. **`list`**
- Mevcut CA’leri ve sertifika şablonlarını detaylı bir şekilde listeler.

  **Kullanım:**
  ```cmd
  Certify.exe list
  ```

### 5. **`chain`**
- Sertifikaların yetki zincirlerini görüntüler.

  **Kullanım:**
  ```cmd
  Certify.exe chain
  ```

### 6. **`help`**
- Tüm komutları ve parametreleri gösterir.

  **Kullanım:**
  ```cmd
  Certify.exe help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Yanlış Yapılandırılmış Şablonları Bulma
```cmd
Certify.exe find /vulnerable
```

### 2. Mevcut Şablonları Listeleme
```cmd
Certify.exe list
```

### 3. Sertifika Yetki Zincirini Görüntüleme
```cmd
Certify.exe chain
```

### 4. Şablon Kullanarak Sertifika Talebi
```cmd
Certify.exe request /template:UserTemplate
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Certify.exe yalnızca Active Directory yöneticileri veya güvenlik araştırmacıları tarafından kullanılmalıdır.
- **Loglama:** Certify.exe’nin çalıştırılması sistem loglarına kaydedilir. Dikkatli olun.
- **Test Ortamı:** İlk kez çalıştırmadan önce test ortamında denenmesi önerilir.

---

## Kaynaklar

- [Resmi GitHub Sayfası](https://github.com/GhostPack/Certify)
- [Active Directory Certificate Services (AD CS) Zafiyetleri](https://specterops.io/blog/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
