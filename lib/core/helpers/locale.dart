import 'package:drugpromotion/core/helpers/storage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppLocaleNotifier extends ChangeNotifier {
  String _locale = StorageRepository.getString('locale', defValue: 'ru');

  String get locale => _locale;

  void setLocale(String newLocale) {
    if (_locale == newLocale) return;

    _locale = newLocale;

    StorageRepository.putString('locale', newLocale);

    Intl.defaultLocale = newLocale;

    notifyListeners();
  }
}
