import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/modifica_prenotazione_screen.dart';

import '../../data/models/prenotazione.dart';

/// Apre la schermata di aggiunta e restituisce la [Prenotazione] inserita,
/// oppure `null` se l'utente torna indietro senza confermare.
Future<Prenotazione?> apriSchermataPrenotazioni(BuildContext context) {
  return Navigator.push<Prenotazione>(
    context,
    MaterialPageRoute(builder: (_) => const PrenotazioneScreen()),
  );
}

class PrenotazioneScreen extends StatefulWidget {
  final Prenotazione? prenotazione;

  const PrenotazioneScreen({super.key, this.prenotazione});

  @override
  State<PrenotazioneScreen> createState() => _PrenotazioneScreenState();
}

class _PrenotazioneScreenState extends State<PrenotazioneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prenotazione')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Nome: ${widget.prenotazione?.nome ?? 'N/A'}'),
            Text(
              'Numero persone: ${widget.prenotazione?.numeroPersone ?? 'N/A'}',
            ),
            Text(
              'Data e ora: ${widget.prenotazione != null ? widget.prenotazione!.dataOra.toString() : 'N/A'}',
            ),
            Text('Dettagli: ${widget.prenotazione?.dettagli ?? 'N/A'}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ModificaPrenotazioneScreen()),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
