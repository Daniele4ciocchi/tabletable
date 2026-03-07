import 'package:intl/intl.dart';

import '../core/app_settings.dart';

/// Formatta un [DateTime] nel formato "Gio 5 Mar · 20:30".
String formatDataOra(DateTime dt) {
  final localeCode = AppSettings.locale.value?.languageCode ?? 'it';
  final ora =
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  final data = DateFormat('EEE d MMM', localeCode).format(dt);
  return '$data · $ora';
}

/// Formatta un [DateTime] nel formato "Gio 5 Mar".
String formatData(DateTime dt) {
  final localeCode = AppSettings.locale.value?.languageCode ?? 'it';
  return DateFormat('EEE d MMM', localeCode).format(dt);
}
