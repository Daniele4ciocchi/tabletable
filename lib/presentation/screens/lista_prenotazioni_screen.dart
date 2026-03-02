import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/modifica_prenotazione_screen.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
import '../screens/mostra_prenotazione_screen.dart';
import '../widgets/prenotazione_card.dart';
import 'aggiungi_prenotazione_screen.dart';

class ListaPrenotazioniScreen extends StatefulWidget {
  const ListaPrenotazioniScreen({super.key});

  @override
  State<ListaPrenotazioniScreen> createState() =>
      _ListaPrenotazioniScreenState();
}

class _ListaPrenotazioniScreenState extends State<ListaPrenotazioniScreen> {
  late List<Prenotazione> _prenotazioni;

  @override
  void initState() {
    super.initState();
    _prenotazioni = PrenotazioniRepository.instance.readToday();
  }

  void _ricarica() {
    setState(() {
      _prenotazioni = PrenotazioniRepository.instance.readToday();
    });
  }

  Future<void> _elimina(int id) async {
    await PrenotazioniRepository.instance.delete(id);
    _ricarica();
  }

  Future<void> _modifica(Prenotazione p) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ModificaPrenotazioneScreen(prenotazione: p),
      ),
    );
    _ricarica();
  }

  Future<void> _apriDettagli(Prenotazione p) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PrenotazioneScreen(prenotazione: p)),
    );
    _ricarica();
  }

  Future<void> _aggiungi() async {
    final nuova = await apriSchermataAggiungi(context);
    if (nuova == null) return;
    await PrenotazioniRepository.instance.create(nuova);
    _ricarica();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _prenotazioni.isEmpty
          ? const Center(child: Text('Nessuna prenotazione'))
          : ListView.builder(
              itemCount: _prenotazioni.length,
              itemBuilder: (context, index) {
                final p = _prenotazioni[index];
                return PrenotazioneCard(
                  prenotazione: p,
                  onElimina: () => _elimina(p.id!),
                  onModifica: () => _modifica(p),
                  onTap: () => _apriDettagli(p),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _aggiungi,
        tooltip: 'Aggiungi prenotazione',
        child: const Icon(Icons.add),
      ),
    );
  }
}
