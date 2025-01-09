# SharpWMI Kullanım Rehberi

## SharpWMI Nedir?

**SharpWMI**, Windows Management Instrumentation (WMI) işlevselliğinin çeşitli yönlerini uygulayan bir C# aracıdır. Yerel ve uzaktan WMI sorgularını, uzaktan WMI süreç oluşturmayı ve keyfi VBS kodlarını WMI olay abonelikleri üzerinden çalıştırmayı destekler. Ayrıca, uzaktan yöntemler için alternatif kimlik bilgileri de kullanılabilir.

> **Önemli Not:** SharpWMI yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Yerel ve Uzak WMI Sorguları:**
   - WMI sorguları aracılığıyla sistem bilgilerini toplar.
2. **Uzaktan Süreç Çalıştırma:**
   - `win32_process` ile uzak makinelere komutlar gönderir ve çalıştırır.
3. **VBS Kodu Çalıştırma:**
   - WMI üzerinden VBS kodlarını yürütür.
4. **Dosya Yükleme ve Çevresel Değişken Yönetimi:**
   - Uzak sistemlere dosya yükleme ve çevresel değişkenleri ayarlama imkânı sunar.

---

## İndirme ve Derleme

SharpWMI aracı GitHub üzerinden sağlanabilir:

- [SharpWMI GitHub Sayfası](https://github.com/GhostPack/SharpWMI)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/GhostPack/SharpWMI.git
   ```

2. **Derleme:**
   - Visual Studio 2015 veya üzeri bir IDE kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpWMI.exe` dosyasını elde edeceksiniz.

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpWMI.exe <action> [parametreler]
```

### Desteklenen İşlemler ve Parametreler

#### Yerel Sistem Sorgusu
Yerel sistem bilgilerini toplar:
```bash
SharpWMI.exe action=query query="select * from win32_service"
```

#### Uzak Sistem Sorgusu
Uzak bir sistemde WMI sorgusu çalıştırır:
```bash
SharpWMI.exe action=query computername=HOST query="select * from win32_service"
```

#### Giriş Yapmış Kullanıcıları Listeleme
Uzak bir sistemde oturum açmış kullanıcıları listeler:
```bash
SharpWMI.exe action=loggedon computername=HOST
```

#### Uzak Süreç Oluşturma
Bir uzak makinede komut çalıştırır:
```bash
SharpWMI.exe action=exec computername=HOST command="C:\\temp\\process.exe"
```

#### Dosya Yükleme
Bir uzak makineye dosya yükler:
```bash
SharpWMI.exe action=upload computername=HOST source="C:\\source\\file.exe" dest="C:\\temp\\dest-file.exe"
```

#### Çevresel Değişken Yönetimi
Bir çevresel değişkeni ayarlamak için:
```bash
SharpWMI.exe action=setenv name=VariableName value=VariableValue computername=HOST
```

Çevresel değişkeni silmek için:
```bash
SharpWMI.exe action=delenv name=VariableName computername=HOST
```

#### MSI Dosyası Yükleme
Bir uzak makineye MSI dosyası yükler:
```bash
SharpWMI.exe action=install computername=HOST path="C:\\temp\\installer.msi"
```

---

## Örnek Kullanım Senaryoları

1. **Yerel Sistem Süreçlerini Listeleme**:
   ```bash
   SharpWMI.exe action=query query="select * from win32_process"
   ```

2. **Uzak Makinede Komut Çalıştırma**:
   ```bash
   SharpWMI.exe action=exec computername=remote.testlab.local command="whoami" result=true amsi=disable
   ```

3. **Dosya Yükleme**:
   ```bash
   SharpWMI.exe action=upload computername=remote.testlab.local source="C:\\beacon.exe" dest="C:\\temp\\beacon.exe"
   ```

4. **MSI Dosyası Yükleme**:
   ```bash
   SharpWMI.exe action=install computername=remote.testlab.local path="C:\\temp\\installer.msi"
   ```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpWMI yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç, üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
