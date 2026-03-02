import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/mostra_prenotazione_screen.dart';

import '../../data/models/prenotazione.dart';

class PrenotazioneCard extends StatelessWidget {
  final Prenotazione prenotazione;
  final VoidCallback onElimina;

  const PrenotazioneCard({
    super.key,
    required this.prenotazione,
    required this.onElimina,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PrenotazioneScreen(prenotazione: prenotazione),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          title: Text(prenotazione.nome),
          subtitle: Text(
            '${prenotazione.numeroPersone} persone · ${prenotazione.dataOra.day}/${prenotazione.dataOra.month} · ${prenotazione.dataOra.hour}:${prenotazione.dataOra.minute}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onElimina,
          ),
        ),
      ),
    );
  }
}
