import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
import '../../utils/date_utils.dart';
import '../widgets/info_row.dart';
import 'aggiungi_prenotazione_screen.dart';

class PrenotazioneScreen extends StatelessWidget {
  final Prenotazione prenotazione;

  const PrenotazioneScreen({super.key, required this.prenotazione});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prenotazione'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Elimina',
            onPressed: () async {
              final conferma = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Elimina prenotazione'),
                  content: Text(
                    'Vuoi eliminare la prenotazione di ${prenotazione.nome}?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Annulla'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('Elimina'),
                    ),
                  ],
                ),
              );
              if (conferma != true) return;
              await PrenotazioniRepository.instance.delete(prenotazione.id!);
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
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
                    value: formatDataOra(prenotazione.dataOra),
                  ),
                  if (prenotazione.dettagli.isNotEmpty) ...[
                    const Divider(indent: 56, endIndent: 16, height: 1),
                    InfoRow(
                      icon: Icons.notes_outlined,
                      label: 'Dettagli',
                      value: prenotazione.dettagli,
                    ),
                  ],
                  if (prenotazione.telefono.isNotEmpty) ...[
                    const Divider(indent: 56, endIndent: 16, height: 1),
                    InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Telefono',
                      value: prenotazione.telefono,
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
          final modificata = await apriSchermataModificaPrenotazione(
            context,
            prenotazione,
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
