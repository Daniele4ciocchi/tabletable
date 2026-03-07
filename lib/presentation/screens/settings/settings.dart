import 'package:flutter/material.dart';

import '../../../core/app_settings.dart';
import '../../../l10n/app_localizations.dart';

void openSettings(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SettingsScreen()),
  );
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const _colori = [
    Color(0xFF7C0000), // rosso scuro
    Color(0xFFB71C1C), // rosso
    Color(0xFFE65100), // arancione
    Color(0xFFF9A825), // giallo
    Color(0xFF2E7D32), // verde
    Color(0xFF00695C), // verde acqua
    Color(0xFF01579B), // blu
    Color(0xFF283593), // blu scuro
    Color(0xFF4A148C), // viola
    Color(0xFF880E4F), // rosa scuro
    Color(0xFF37474F), // grigio blu
    Color(0xFF212121), // quasi nero
  ];

  void _apriColorPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsPrimaryColorPickerTitle),
        content: SizedBox(
          width: 280,
          child: ValueListenableBuilder<Color>(
            valueListenable: AppSettings.seedColor,
            builder: (_, selectedColor, __) => Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colori.map((color) {
                final isSelected = color.toARGB32() == selectedColor.toARGB32();
                return GestureDetector(
                  onTap: () {
                    AppSettings.seedColor.value = color;
                    Navigator.of(ctx).pop();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 3,
                            )
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withAlpha(120),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.settingsCancel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: colors.surfaceContainerLow,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // ── Sezione: Generali ──
          _SectionHeader(l10n.settingsSectionGeneral),
          _SettingsCard(
            children: [
              ListTile(
                leading: Icon(
                  Icons.table_restaurant_outlined,
                  color: colors.primary,
                ),
                title: Text(l10n.settingsMaxSeats),
                subtitle: Text(l10n.settingsMaxSeatsSubtitle),
                trailing: ValueListenableBuilder<int>(
                  valueListenable: AppSettings.copertiTotali,
                  builder: (_, val, __) => Text(val.toString()),
                ),
                onTap: () {
                  int? tempCoperti;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.settingsSetMaxSeatsTitle),
                      content: TextField(
                        controller: TextEditingController(
                          text: AppSettings.copertiTotali.value.toString(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          tempCoperti = int.tryParse(value);
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: l10n.settingsMaxSeats,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(l10n.settingsClose),
                        ),
                        TextButton(
                          onPressed: () {
                            if (tempCoperti != null) {
                              AppSettings.copertiTotali.value = tempCoperti!;
                              setState(() {});
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(l10n.settingsSave),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                leading: Icon(Icons.language_outlined, color: colors.primary),
                title: Text(l10n.settingsLanguage),
                subtitle: Text(l10n.settingsLanguageSubtitle),
                trailing: ValueListenableBuilder<Locale?>(
                  valueListenable: AppSettings.locale,
                  builder: (_, locale, __) {
                    final languageCode = locale?.languageCode ?? 'it';
                    final label = languageCode == 'en'
                        ? l10n.settingsLanguageEnglish
                        : l10n.settingsLanguageItalian;
                    return PopupMenuButton<String>(
                      onSelected: (value) {
                        AppSettings.locale.value = Locale(value);
                        setState(() {});
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'it',
                          child: Text(l10n.settingsLanguageItalian),
                        ),
                        PopupMenuItem<String>(
                          value: 'en',
                          child: Text(l10n.settingsLanguageEnglish),
                        ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(label),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                leading: Icon(Icons.palette_outlined, color: colors.primary),
                title: Text(l10n.settingsPrimaryColor),
                subtitle: Text(l10n.settingsPrimaryColorSubtitle),
                trailing: ValueListenableBuilder<Color>(
                  valueListenable: AppSettings.seedColor,
                  builder: (_, color, __) =>
                      CircleAvatar(radius: 12, backgroundColor: color),
                ),
                onTap: () => _apriColorPicker(context),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Sezione: App ──
          _SectionHeader(l10n.settingsSectionApp),
          _SettingsCard(
            children: [
              ListTile(
                leading: Icon(Icons.info_outline, color: colors.primary),
                title: Text(l10n.settingsInfo),
                subtitle: Text(l10n.settingsVersion('1.0.0')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: l10n.appTitle,
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.table_restaurant_outlined,
                    size: 48,
                  ),
                  applicationLegalese: l10n.aboutLegalese,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surface,
      child: Column(children: children),
    );
  }
}
