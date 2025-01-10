# RestrictedAdmin Kullanım Kılavuzu

## Giriş
RestrictedAdmin, uzaktan "Restricted Admin Mode" özelliğini etkinleştirmek veya devre dışı bırakmak için kullanılan bir C# aracıdır. Bu özellik, Windows 8.1 ve üzeri sistemlerde RDP oturumlarında kimlik bilgisi sızıntısını önlemek için tanıtılmıştır. Ancak, Restricted Admin Mode, aynı zamanda RDP üzerinden hash ile kimlik doğrulama (Pass-The-Hash) yapılmasına da olanak tanır.

Bu araç, "Restricted Admin Mode" ayarını uzaktan yönetmek için WMI üzerinden **StdRegProv** sınıfını kullanır.

---

## Gereksinimler
- Windows işletim sistemi (8.1 veya üzeri)
- Yeterli yetkiye sahip bir kullanıcı hesabı
- Uzaktan erişilebilir bir sistem

---

## Özellikler
RestrictedAdmin aracı aşağıdaki işlemleri gerçekleştirebilir:
- Restricted Admin Mode durumunu kontrol etme
- Restricted Admin Mode özelliğini etkinleştirme
- Restricted Admin Mode özelliğini devre dışı bırakma
- Restricted Admin Mode ayarını tamamen temizleme

---

## Kullanım
### Yardım Mesajını Görüntüleme
Araç hakkında bilgi almak için:
```cmd
RestrictedAdmin.exe
```

### Argümanlar
- **Kontrol:** Restricted Admin Mode durumunu kontrol etmek için:
  ```cmd
  RestrictedAdmin.exe <system.domain.com>
  ```

- **Etkinleştirme:** Restricted Admin Mode özelliğini etkinleştirmek için:
  ```cmd
  RestrictedAdmin.exe <system.domain.com> 0
  ```

- **Devre Dışı Bırakma:** Restricted Admin Mode özelliğini devre dışı bırakmak için:
  ```cmd
  RestrictedAdmin.exe <system.domain.com> 1
  ```

- **Temizleme:** Restricted Admin Mode ayarını tamamen temizlemek için:
  ```cmd
  RestrictedAdmin.exe <system.domain.com> clear
  ```

---

## Örnek Kullanımlar
### 1. Restricted Admin Mode Durumunu Kontrol Etme
Uzak bir sistemde Restricted Admin Mode ayarını kontrol etmek için:
```cmd
RestrictedAdmin.exe server1.domain.local
```

### 2. Restricted Admin Mode Özelliğini Etkinleştirme
Uzak bir sistemde Restricted Admin Mode özelliğini etkinleştirmek için:
```cmd
RestrictedAdmin.exe server1.domain.local 0
```

### 3. Restricted Admin Mode Özelliğini Devre Dışı Bırakma
Restricted Admin Mode özelliğini devre dışı bırakmak için:
```cmd
RestrictedAdmin.exe server1.domain.local 1
```

### 4. Restricted Admin Mode Ayarını Temizleme
Restricted Admin Mode ayarını tamamen temizlemek için:
```cmd
RestrictedAdmin.exe server1.domain.local clear
```

---

## Güvenlik Notları
RestrictedAdmin yalnızca yasal ve etik amaçlarla kullanılmalıdır. Araç, sistem yöneticilerinin güvenlik ayarlarını yönetmesine yardımcı olmak için tasarlanmıştır. Yetkisiz kullanım yasal sonuçlara yol açabilir.

---

## Kaynaklar
- [RestrictedAdmin GitHub](https://github.com/GhostPack/RestrictedAdmin)
- [Microsoft Restricted Admin Mode Belgeleri](https://learn.microsoft.com)
- [WMIReg Projesi](https://github.com/airzero24/WMIReg)

---

Bu rehber, RestrictedAdmin aracını kullanarak Remote Desktop Protocol (RDP) oturumları için Restricted Admin Mode ayarlarını yönetmenin temellerini kapsamaktadır. Daha fazla bilgi veya yardım için yukarıdaki kaynakları ziyaret edin.
