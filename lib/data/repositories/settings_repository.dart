import 'package:hive_flutter/hive_flutter.dart';

class SettingsRepository {
  static const _kBoxName = 'settings';
  static const _kSettingsDocKey = 'app_settings';

  static final SettingsRepository instance = SettingsRepository._();
  SettingsRepository._();

  Box<Map>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<Map>(_kBoxName);
  }

  Map<String, dynamic> readAll() {
    final raw = _box!.get(_kSettingsDocKey);
    if (raw == null) return <String, dynamic>{};
    return Map<String, dynamic>.from(raw);
  }

  T readOrDefault<T>(String key, T defaultValue) {
    final all = readAll();
    final value = all[key];
    if (value is T) return value;
    return defaultValue;
  }

  Future<void> saveValue(String key, dynamic value) async {
    final all = readAll();
    all[key] = value;
    await _box!.put(_kSettingsDocKey, all);
  }
}
