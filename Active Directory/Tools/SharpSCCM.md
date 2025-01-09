# SharpSCCM Kullanım Rehberi

## SharpSCCM Nedir?

**SharpSCCM**, Microsoft Endpoint Configuration Manager (önceki adıyla SCCM) ile etkileşim kurmak için kullanılan bir C# aracıdır. Bu araç, SCCM yönetim konsoluna erişim gerektirmeden yanal hareket, kimlik bilgisi toplama ve NTLM kimlik doğrulama saldırıları gibi işlevler sunar. Ayrıca, sistemde etkinleştirilmiş otomatik site çapında istemci dağıtımı özelliklerini istismar edebilir.

> **Önemli Not:** SharpSCCM yalnızca yetkili test ortamlarında ve etik kullanım amaçlı çalıştırılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

1. **Yanal Hareket:**
   - Kullanıcı avı ve yanal hareket işlevlerini destekler.
2. **Kimlik Bilgisi Toplama:**
   - NTLM kimlik bilgilerini toplar ve yeni saldırı vektörlerini kullanır.
3. **SCCM Etkileşimi:**
   - SCCM özelliklerini kullanarak sistem bilgilerini toplar ve kontrol sağlar.

---

## İndirme ve Çalıştırma

SharpSCCM aracı GitHub üzerinden sağlanabilir:

- [SharpSCCM GitHub Sayfası](https://github.com/Mayyhem/SharpSCCM)

### Çalıştırma Adımları

1. **Araç Dosyasını İndirin:**
   ```bash
   git clone https://github.com/Mayyhem/SharpSCCM.git
   ```

2. **Derleme:**
   - Visual Studio kullanarak projeyi açın ve derleyin.
   - Derleme sonucunda `SharpSCCM.exe` dosyasını elde edeceksiniz.

3. **Çalıştırma:**
   ```bash
   SharpSCCM.exe [parametreler]
   ```

---

## Kullanım Parametreleri

### Genel Kullanım
```bash
SharpSCCM.exe [Komutlar] [Parametreler]
```

### Örnek Komutlar

#### Kullanıcı Avı ve Hareket
- **Kullanıcı Avı:**
   ```bash
   SharpSCCM.exe -UserHunt -Target <sccm.sunucusu>
   ```

- **Yanal Hareket:**
   ```bash
   SharpSCCM.exe -MoveLaterally -Credential <kimlik_bilgisi>
   ```

#### NTLM Kimlik Doğrulama
- **NTLM Kimlik Bilgisi Toplama:**
   ```bash
   SharpSCCM.exe -GatherNTLM -SiteCode <site_kodu>
   ```

#### SCCM Kontrolü
- **SCCM Bilgi Toplama:**
   ```bash
   SharpSCCM.exe -GetInfo -Target <sccm.sunucusu>
   ```

- **SCCM Etkinlikleri İzleme:**
   ```bash
   SharpSCCM.exe -MonitorEvents -Duration <süre>
   ```

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** SharpSCCM yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Araç üretim ortamında kullanılmadan önce test ortamında değerlendirilmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
