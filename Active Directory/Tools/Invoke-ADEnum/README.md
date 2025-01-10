# Invoke-ADEnum.ps1 Kullanım Rehberi

## **Invoke-ADEnum Nedir?**

**Invoke-ADEnum**, Active Directory ortamlarından bilgi toplama sürecini otomatikleştirmek için tasarlanmış bir betiktir. Güvenlik değerlendirmeleri, uyumluluk denetimleri veya genel AD bilgi toplama görevleri için kullanılabilir. Betik, toplanan verileri HTML formatında bir rapor haline getirerek kullanıcılara kapsamlı bir analiz sunar.

### **Öne Çıkan Özellikler**
- **Active Directory Nesneleri:** Ormanlar, etki alanları, güven ilişkileri, kullanıcılar, gruplar, bilgisayarlar, paylaşımlar, ACL'ler, OU'lar, GPO'lar ve daha fazlasını tarar.
- **HTML Raporlama:** Kapsamlı bir HTML raporu oluşturur ve CSV veya XLSX formatında dışa aktarım seçenekleri sunar.
- **Öneriler:** Tespit edilen sorunlar için iyileştirme önerileri sağlar.

### **Desteklenen Özellikler**
- Kullanıcılar, gruplar ve bilgisayarlar hakkında bilgi toplama
- Zayıf izinler, RBCD, boş şifre spreyi gibi güvenlik açıklarını tarama
- Yerel yönetici erişimini bulma
- GPO analizleri

---

## **Kurulum**

Betik GitHub üzerinden indirilebilir ve hafızaya yüklenerek çalıştırılabilir:

```powershell
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Leo4j/Invoke-ADEnum/main/Invoke-ADEnum.ps1')
```

---

## **Kullanım**

### **Yardım Menüsü**
Yardım sayfasını görüntülemek için:
```powershell
Invoke-ADEnum -Help
```

### **Hedefleri Kontrol Etme**
Hedef sistemleri listelemek ve kapsamda kalmak için:
```powershell
Invoke-ADEnum -TargetsOnly
```

### **Belirli Bir Etki Alanı Taraması**
Tek bir etki alanını ve bir DC'yi belirtmek için:
```powershell
Invoke-ADEnum -Domain contoso.local -Server DC01.contoso.local
```

### **Kapsam Dışı Etki Alanlarını Hariç Tutma**
Kapsam dışı etki alanlarını hariç tutmak için:
```powershell
Invoke-ADEnum -Exclude "contoso.local,domain.local"
```

---

## **Önerilen Kullanım**

### **1. Geçiş: Hızlı Değerlendirme**
İlk aşamada hızlı bir değerlendirme için aşağıdaki komut kullanılabilir:
```powershell
Invoke-ADEnum -SaveToDisk -FindLocalAdminAccess
```
Kaydedilen dosyalar şu konumda bulunur: `C:\Users\Public\Documents\Invoke-ADEnum`

### **2. Geçiş: Kapsamlı Analiz**
Daha önce kaydedilen verileri yükleyerek kapsamlı bir analiz yapmak için:
```powershell
Invoke-ADEnum -LoadFromDisk -SprayEmptyPasswords -FindLocalAdminAccess -RBCD -UserCreatedObjects -WeakPermissions -MoreGPOs -AllDescriptions
```

### **Tam Kapsama**
Tüm denetimlerin gerçekleştirilmesi uzun sürebilir:
```powershell
Invoke-ADEnum -AllEnum -Force
```

---

## **Örnek HTML Raporu**
HTML raporu örneğini aşağıdaki bağlantıda inceleyebilirsiniz:
[Invoke-ADEnum HTML Örneği](https://leo4j.github.io/Invoke-ADEnum/)

---

## **Sorumluluk Reddi**
**Invoke-ADEnum** yalnızca araştırma, eğitim ve yetkilendirilmiş testler için tasarlanmıştır. Araç, yalnızca yetkili kişiler tarafından ve yasal sınırlar içinde kullanılmalıdır. Yasa dışı kullanımlar ciddi hukuki sonuçlara yol açabilir. Araç geliştiricisi, kötüye kullanım veya yetkisiz kullanımlardan doğabilecek zararlar için sorumluluk kabul etmez.

---

## **Teşekkür**
Bu projeye katkıda bulunanlara teşekkür ederiz.
