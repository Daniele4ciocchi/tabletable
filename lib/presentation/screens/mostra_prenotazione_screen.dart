import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
import '../widgets/info_row.dart';
import 'modifica_prenotazione_screen.dart';

String _formatDataOra(DateTime dt) {
  final giorni = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];
  final mesi = [
    'Gen',
    'Feb',
    'Mar',
    'Apr',
    'Mag',
    'Giu',
    'Lug',
    'Ago',
    'Set',
    'Ott',
    'Nov',
    'Dic',
  ];
  final ora =
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  return '${giorni[dt.weekday - 1]} ${dt.day} ${mesi[dt.month - 1]} · $ora';
}

class PrenotazioneScreen extends StatelessWidget {
  final Prenotazione prenotazione;

  const PrenotazioneScreen({super.key, required this.prenotazione});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Prenotazione')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                prenotazione.nome[0].toUpperCase(),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              prenotazione.nome,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  InfoRow(
                    icon: Icons.people_outline,
                    label: 'Persone',
                    value: '${prenotazione.numeroPersone}',
                  ),
                  const Divider(indent: 56, endIndent: 16, height: 1),
                  InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Data e ora',
                    value: _formatDataOra(prenotazione.dataOra),
                  ),
                  if (prenotazione.dettagli.isNotEmpty) ...[
                    const Divider(indent: 56, endIndent: 16, height: 1),
                    InfoRow(
                      icon: Icons.notes_outlined,
                      label: 'Dettagli',
                      value: prenotazione.dettagli,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final modificata = await Navigator.push<Prenotazione>(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ModificaPrenotazioneScreen(prenotazione: prenotazione),
            ),
          );
          if (modificata == null) return;
          await PrenotazioniRepository.instance.update(modificata);
          if (context.mounted) Navigator.of(context).pop();
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
