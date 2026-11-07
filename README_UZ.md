# MASHINIST KURYER — Android boshlang‘ich loyiha

Bu Flutter asosidagi dastlabki UI prototipi.

## Hozir bor
- Mashinist / kuryer / administrator kabinetlariga kirish menyusi
- Mashinist va kuryer uchun ro‘yxatdan o‘tish shakli
- Administrator bo‘limining boshlang‘ich ko‘rinishi

## Hozircha ishlamaydigan, keyin ulanadigan qismlar
- Haqiqiy SMS tasdiqlash
- Xarita, stansiya pinini qo‘yish va jonli GPS
- Kuryerlarni masofa bo‘yicha taqsimlash va 30 soniyalik javob oynasi
- Click / Payme to‘lovlari va real balans
- Server, ma’lumotlar bazasi, admin autentifikatsiyasi
- Hujjat rasmlarini xavfsiz saqlash va buyurtma fotosurati

## Ishga tushirish
Kompyuterda Flutter SDK o‘rnatilgach:
1. `flutter create mashinist_kuryer`
2. Ushbu loyihadagi `lib/main.dart` va `pubspec.yaml` fayllarini almashtiring.
3. `flutter pub get`
4. `flutter run`

Bu manba kodi tayyor APK emas. APK yig‘ish uchun Flutter muhiti va Android SDK kerak.


## Telefon orqali GitHub Actions yordamida APK yig‘ish
1. GitHub saytida yangi public yoki private repository yarating.
2. ZIP ichidagi fayllarni ochib, barcha fayl va papkalarni repository ildiziga yuklang. `.github/workflows/android.yml` yashirin papkasini ham yuklash kerak.
3. `Actions` bo‘limiga kiring va `Android APK` ish jarayonini tanlang.
4. `Run workflow` ni bosing yoki `main` ga kod yuborilganda avtomatik ishga tushishini kuting.
5. Yig‘ilish muvaffaqiyatli tugagach, Actions run sahifasidagi Artifacts bo‘limidan `mashinist-kuryer-apk` ni yuklab oling.
6. Yuklangan artifact ZIP ichidan `app-release.apk` ni chiqarib, telefonga o‘rnating.

Eslatma: GitHub Actions workflow APK yig‘ishga urinish uchun qo‘shildi. Birinchi build xato bersa, Actions logidagi xato bo‘yicha tuzatish kerak bo‘lishi mumkin. APK hali yaratilgan yoki tekshirilgan emas.
