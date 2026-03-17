# ⚖️ Huquqshunos — Yuridik Xizmatlar Platformasi

Yuristlar va fuqarolarni bog'lovchi mobil va web ilova.

---

## 📱 Imkoniyatlar

### Fuqarolar uchun:
- Ro'yxatdan o'tmasdan yuristlarni ko'rish
- Mutaxassislik va narx bo'yicha filtrlash
- Yurist profiliga kirish
- Buyurtma berish va to'lov qilish
- Sharh yozish

### Yuristlar uchun:
- Profil yaratish (majburiy ro'yxatdan o'tish)
- Xizmatlarni boshqarish
- Buyurtmalarni qabul qilish
- Daromadni kuzatish

### Interfeys:
- 🇺🇿 O'zbek tili
- 🇷🇺 Rus tili  
- 🇬🇧 Ingliz tili

---

## 🚀 O'rnatish

### 1. Flutter o'rnatish
```bash
# Flutter SDK yuklab oling:
# https://flutter.dev/docs/get-started/install

flutter --version  # tekshiring
```

### 2. Loyihani ochish
```bash
cd huquqshunos
flutter pub get
```

### 3. Ishga tushirish
```bash
# Web uchun:
flutter run -d chrome

# Android uchun:
flutter run -d android

# iOS uchun:
flutter run -d ios
```

---

## 🔥 Firebase ulash (ixtiyoriy)

1. [console.firebase.google.com](https://console.firebase.google.com) ga kiring
2. Yangi loyiha yarating: "huquqshunos"
3. FlutterFire CLI o'rnating:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
4. `lib/main.dart` faylida Firebase qatorlarini uncomment qiling

---

## 📁 Loyiha strukturasi

```
lib/
├── main.dart                    # App kirish nuqtasi
├── models/
│   ├── user_model.dart         # Foydalanuvchi modeli
│   ├── lawyer_model.dart       # Yurist modeli
│   └── booking_model.dart      # Buyurtma modeli
├── services/
│   ├── auth_service.dart       # Autentifikatsiya
│   ├── locale_service.dart     # Ko'p tillilik
│   └── theme_service.dart      # Dizayn/Rang
├── screens/
│   ├── main_nav_screen.dart    # Asosiy navigatsiya
│   ├── home_screen.dart        # Bosh sahifa
│   ├── lawyers_screen.dart     # Yuristlar ro'yxati
│   ├── lawyer_detail_screen.dart # Yurist profili
│   ├── booking_screen.dart     # Buyurtma berish
│   ├── my_bookings_screen.dart # Mening buyurtmalarim
│   ├── login_screen.dart       # Kirish
│   ├── register_screen.dart    # Ro'yxatdan o'tish
│   ├── profile_screen.dart     # Profil
│   └── lawyer_dashboard_screen.dart # Yurist paneli
├── widgets/
│   └── lawyer_card.dart        # Yurist kartochkasi
└── l10n/
    ├── app_uz.arb              # O'zbek tarjimasi
    ├── app_ru.arb              # Rus tarjimasi
    └── app_en.arb              # Ingliz tarjimasi
```

---

## 🎨 Dizayn

- **Rang**: Navy Blue (#1A3A5C) + Gold (#D4A843)
- **Font**: Playfair Display (sarlavhalar) + Inter (matn)
- **Stil**: Professional, yuridik, ishonchli

---

## 📦 Paketlar

| Paket | Maqsad |
|-------|--------|
| `provider` | State management |
| `google_fonts` | Chiroyli shriftlar |
| `firebase_auth` | Autentifikatsiya |
| `cloud_firestore` | Ma'lumotlar bazasi |
| `flutter_localizations` | Ko'p tillilik |
| `cached_network_image` | Rasmlarni cache qilish |

---

## 💳 To'lov tizimi

Hozirda demo rejimida. Ishga tushirish uchun:
- **Click** (O'zbekiston): click.uz API
- **Payme**: payme.uz API  
- **Stripe**: Xalqaro to'lovlar

---

Muammo bo'lsa: [Flutter dokumentatsiyasi](https://docs.flutter.dev)
