import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/app_settings.dart';
import 'data/repositories/prenotazioni_repository.dart';
import 'data/repositories/fornitori_repository.dart';
import 'data/repositories/spesa_repository.dart';
import 'data/repositories/settings_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await PrenotazioniRepository.instance.init();
  await FornitoriRepository.instance.init();
  await SpesaRepository.instance.init();
  await SettingsRepository.instance.init();
  await AppSettings.init();
  runApp(const App());
}
