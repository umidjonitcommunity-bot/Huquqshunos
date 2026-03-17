// lib/services/locale_service.dart
import 'package:flutter/material.dart';

class LocaleService extends ChangeNotifier {
  Locale _locale = const Locale('uz');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  String get languageName {
    switch (_locale.languageCode) {
      case 'uz': return "O'zbek";
      case 'ru': return 'Русский';
      case 'en': return 'English';
      default: return "O'zbek";
    }
  }
}
