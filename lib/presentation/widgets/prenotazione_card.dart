import 'package:flutter/material.dart';

import '../../data/models/prenotazione.dart';

class PrenotazioneCard extends StatefulWidget {
  final Prenotazione prenotazione;
  final VoidCallback onElimina;
  final VoidCallback onTap;
  final VoidCallback onModifica;

  const PrenotazioneCard({
    super.key,
    required this.prenotazione,
    required this.onElimina,
    required this.onTap,
    required this.onModifica,
  });

  @override
  State<PrenotazioneCard> createState() => _PrenotazioneCardState();
}

class _PrenotazioneCardState extends State<PrenotazioneCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                widget.prenotazione.nome[0].toUpperCase(),
                style: TextStyle(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(widget.prenotazione.nome),
            subtitle: Text(
              '${widget.prenotazione.numeroPersone} persone · ${widget.prenotazione.dataOra.day.toString().padLeft(2, '0')}/${widget.prenotazione.dataOra.month.toString().padLeft(2, '0')}/${widget.prenotazione.dataOra.year} · ${widget.prenotazione.dataOra.hour.toString().padLeft(2, '0')}:${widget.prenotazione.dataOra.minute.toString().padLeft(2, '0')}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: widget.onModifica,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onElimina,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
