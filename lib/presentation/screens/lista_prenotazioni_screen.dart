import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/modifica_prenotazione_screen.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
import '../screens/mostra_prenotazione_screen.dart';
import '../widgets/day_selector.dart';
import '../widgets/prenotazioni_list.dart';
import 'aggiungi_prenotazione_screen.dart';

class ListaPrenotazioniScreen extends StatefulWidget {
  const ListaPrenotazioniScreen({super.key});

  @override
  State<ListaPrenotazioniScreen> createState() =>
      _ListaPrenotazioniScreenState();
}

class _ListaPrenotazioniScreenState extends State<ListaPrenotazioniScreen> {
  late List<Prenotazione> _prenotazioni;
  late List<Prenotazione> _prenotazioniPassate;
  late List<Prenotazione> _prenotazionRimanenti;
  DateTime _giornoSelezionato = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchPrenotazioni();
  }

  void _ricarica() {
    setState(() {
      fetchPrenotazioni();
    });
  }

  void fetchPrenotazioni() {
    final adesso = DateTime.now();
    final soglia = DateTime(
      _giornoSelezionato.year,
      _giornoSelezionato.month,
      _giornoSelezionato.day,
      adesso.hour,
      adesso.minute,
    );
    _prenotazioni = PrenotazioniRepository.instance.readForDate(
      _giornoSelezionato,
    );
    _prenotazioniPassate = _prenotazioni
        .where((p) => p.dataOra.isBefore(soglia))
        .toList();
    _prenotazionRimanenti = _prenotazioni
        .where((p) => p.dataOra.isAfter(soglia))
        .toList();
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
    final nuova = await apriSchermataAggiungi(
      context,
      initialDate: _giornoSelezionato,
    );
    if (nuova == null) return;
    await PrenotazioniRepository.instance.create(nuova);
    _ricarica();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DaySelector(
              selectedDate: _giornoSelezionato,
              onDateChanged: (d) {
                setState(() {
                  _giornoSelezionato = d;
                  fetchPrenotazioni();
                });
              },
            ),
            if (_giornoSelezionato.year == DateTime.now().year &&
                _giornoSelezionato.month == DateTime.now().month &&
                _giornoSelezionato.day == DateTime.now().day) ...[
              PrenotazioniList(
                title: 'Prenotazioni rimanenti',
                items: _prenotazionRimanenti,
                onModifica: _modifica,
                onTap: _apriDettagli,
                onEliminaById: (id) => _elimina(id),
              ),
              const SizedBox(height: 16),
              if (_prenotazioniPassate.isNotEmpty)
                PrenotazioniList(
                  title: 'Prenotazioni passate',
                  items: _prenotazioniPassate,
                  onModifica: _modifica,
                  onTap: _apriDettagli,
                  onEliminaById: (id) => _elimina(id),
                ),
            ] else ...[
              PrenotazioniList(
                title: 'Prenotazioni',
                items: _prenotazioni,
                onModifica: _modifica,
                onTap: _apriDettagli,
                onEliminaById: (id) => _elimina(id),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _aggiungi,
        tooltip: 'Aggiungi prenotazione',
        child: const Icon(Icons.add),
      ),
    );
  }
}
