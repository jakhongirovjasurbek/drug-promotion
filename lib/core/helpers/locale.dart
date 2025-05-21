// lib/localization/app_locale_notifier.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocaleNotifier extends ChangeNotifier {
  String _locale = Intl().locale;

  String get locale => _locale;

  void setLocale(String newLocale) {
    if (_locale == newLocale) return;

    _locale = newLocale;

    // Update the global Intl locale too
    Intl.defaultLocale = newLocale;

    notifyListeners(); // Triggers rebuild of MaterialApp
  }
}
