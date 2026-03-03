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
            children: [
              Text(
                'Dati di oggi',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InfoCard(
                    icon: Icons.event_note,
                    title: 'Prenotazioni oggi',
                    value: _prenotazioni.length.toString(),
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    icon: Icons.people,
                    title: 'Persone totali',
                    value: _prenotazioni
                        .fold(0, (sum, p) => sum + p.numeroPersone)
                        .toString(),
                  ),
                  const SizedBox(height: 12),
                  InfoCard(
                    icon: Icons.person,
                    title: 'Prenotazione più grande',
                    value: _prenotazioni.isEmpty
                        ? 'N/A'
                        : _prenotazioni
                              .map((p) => p.numeroPersone)
                              .reduce((a, b) => a > b ? a : b)
                              .toString(),
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
