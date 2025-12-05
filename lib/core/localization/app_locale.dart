import 'package:flutter/material.dart';

enum AppLocale { en, id }

extension AppLocaleX on AppLocale {
  Locale get toLocale {
    switch (this) {
      case AppLocale.id:
        return const Locale('id');
      default:
        return const Locale('en');
    }
  }

  static AppLocale fromDevice(Locale device) {
    if (device.languageCode.toLowerCase() == 'id') {
      return AppLocale.id;
    }
    return AppLocale.en;
  }
}
