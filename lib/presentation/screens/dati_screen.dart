import 'package:flutter/material.dart';
import 'package:tabletable/presentation/widgets/info_card.dart';

import '../../data/models/prenotazione.dart';
import '../../data/repositories/prenotazioni_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dati di oggi',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.event_note,
                      title: 'Prenotazioni oggi',
                      value: _prenotazioni.length.toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.people,
                      title: 'Persone totali',
                      value: _prenotazioni
                          .fold(0, (sum, p) => sum + p.numeroPersone)
                          .toString(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InfoCard(
                      icon: Icons.event_busy,
                      title: 'Posti rimanenti',
                      value:
                          (Prenotazione.copertiTotali -
                                  _prenotazioni.fold(
                                    0,
                                    (sum, p) => sum + p.numeroPersone,
                                  ))
                              .toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.chair,
                      title: 'Posti totali',
                      value: Prenotazione.copertiTotali.toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
