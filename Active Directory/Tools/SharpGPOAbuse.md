# SharpGPOAbuse.exe Kullanım Rehberi

## SharpGPOAbuse.exe Nedir?

**SharpGPOAbuse.exe**, Active Directory ortamında Grup İlkesi Nesnelerini (Group Policy Objects - GPO) kötüye kullanarak yetki yükseltme saldırıları gerçekleştirmek için kullanılan bir araçtır. Bu araç, bir GPO’nun izinlerini değiştirerek hedef makine üzerinde komut yürütmeyi sağlar ve genellikle sistem yöneticisi haklarını ele geçirmek için kullanılır.

> **Önemli Not:** SharpGPOAbuse.exe yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Ana Özellikleri

1. **GPO Manipülasyonu:**
   - Grup İlkesi Nesnelerinde yetki değişiklikleri yapar.
2. **Komut Yürütme:**
   - Hedef makine üzerinde yetkili komut çalıştırmayı sağlar.
3. **Hızlı ve Hafif:**
   - Minimal bağımlılıkla etkili sonuçlar sunar.

---

## İndirme ve Çalıştırma

SharpGPOAbuse.exe GitHub üzerinden indirilebilir:

- [SharpGPOAbuse GitHub Sayfası](https://github.com)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   SharpGPOAbuse.exe dosyasını sisteminize indirin ve uygun bir dizine kaydedin.

2. **CMD veya PowerShell ile Çalıştırın:**
   ```cmd
   SharpGPOAbuse.exe <parametreler>
   ```

---

## Kullanım Parametreleri

### 1. **`-gpo`**
- Hedef GPO’nun adını belirtir.

  **Kullanım:**
  ```cmd
  SharpGPOAbuse.exe -gpo "Default Domain Policy"
  ```

### 2. **`-add`**
- GPO’ya komut ekler.

  **Kullanım:**
  ```cmd
  SharpGPOAbuse.exe -gpo "Default Domain Policy" -add "cmd.exe /c whoami"
  ```

### 3. **`-remove`**
- GPO’dan eklenmiş bir komutu kaldırır.

  **Kullanım:**
  ```cmd
  SharpGPOAbuse.exe -gpo "Default Domain Policy" -remove
  ```

### 4. **`-help`**
- Kullanılabilir tüm komutları ve parametreleri listeler.

  **Kullanım:**
  ```cmd
  SharpGPOAbuse.exe -help
  ```

---

## Örnek Kullanım Senaryoları

### 1. Hedef GPO’ya Komut Eklemek
```cmd
SharpGPOAbuse.exe -gpo "Default Domain Policy" -add "cmd.exe /c whoami"
```

### 2. Eklenmiş Komutu GPO’dan Kaldırmak
```cmd
SharpGPOAbuse.exe -gpo "Default Domain Policy" -remove
```

### 3. Yardım Mesajını Görüntüleme
```cmd
SharpGPOAbuse.exe -help
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpGPOAbuse.exe yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamlarında çalıştırılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

## Kaynaklar

- [SharpGPOAbuse GitHub Sayfası](https://github.com)
- [Windows Group Policy Management](https://learn.microsoft.com/en-us/windows-server/identity/)

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
