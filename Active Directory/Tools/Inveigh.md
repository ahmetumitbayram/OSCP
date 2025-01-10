# Inveigh Kullanım Rehberi

## Inveigh Nedir?

**Inveigh**, penetrasyon testleri için tasarlanmış, hem IPv4 hem de IPv6 üzerinde çalışan bir .NET **man-in-the-middle (MITM)** aracıdır. Bu araç, protokol bazlı dinleyiciler ve paket yakalama teknikleriyle kimlik doğrulama bilgilerini ve hash değerlerini ele geçirmek için kullanılabilir.

> **Önemli Not:** Bu araç yalnızca yetkili test ortamlarında ve etik amaçlarla kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Özellikler

- **Protokol Saldırıları:** Aşağıdaki protokoller üzerinden saldırı gerçekleştirebilirsiniz:
  - LLMNR
  - DNS
  - mDNS
  - NBNS
  - DHCPv6
  - ICMPv6
  - HTTP
  - HTTPS
  - SMB
  - LDAP
  - WebDAV
- **Platformlar Arası Destek:** Windows, Linux ve macOS üzerinde çalışabilir.
- **Paket Yakalama ve Dinleme:** Dinleyicilerle veya protokol seviyesinde paket yakalama yöntemleriyle veri toplayabilir.
- **Kolay Özelleştirme:** Parametrelerle işlevsellik özelleştirilebilir.

---

## Gereksinimler

- .NET 6.0 veya daha yeni bir sürüm.
- Yönetici yetkileri (Windows için).
- macOS ve Linux sistemlerinde uygun rotaların ayarlanması gerekebilir (örneğin, DHCPv6 saldırıları için).

---

## Kurulum

### Kod Deposu

Inveigh'i GitHub üzerinden indirerek kullanabilirsiniz:

[Inveigh GitHub Deposu](https://github.com/Kevin-Robertson/Inveigh)

### Derleme

1. **Depoyu Klonlayın:**
   ```bash
   git clone https://github.com/Kevin-Robertson/Inveigh.git
   ```

2. **Derleyin:**
   .NET SDK yüklü ise aşağıdaki komutları kullanarak derleyebilirsiniz:
   ```bash
   dotnet publish -r win-x64 -f net6.0 -p:AssemblyName=Inveigh
   ```

   Linux veya macOS için:
   ```bash
   dotnet publish --self-contained=true -p:PublishSingleFile=true -r linux-x64 -f net6.0 -p:AssemblyName=Inveigh
   ```

---

## Kullanım

### Temel Kullanım

Varsayılan ayarlarla Inveigh çalıştırmak için:

```bash
Inveigh.exe
```

### Parametreler

Aşağıda sık kullanılan parametrelerden bazıları listelenmiştir:

- **-IPv4:** IPv4 spoofing ve yakalama (Varsayılan: Etkin).
- **-IPv6:** IPv6 spoofing ve yakalama (Varsayılan: Etkin).
- **-HTTP:** HTTP dinleyicisini etkinleştirir (Varsayılan: Etkin).
- **-HTTPS:** HTTPS dinleyicisini etkinleştirir (Varsayılan: Etkin).
- **-LLMNR:** LLMNR spoofing (Varsayılan: Etkin).
- **-SMB:** SMB dinleyici veya paket yakalama (Varsayılan: Etkin).
- **-RunTime:** Çalışma süresi (dakika).
- **-FileOutput:** Çıktıları dosyaya kaydetme (Varsayılan: Etkin).

### Örnek Komutlar

#### HTTP Dinleyici Çalıştırma

```bash
Inveigh.exe -HTTP y -HTTPPorts 8080
```

#### LLMNR Spoofing

```bash
Inveigh.exe -LLMNR y
```

#### SMB Dinleyici Çalıştırma

```bash
Inveigh.exe -SMB y
```

#### Çıktıları Belirli Bir Dizine Kaydetme

```bash
Inveigh.exe -FileDirectory C:\Logs
```

---

## Desteklenen Protokoller

- **LLMNR (Link-Local Multicast Name Resolution):** Paket yakalama ve spoofing.
- **DNS:** DNS paketlerini yakalama ve yanıtlama.
- **mDNS:** Multicast DNS desteği.
- **NBNS:** NetBIOS Name Service paketlerini yakalama ve yanıtlama.
- **DHCPv6:** DHCPv6 spoofing.
- **ICMPv6:** ICMPv6 üzerinden DNS sunucusu ve arama etki alanı ekleme.
- **HTTP/HTTPS:** HTTP/HTTPS kimlik doğrulama yakalama.
- **SMB:** SMB üzerinden NTLM kimlik doğrulama yakalama.
- **LDAP:** LDAP dinleyici üzerinden veri toplama.
- **WebDAV:** WebDAV kimlik doğrulama yakalama.

---

## Ek Bilgiler

### Çıktılar

Inveigh çalışırken hem gerçek zamanlı çıktılar hem de dosya çıktıları sağlar. Varsayılan olarak dosya çıktıları çalışma dizininde kaydedilir. 

### Bilinen Sorunlar

- **Linux/macOS:** Paket yakalama yalnızca Windows sistemlerinde desteklenir. Diğer platformlarda SMB dinleyicisi kullanılabilir.
- **macOS:** DHCPv6 için manuel olarak rota eklenmesi gerekebilir:
  ```bash
  sudo route -nv add -net ff02::1:2 -interface en0
  ```

---

## Katkıda Bulunanlar

- **Kevin Robertson:** Ana geliştirici.
- **Responder ve Impacket:** İlham ve bazı kod entegrasyonları için teşekkürler.

---

## Lisans

Bu proje [BSD-3-Clause Lisansı](https://opensource.org/licenses/BSD-3-Clause) altında lisanslanmıştır.
