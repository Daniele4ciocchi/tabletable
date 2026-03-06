import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletable/presentation/widgets/summary_banner.dart';

import '../../../data/models/prenotazione.dart';
import '../../../data/repositories/prenotazioni_repository.dart';
import 'mostra_prenotazione_screen.dart';
import '../../widgets/day_selector.dart';
import '../../widgets/prenotazioni_list.dart';
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchPrenotazioni();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) _ricarica();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
        .where(
          (p) =>
              p.dataOra.isBefore(soglia) || p.dataOra.isAtSameMomentAs(soglia),
        )
        .toList();
    _prenotazionRimanenti = _prenotazioni
        .where((p) => p.dataOra.isAfter(soglia))
        .toList();
  }

  Future<void> _elimina(int id) async {
    await PrenotazioniRepository.instance.delete(id);
    _ricarica();
  }

  Future<void> _creaRimpiazzo(Prenotazione nuova) async {
    await PrenotazioniRepository.instance.create(nuova);
    _ricarica();
  }

  Future<void> _modifica(Prenotazione p) async {
    final modificata = await apriSchermataModificaPrenotazione(context, p);
    if (modificata != null) {
      await PrenotazioniRepository.instance.update(modificata);
    }
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
    final nuova = await apriSchermataAggiungiPrenotazione(
      context,
      initialDate: _giornoSelezionato,
    );
    if (nuova == null) return;
    await PrenotazioniRepository.instance.create(nuova);
    _ricarica();
  }

  @override
  Widget build(BuildContext context) {
    final oggi = DateTime.now();
    final isOggi =
        _giornoSelezionato.year == oggi.year &&
        _giornoSelezionato.month == oggi.month &&
        _giornoSelezionato.day == oggi.day;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Header: banner + selettore giorno ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SummaryBanner(
                    icon: Icons.notes_outlined,
                    title: '${_prenotazioni.length} prenotazioni',
                    subtitle: 'Prenotazioni registrate',
                  ),
                  DaySelector(
                    selectedDate: _giornoSelezionato,
                    onDateChanged: (d) {
                      setState(() {
                        _giornoSelezionato = d;
                        fetchPrenotazioni();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // ── Lista prenotazioni ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 96),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isOggi) ...[
                    PrenotazioniList(
                      title:
                          'Prenotazioni rimanenti (${_prenotazionRimanenti.length})',
                      items: _prenotazionRimanenti,
                      onModifica: _modifica,
                      onTap: _apriDettagli,
                      onEliminaById: (id) => _elimina(id),
                      onRimpiazza: _creaRimpiazzo,
                    ),
                    const SizedBox(height: 16),
                    if (_prenotazioniPassate.isNotEmpty) ...[
                      Divider(
                        thickness: 2,
                        height: 32,
                        indent: 30,
                        endIndent: 30,
                      ),
                      PrenotazioniList(
                        title:
                            'Prenotazioni passate (${_prenotazioniPassate.length})',
                        items: _prenotazioniPassate,
                        onModifica: _modifica,
                        onTap: _apriDettagli,
                        onEliminaById: (id) => _elimina(id),
                        onRimpiazza: _creaRimpiazzo,
                      ),
                    ],
                  ] else ...[
                    PrenotazioniList(
                      title: 'Prenotazioni',
                      items: _prenotazioni,
                      onModifica: _modifica,
                      onTap: _apriDettagli,
                      onEliminaById: (id) => _elimina(id),
                      onRimpiazza: _creaRimpiazzo,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _aggiungi,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Aggiungi prenotazione'),
      ),
    );
  }
}
