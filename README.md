# Piscine Mobile - 0

---

## Widget Nedir?

Flutter'da ekranda gördüğün her şey bir widget'tır — metin, buton, padding, hatta sayfa düzeni bile. Widget'lar birbirinin içine geçerek bir ağaç (widget tree) oluşturur.

**İki temel tipi var:**

| | StatelessWidget | StatefulWidget |
|---|---|---|
| State tutabilir mi? | Hayır | Evet |
| Ne zaman kullanılır? | Değişmeyen UI parçaları | Kullanıcı etkileşimiyle değişen parçalar |
| Örnek | Sabit metin, ikon | Sayaç, toggle, hesap makinesi |

**State nedir?** Widget'ın zaman içinde değişebilen verisi. Örneğin bir butona basıldığında değişen metin state'tir. `setState()` çağrıldığında Flutter o widget'ı yeniden çizer.

---

## Exercise 00 — A basic display

**Ne yapıyor:**  
Ekranın tam ortasında bir metin ve altında bir buton. Butona basınca debug konsoluna `Button pressed` yazar.

**Neden StatelessWidget?**  
Hiçbir şey değişmiyor — metin sabit, buton sabit. State tutmaya gerek yok.

**Responsiveness nasıl sağlandı?**  
`Center` + `Column` ile widget'lar ekran boyutuna göre konumlanıyor. Sabit piksel kullanılmadı.

**`debugPrint` vs `print`:**  
`debugPrint` uzun çıktıları kesmez ve release build'de otomatik susturulur. Subject'in beklediği `I/flutter: Button pressed` formatı bu sayede oluşur.

---

## Exercise 01 — Say Hello to the World

**Ne yapıyor:**  
Butona her basışta metin `A simple text` ↔ `Hello World!` arasında geçiş yapıyor.

**Neden StatefulWidget?**  
Metin değişiyor — bu bir state. `_showHello` bool değişkeni `setState()` ile toggle ediliyor, Flutter widget'ı yeniden çiziyor.

**Temel akış:**
```
Buton tıklanır
→ _onButtonPressed() çağrılır
→ setState(() { _showHello = !_showHello; })
→ Flutter build() metodunu tekrar çalıştırır
→ Text widget yeni değerle çizilir
```

---

## Exercise 02 — More Buttons

**Ne yapıyor:**  
Üstte `AppBar` (başlık: "Calculator"), altında iki `TextField` (expression / result, ikisi de "0" gösterir), en altta buton grid'i.

**Butonlar:**
- Rakamlar: `0–9`
- Ondalık: `.`
- Son karakteri sil: `C`
- Her şeyi sıfırla: `AC`
- Sonuç göster: `=`
- Operatörler: `+`, `-`, `*`, `/`

**Debug özelliği:** Her butona basışta `button pressed :<label>` konsola yazılır.

**Responsiveness:** `GridView` ile butonlar mevcut alana göre otomatik boyutlanıyor. Telefon ve tablette düzgün görünür.

**TextField neden `readOnly`?**  
Kullanıcı doğrudan yazmamalı, sadece butonlarla giriş yapmalı.

---

## Exercise 03 — It's Alive! (`calculator_app`)

**Ne yapıyor:**  
ex02'nin çalışan versiyonu. Gerçek hesaplama mantığı eklendi.

**`math_expressions` paketi:**  
String olarak alınan matematiksel ifadeyi (ör. `59-89+20/6`) parse edip hesaplayan kütüphane. `GrammarParser` kullanılıyor (`Parser` deprecated olduğu için).

**Hesaplama akışı:**
```
"59-89+20/6"
→ GrammarParser().parse()  →  Expression ağacı
→ exp.evaluate(EvaluationType.REAL, ContextModel())  →  double
→ Ekrana yaz
```

**Negatif sayı nasıl girilir?**  
`-` butonuna önce basılır, sonra rakam — expression string'e `-` eklenir, parser bunu negatif sayı olarak yorumlar.

**Uygulama neden crash etmez?**  
Tüm `evaluate` çağrısı `try/catch` içinde. `isNaN`, `isInfinite` kontrolleri var. Sıfıra bölme, geçersiz ifade, çok büyük sayı — hepsi `Error` gösterir, crash olmaz.

---

## Değinilse İyi Olur

**Flutter'da hot reload ne işe yarar?**  
Uygulamayı yeniden başlatmadan kod değişikliklerini anında yansıtır. State korunur. `r` tuşuyla çalışır. Hot restart (`R`) ise state'i sıfırlar.

**Widget tree nedir?**  
Her widget başka widget'ları içerebilir. Bu içiçe geçmiş yapı bir ağaç oluşturur. Flutter bu ağacı tarayarak ekranı çizer.

**`build()` ne zaman çalışır?**  
Widget ilk oluşturulduğunda ve `setState()` çağrıldığında.

**Neden `const` constructor kullanıyoruz?**  
`const` widget'lar derleme zamanında oluşturulur, rebuild sırasında yeniden yaratılmaz. Performans için iyi pratik.

---

## Çalıştırma

```bash
# Android emulator / cihaz (önerilen)
flutter run

# Web (tarayıcıda test için)
flutter run -d chrome
# → F12 > Console sekmesinde debug çıktısını görürsün
```

---

## Klasör Yapısı

```
mobileModule00/
├── ex00/            # Exercise 00 — A basic display
├── ex01/            # Exercise 01 — Say Hello to the World
├── ex02/            # Exercise 02 — More Buttons
└── calculator_app/  # Exercise 03 — It's Alive!
```
