# LockLess

**LockLess**, açık dosya tutamaçlarını listelemek ve kilitli dosyaları kopyalamak için kullanılan bir C# aracıdır.

Bu araç, @fuzzysec'in Get-Handles.ps1'inden ilham almış ve bazı Stackoverflow kodlarını kullanmıştır.

## Özellikler

- **NtQuerySystemInformation:SystemHandleInformation** kullanarak tutamaçları listeler.
- Kilitli bir dosyayı kopyalamak için şu adımları takip eder:
  1. Dosyayı kilitleyen süreci DuplicateHandle izinleriyle açar.
  2. İlgili dosya tutamacını DuplicateHandle() ile kopyalar.
  3. CreateFileMapping() ile dosyanın kopyalanmış tutamacını eşler.
  4. MapViewOfFile() ile dosyanın tamamını belleğe eşler.
  5. WriteFile() ile eşlenen içeriği belirtilen geçici dosyaya yazar.

## Kullanım

```
C:\Temp\LockLess.exe

LockLess.exe <file.ext | all> [/process:NAME1,NAME2,...] [/copy | /copy:C:\Temp\file.ext]
```

### Örnekler

#### 1. Kilitli bir dosyayı hangi sürecin tuttuğunu öğrenmek

```cmd
C:\Temp>LockLess.exe WebCacheV01.dat

[*] "WebCacheV01.dat" dosyasını kilitleyen süreçleri arıyor
[+] Süreç "taskhostw" (5332), "C:\Users\harmj0y\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat" dosyasına (ID 880) bir tutamaç açmış.
```

#### 2. Kilitli bir dosyayı kopyalamak

```cmd
C:\Temp>LockLess.exe WebCacheV01.dat /copy

[*] "WebCacheV01.dat" dosyasını kilitleyen süreçleri arıyor
[+] Süreç "taskhostw" (5332), "C:\Users\harmj0y\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat" dosyasına (ID 880) bir tutamaç açmış.
[*] Kopyalanıyor: C:\Users\harmj0y\AppData\Local\Temp\tmp18BE.tmp
[*] "C:\Users\harmj0y\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat" dosyasından "C:\Users\harmj0y\AppData\Local\Temp\tmp18BE.tmp" dosyasına 23068672 bayt kopyalandı.
```

#### 3. Belirli bir dosyayı, belirli bir süreçten kopyalamak

```cmd
C:\Temp>LockLess.exe WebCacheV01.dat /process:taskhostw /copy:C:\Temp\out.tmp

[*] "WebCacheV01.dat" dosyasını kilitleyen süreçleri arıyor
[+] Süreç "taskhostw" (9668), "C:\Users\harmj0y\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat" dosyasına (ID 892) bir tutamaç açmış.
[*] Kopyalanıyor: C:\Temp\out.tmp
[*] "C:\Users\harmj0y\AppData\Local\Microsoft\Windows\WebCache\WebCacheV01.dat" dosyasından "C:\Temp\out.tmp" dosyasına 23068672 bayt kopyalandı.
```

#### 4. Tüm açık tutamaçları listelemek

```cmd
C:\Temp>LockLess.exe all

ProcessName,ProcessID,FileHandleID,FileName
Code,4740,64,C:\Users\harmj0y\AppData\Local\Programs\Microsoft VS Code
...(snip)...
```

## Derleme Talimatları

**LockLess**'in hazır bir binary sürümü yayınlanmamaktadır. Bu nedenle, aracı kendiniz derlemeniz gerekmektedir.

- **.NET 3.5** ile uyumludur.
- Visual Studio 2019 Community Edition kullanılarak derlenebilir.
- Proje dosyası olan `.sln`'yi açın, "release" modunu seçin ve derleme işlemini başlatın.

## Lisans

**LockLess**, BSD 3-Clause lisansı altında lisanslanmıştır.

---

**Kaynaklar:**
- [GitHub Repository](https://github.com/GhostPack/Lockless)
- [@fuzzysec](https://github.com/fuzzysecurity)

---

Bu belge, LockLess'in temel kullanım ve derleme talimatlarını Türkçe olarak özetlemektedir.
