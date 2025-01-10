# SafetyKatz Kullanım Kılavuzu

## Giriş
SafetyKatz, @gentilkiwi'nin Mimikatz projesinin ve @subtee'nin .NET PE Loader'ının bir kombinasyonudur. Bu araç, LSASS (Local Security Authority Subsystem Service) belleğinden bilgi çekmek için tasarlanmıştır. Araç, bir MiniDump oluşturarak Mimikatz'ın modifiye edilmiş bir sürümünü çalıştırır ve sekurlsa::logonpasswords ve sekurlsa::ekeys komutlarını kullanır. 

---

## Özellikler
- LSASS belleğinden MiniDump oluşturma
- @subtee'nin PE Loader'ı ile Mimikatz'ı çalıştırma
- Komut tamamlandıktan sonra geçici dosyaları silme
- Kolay derlenebilir ve açık kaynak kodlu

---

## Gereksinimler
- Windows işletim sistemi
- .NET Framework 3.5 veya daha üstü
- Visual Studio 2015 veya daha güncel bir sürüm (derleme için)

---

## Kullanım

### Yardım Mesajını Görüntüleme
SafetyKatz komutlarının ve argümanlarının tam listesini görmek için:
```cmd
SafetyKatz.exe -h
```

### Temel Kullanım
SafetyKatz LSASS MiniDump oluşturur ve ardından Mimikatz komutlarını çalıştırır:
```cmd
SafetyKatz.exe
```
Örnek çıktı:
```
[*] Dumping lsass (808) to C:\WINDOWS\Temp\debug.bin
[+] Dump successful!

[*] Executing loaded Mimikatz PE

mimikatz # Opening : 'C:\Windows\Temp\debug.bin' file for minidump...
```

---

## Örnek Kullanımlar

### 1. LSASS MiniDump Oluşturma ve Şifreleri Çekme
```cmd
SafetyKatz.exe
```
Bu komut, `C:\WINDOWS\Temp\debug.bin` dosyasını oluşturur ve ardından Mimikatz komutlarını çalıştırarak şifre bilgilerini alır.

---

## Derleme Talimatları
SafetyKatz'ın derlenmiş bir sürümünü sağlamak yerine, kendi sürümünüzü derlemeniz gerekmektedir. 

### Derleme Adımları:
1. Visual Studio 2015 Community Edition veya daha yeni bir sürümü yükleyin.
2. SafetyKatz projesini açın (`SafetyKatz.sln`).
3. Çözüm yapılandırmasını "Release" olarak seçin.
4. Projeyi derleyin.

---

## Notlar
- Bu araç yalnızca yasal ve etik amaçlarla kullanılmalıdır.
- Mimikatz'ın modifiye edilmiş bir sürümünü içerdiği için dosya bütünlüğünü kontrol etmek isteyebilirsiniz.

---

## Kaynaklar
- [SafetyKatz GitHub](https://github.com/GhostPack/SafetyKatz)
- [Mimikatz](https://github.com/gentilkiwi/mimikatz)
- [PE Loader](https://github.com/subTee/PELoader)

---

Bu rehber, SafetyKatz aracını kullanarak LSASS belleğinden bilgi çekmenin temel adımlarını kapsamaktadır. Daha fazla bilgi için yukarıdaki kaynaklara başvurabilirsiniz.
