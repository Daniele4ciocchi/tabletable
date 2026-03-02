import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
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
    _prenotazioni = PrenotazioniRepository.instance.readAll();
  }

  void _ricarica() {
    setState(() {
      _prenotazioni = PrenotazioniRepository.instance.readAll();
    });
  }

  Future<void> _elimina(int id) async {
    await PrenotazioniRepository.instance.delete(id);
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
