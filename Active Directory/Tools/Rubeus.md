# Rubeus.exe Kullanım Rehberi

## Rubeus.exe Nedir?

**Rubeus.exe**, Kerberos kimlik doğrulama protokolünü hedef alan, çeşitli saldırılar ve testler gerçekleştirmek için kullanılan bir Windows aracıdır. Bu araç, özellikle Active Directory ortamlarında Kerberos biletlerini analiz etmek, manipüle etmek ve istismar etmek için kullanılır. **Rubeus**, güvenlik uzmanlarına Kerberos protokolü ile ilgili zafiyetleri keşfetme imkanı sunar.

> **Önemli Not:** Rubeus.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **Kerberos Bilet Yönetimi:**
   - Kerberos biletlerini yakalama, listeleme, yenileme ve manipüle etme.
2. **Yetki Yükseltme:**
   - Kerberos TGS (Ticket Granting Service) biletlerini kullanarak yetki yükseltme işlemleri.
3. **Zafiyet Analizi:**
   - Active Directory ortamlarında Kerberos protokolü ile ilgili yapılandırma hatalarını analiz eder.

---

## İndirme ve Çalıştırma

Rubeus.exe genellikle GitHub üzerinden indirilebilir:

- [https://github.com/GhostPack/Rubeus](https://github.com/GhostPack/Rubeus)

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   Rubeus.exe dosyasını sisteminize indirin ve hedef bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırma:**
   ```cmd
   Rubeus.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`dump`**
- Mevcut sistemdeki Kerberos biletlerini döker.

  **Kullanım:**
  ```cmd
  Rubeus.exe dump
  ```

### 2. **`kerberoast`**
- Kerberoasting saldırısı başlatır ve Kerberos servis hesaplarının TGS biletlerini çıkarır.

  **Kullanım:**
  ```cmd
  Rubeus.exe kerberoast
  ```

### 3. **`s4u`**
- Service for User (S4U) işlevini kullanarak belirli bir kullanıcı için bilet alır.

  **Kullanım:**
  ```cmd
  Rubeus.exe s4u /user:TARGET_USER /rc4:HASH /impersonateuser:IMPERSONATE_USER
  ```

### 4. **`monitor`**
- Kerberos trafiğini izler ve yakalar.

  **Kullanım:**
  ```cmd
  Rubeus.exe monitor /interval:10
  ```

### 5. **`help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  Rubeus.exe help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Kerberos Biletlerini Listeleme
```cmd
Rubeus.exe dump
```

### 2. Kerberoasting Saldırısı Gerçekleştirme
```cmd
Rubeus.exe kerberoast
```

### 3. Belirli Bir Kullanıcı İçin Bilet Alma
```cmd
Rubeus.exe s4u /user:TARGET_USER /rc4:HASH /impersonateuser:IMPERSONATE_USER
```

### 4. Kerberos Trafiğini İzleme
```cmd
Rubeus.exe monitor /interval:10
```

### 5. Yardım Mesajını Görüntüleme
```cmd
Rubeus.exe help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Rubeus.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [Rubeus GitHub Sayfası](https://github.com/GhostPack/Rubeus)
- [Kerberos Protokolü Hakkında](https://learn.microsoft.com/en-us/windows-server/security/kerberos/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
