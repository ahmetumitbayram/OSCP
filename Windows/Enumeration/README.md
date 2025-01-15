Windows standalone bir makinenin pentesti sırasında **enumeration (bilgi toplama)** safhası, başarılı bir saldırı gerçekleştirebilmek için kritik bir adımdır. Aşağıda bu süreci adım adım detaylı şekilde ele alalım:

---

### **1. Sistem Bilgilerini Toplama**

- **Makine adı ve kullanıcı bilgileri**:
  ```cmd
  hostname
  whoami
  net user
  ```

- **Çalışan işletim sistemi bilgisi**:
  ```cmd
  systeminfo
  ```
  Alternatif olarak:
  ```powershell
  Get-ComputerInfo | Select-Object CsName, OsName, WindowsVersion, WindowsBuildLabEx
  ```

- **Yama durumu ve hotfix bilgisi**:
  ```cmd
  wmic qfe list
  ```

- **Kullanılan zaman dilimi**:
  ```cmd
  tzutil /g
  ```

---

### **2. Ağ Bilgilerini Toplama**

- **IP adresi ve ağ konfigürasyonu**:
  ```cmd
  ipconfig /all
  ```
  veya PowerShell ile:
  ```powershell
  Get-NetIPConfiguration
  ```

- **Açık bağlantılar ve dinlenen portlar**:
  ```cmd
  netstat -ano
  ```
  veya:
  ```powershell
  Get-NetTCPConnection
  ```

- **DNS yapılandırması**:
  ```cmd
  nslookup
  ```
  ve:
  ```powershell
  Get-DnsClientServerAddress
  ```

---

### **3. Kullanıcı ve Grup Yönetimi**

- **Sistem kullanıcılarını listeleme**:
  ```cmd
  net user
  ```

- **Kullanıcı gruplarını listeleme**:
  ```cmd
  net localgroup
  ```

- **Administrators grubundaki kullanıcılar**:
  ```cmd
  net localgroup administrators
  ```

---

### **4. Çalışan Servisler ve Süreçler**

- **Hizmetlerin listesi**:
  ```cmd
  sc query
  ```
  veya:
  ```powershell
  Get-Service
  ```

- **Planlanmış görevleri listeleme**:
  ```cmd
  schtasks /query /fo LIST /v
  ```

- **Çalışan süreçler**:
  ```cmd
  tasklist
  ```
  veya PowerShell ile:
  ```powershell
  Get-Process
  ```

---

### **5. Paylaşımlar ve Erişim Hakları**

- **Paylaşılan klasörleri listeleme**:
  ```cmd
  net share
  ```
  veya:
  ```powershell
  Get-SmbShare
  ```

- **Dosya ve dizin izinleri**:
  ```cmd
  icacls C:\Path\to\Directory
  ```

---

### **6. Güvenlik ve Firewall Durumu**

- **Kullanıcı yetkileri**:
  ```cmd
  whoami /priv
  ```

- **Firewall durumu**:
  ```cmd
  netsh advfirewall show allprofiles
  ```

- **Antivirüs yazılımı**:
  ```cmd
  wmic /namespace:\\root\SecurityCenter2 path AntiVirusProduct get displayName,productState
  ```

---

### **7. Yazılım ve Yüklü Uygulamalar**

- **Yüklü programlar**:
  ```cmd
  wmic product get name,version
  ```
  veya PowerShell ile:
  ```powershell
  Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
  ```

- **Koşan uygulamalar**:
  ```cmd
  tasklist /v
  ```

---

### **8. Zafiyet Analizi ve İleri Seviye Bilgi Toplama**

- **LSASS işlemini kontrol etmek için**:
  ```cmd
  tasklist /FI "IMAGENAME eq lsass.exe"
  ```

- **Potansiyel DLL hijacking yollarını inceleme**:
  ```cmd
  dir /s /b *.dll | findstr " "
  ```

- **Registry anahtarlarını kontrol etme**:
  ```cmd
  reg query HKLM\Software
  ```

---

### **9. Otomasyon Araçları ile Detaylı Enumeration**

- **PowerUp.ps1**: Hak yükseltme için kullanılır.
  ```powershell
  . .\PowerUp.ps1
  Invoke-AllChecks
  ```

- **WinPEAS**:
  WinPEAS, detaylı bilgi toplama için kullanılabilir.
  ```cmd
  .\winPEAS.exe
  ```

- **Seatbelt**: Kullanıcı ve sistem bilgisi toplamak için:
  ```cmd
  Seatbelt.exe -group=all
  ```

---

### **10. Notlar ve Sonraki Adımlar**

1. **Elde edilen bilgileri dokümante edin** ve potansiyel zafiyetleri analiz edin.
2. **Zafiyetleri arayın**:
   - Exploit DB veya diğer CVE kaynaklarında sistemin yama durumu ve servislerine uygun exploit'leri araştırın.
3. **İleri seviye saldırılar için yollar hazırlayın**:
   - SMB share'leri kullanarak erişim sağlama.
   - Planlanmış görevlerdeki zafiyetleri analiz etme.

Bu rehber hem manuel hem de otomasyon araçları ile geniş kapsamlı bilgi toplama sürecini içerir. İhtiyacınıza göre adımları daha da özelleştirebilirsiniz.
