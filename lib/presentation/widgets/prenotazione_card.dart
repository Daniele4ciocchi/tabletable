import 'package:flutter/material.dart';
import 'package:tabletable/l10n/app_localizations.dart';
import 'package:tabletable/presentation/screens/prenotazioni/aggiungi_prenotazione_screen.dart';

import '../../data/models/prenotazione.dart';
import '../../utils/date_utils.dart';

class PrenotazioneCard extends StatefulWidget {
  final Prenotazione prenotazione;
  final VoidCallback onTap;
  final VoidCallback onModifica;
  final ValueChanged<Prenotazione> onRimpiazza;

  const PrenotazioneCard({
    super.key,
    required this.prenotazione,
    required this.onTap,
    required this.onModifica,
    required this.onRimpiazza,
  });

  @override
  State<PrenotazioneCard> createState() => _PrenotazioneCardState();
}

class _PrenotazioneCardState extends State<PrenotazioneCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? colorScheme.primaryContainer
                : colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.15 : 0.05),
                blurRadius: _hovered ? 12 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: SizedBox(
                  width: 120,
                  child: Center(
                    child: Text(
                      '${widget.prenotazione.dataOra.hour.toString().padLeft(2, '0')}:${widget.prenotazione.dataOra.minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                title: Text(widget.prenotazione.nome),
                subtitle: Text(
                  '${widget.prenotazione.numeroPersone} ${l10n.reservationPeople.toLowerCase()} · ${formatData(widget.prenotazione.dataOra)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () async {
                          final nuova =
                              await apriSchermataRimpiazzaPrenotazione(
                                context,
                                widget.prenotazione,
                              );
                          if (nuova != null) widget.onRimpiazza(nuova);
                        },
                        icon: const Icon(Icons.reply),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: widget.onModifica,
                    ),
                  ],
                ),
              ),
              if (widget.prenotazione.rimpiazzo != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Row(
                    children: [
                      const Icon(Icons.reply, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.reservationReplaceSummary(
                          '${widget.prenotazione.rimpiazzo!.dataOra.hour.toString().padLeft(2, '0')}:${widget.prenotazione.rimpiazzo!.dataOra.minute.toString().padLeft(2, '0')}',
                          widget.prenotazione.rimpiazzo!.nome,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
