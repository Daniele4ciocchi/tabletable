import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'presentation/screens/handler_screen.dart';
import 'core/app_settings.dart';

/// Root widget dell'applicazione.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: AppSettings.locale,
      builder: (_, locale, __) => ValueListenableBuilder<Color>(
        valueListenable: AppSettings.seedColor,
        builder: (_, color, __) => MaterialApp(
          locale: locale,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: color),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: color,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home: const HandlerScreen(),
        ),
      ),
    );
  }
}
