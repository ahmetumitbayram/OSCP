# SharpRDP Kullanım Rehberi

## SharpRDP Nedir?

**SharpRDP**, Remote Desktop Protocol (RDP) kullanarak kimlik doğrulamalı komut yürütme işlemleri gerçekleştirmek için tasarlanmış bir .NET konsol uygulamasıdır. Bu araç, RDP üzerinden hedef sistemlere erişim sağlayarak yanal hareket ve yetki yükseltme gibi işlemler için kullanılabilir.

> **Önemli Not:** SharpRDP yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **RDP Bağlantısı ve Komut Yürütme:**
   - Hedef sistemlere RDP üzerinden erişim sağlar ve komut çalıştırır.
2. **Kısıtlı Yönetici Modu Desteği:**
   - Kısıtlı yönetici modunda çalıştırılabilir.
3. **Ağ Düzeyi Kimlik Doğrulama (NLA):**
   - NLA ile güvenli bağlantı sağlar.
4. **Gelişmiş Seçenekler:**
   - Task Manager veya Run Dialog ile komutları yükseltilmiş şekilde çalıştırabilir.

---

## İndirme ve Derleme

SharpRDP aracı GitHub üzerinden sağlanabilir:

- [SharpRDP GitHub Sayfası](https://github.com/0xthirteen/SharpRDP)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/0xthirteen/SharpRDP.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpRDP.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpRDP.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpRDP.exe computername=<hedef> command=<komut> [opsiyonel_parametreler]
```

### Örnek Komutlar

#### Standart RDP Bağlantısı ve Komut Çalıştırma
```bash
SharpRDP.exe computername=target.domain command="C:\Temp\file.exe" username=domain\user password=password
```

#### Komutu cmd veya PowerShell Alt Süreci Olarak Çalıştırma
```bash
SharpRDP.exe computername=target.domain command="C:\Temp\file.exe" exec=cmd
```

#### Kısıtlı Yönetici Modu Kullanma
```bash
SharpRDP.exe computername=target.domain command="C:\Temp\file.exe"
```

#### Disk Bağlantısı ile Çalıştırma
```bash
SharpRDP.exe computername=domain.target command="\\tsclient\C\Temp\file.exe" connectdrive=true
```

#### Task Manager ile Yükseltilmiş Komut Çalıştırma
```bash
SharpRDP.exe computername=domain.target command="C:\Temp\file.exe" elevated=taskmgr
```

#### Ağ Düzeyi Kimlik Doğrulama (NLA) Kullanma
```bash
SharpRDP.exe computername=domain.target command="C:\Temp\file.exe" nla=true
```

#### Oturum Devralma Talebi
```bash
SharpRDP.exe computername=domain.target command="C:\Temp\file.exe" takeover=true
```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpRDP yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
