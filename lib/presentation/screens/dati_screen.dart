import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/modifica_prenotazione_screen.dart';
import 'package:tabletable/presentation/widgets/info_card.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';
import '../screens/mostra_prenotazione_screen.dart';
import '../widgets/prenotazione_card.dart';
import 'aggiungi_prenotazione_screen.dart';

class DatiScreen extends StatefulWidget {
  const DatiScreen({super.key});

  @override
  State<DatiScreen> createState() => _DatiScreenState();
}

class _DatiScreenState extends State<DatiScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Dati', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoCard(
                  title: 'Prenotazioni oggi',
                  value: _prenotazioni.length.toString(),
                ),
                const SizedBox(width: 30),
                InfoCard(
                  title: 'Persone totali',
                  value: _prenotazioni
                      .fold<int>(0, (sum, p) => sum + p.numeroPersone)
                      .toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
