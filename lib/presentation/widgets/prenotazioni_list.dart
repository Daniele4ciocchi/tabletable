import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';
import 'prenotazione_card.dart';

typedef PrenotazioneCallback = void Function(Prenotazione p);

class PrenotazioniList extends StatelessWidget {
  final String title;
  final List<Prenotazione> items;
  final PrenotazioneCallback onModifica;
  final PrenotazioneCallback onTap;
  final ValueChanged<int> onEliminaById;
  final PrenotazioneCallback onRimpiazza;

  const PrenotazioniList({
    super.key,
    required this.title,
    required this.items,
    required this.onModifica,
    required this.onTap,
    required this.onEliminaById,
    required this.onRimpiazza,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        items.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('Nessuna prenotazione')),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final p = items[index];
                  return PrenotazioneCard(
                    prenotazione: p,
                    onModifica: () => onModifica(p),
                    onTap: () => onTap(p),
                    onRimpiazza: onRimpiazza,
                  );
                },
              ),
      ],
    );
  }
}
