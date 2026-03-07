import 'package:flutter/material.dart';
import 'package:tabletable/l10n/app_localizations.dart';
import 'package:tabletable/presentation/widgets/info_card.dart';

import '../../../core/app_settings.dart';
import '../../../data/models/prenotazione.dart';
import '../../../data/repositories/prenotazioni_repository.dart';

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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.homeTodayData,
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
                      icon: Icons.notes,
                      title: l10n.homeReservationsToday,
                      value: _prenotazioni.length.toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InfoCard(
                      icon: Icons.people,
                      title: l10n.homeTotalPeople,
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
                    child: ValueListenableBuilder<int>(
                      valueListenable: AppSettings.copertiTotali,
                      builder: (_, coperti, __) => InfoCard(
                        icon: Icons.event_busy,
                        title: l10n.homeRemainingSeats,
                        value:
                            (coperti -
                                    _prenotazioni.fold(
                                      0,
                                      (sum, p) => sum + p.numeroPersone,
                                    ))
                                .toString(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ValueListenableBuilder<int>(
                      valueListenable: AppSettings.copertiTotali,
                      builder: (_, coperti, __) => InfoCard(
                        icon: Icons.chair,
                        title: l10n.homeTotalSeats,
                        value: coperti.toString(),
                      ),
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
