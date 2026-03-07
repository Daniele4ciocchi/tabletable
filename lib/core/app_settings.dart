import 'package:flutter/material.dart';

import '../data/repositories/settings_repository.dart';

class AppSettings {
  AppSettings._();

  static const _kSeedColor = 'seedColor';
  static const _kCopertiTotali = 'copertiTotali';
  static const _kLocaleCode = 'localeCode';
  static bool _initialized = false;

  static final seedColor = ValueNotifier<Color>(const Color(0xFF7C0000));
  static final copertiTotali = ValueNotifier<int>(20);
  static final locale = ValueNotifier<Locale?>(const Locale('it'));

  static Future<void> init() async {
    if (_initialized) return;

    final settings = SettingsRepository.instance;
    final savedSeedColor = settings.readOrDefault<int>(
      _kSeedColor,
      seedColor.value.toARGB32(),
    );
    final savedCopertiTotali = settings.readOrDefault<int>(
      _kCopertiTotali,
      copertiTotali.value,
    );
    final savedLocaleCode = settings.readOrDefault<String?>(
      _kLocaleCode,
      locale.value?.languageCode,
    );

    seedColor.value = Color(savedSeedColor);
    copertiTotali.value = savedCopertiTotali;
    locale.value = savedLocaleCode == null ? null : Locale(savedLocaleCode);

    seedColor.addListener(_persistSeedColor);
    copertiTotali.addListener(_persistCopertiTotali);
    locale.addListener(_persistLocale);
    _initialized = true;
  }

  static void _persistSeedColor() {
    SettingsRepository.instance.saveValue(
      _kSeedColor,
      seedColor.value.toARGB32(),
    );
  }

  static void _persistCopertiTotali() {
    SettingsRepository.instance.saveValue(_kCopertiTotali, copertiTotali.value);
  }

  static void _persistLocale() {
    SettingsRepository.instance.saveValue(
      _kLocaleCode,
      locale.value?.languageCode,
    );
  }
}
