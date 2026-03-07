import 'package:flutter/material.dart';
import 'package:tabletable/data/models/fornitore.dart';
import 'package:tabletable/data/models/spesa.dart';
import 'package:tabletable/data/repositories/fornitori_repository.dart';
import 'package:tabletable/data/repositories/spesa_repository.dart';
import 'package:tabletable/l10n/app_localizations.dart';
import 'aggiungi_fornitore_screen.dart';
import 'package:tabletable/presentation/widgets/dialog_spesa.dart';

import '../../widgets/info_row.dart';

class FornitoreScreen extends StatefulWidget {
  const FornitoreScreen({super.key, required this.fornitore});

  final Fornitore fornitore;

  @override
  State<FornitoreScreen> createState() => _FornitoreScreenState();
}

class _FornitoreScreenState extends State<FornitoreScreen> {
  late List<Spesa> _spese;

  @override
  void initState() {
    super.initState();
    _ricarica();
  }

  void _ricarica() {
    setState(() {
      _spese = SpesaRepository.instance.readForFornitore(widget.fornitore.id!);
    });
  }

  Future<void> _apriDialogSpesa({Spesa? spesa}) async {
    final risultato = await showDialogSpesa(context, spesa: spesa);
    if (risultato == null) return;

    final salva = Spesa(
      id: risultato.id,
      fornitore: widget.fornitore,
      alimento: risultato.alimento,
      dettagli: risultato.dettagli,
      prezzo: risultato.prezzo,
      dataOra: risultato.dataOra,
    );
    if (spesa == null) {
      await SpesaRepository.instance.create(salva);
    } else {
      await SpesaRepository.instance.update(salva);
    }
    _ricarica();
  }

  @override
  Widget build(BuildContext context) {
    final fornitore = widget.fornitore;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.supplierScreenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.commonDelete,
            onPressed: () async {
              final conferma = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(l10n.supplierDeleteTitle),
                  content: Text(l10n.supplierDeletePrompt(fornitore.nome)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: Text(l10n.commonCancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: Text(l10n.commonDelete),
                    ),
                  ],
                ),
              );
              if (conferma != true) return;
              await FornitoriRepository.instance.delete(fornitore.id!);
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.commonEdit,
            onPressed: () async {
              final conferma = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(l10n.supplierEditTitle),
                  content: Text(l10n.supplierEditPrompt(fornitore.nome)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: Text(l10n.commonCancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: Text(l10n.commonEdit),
                    ),
                  ],
                ),
              );
              if (conferma != true) return;
              if (!context.mounted) return;
              final modificata = await apriSchermataModificaFornitore(
                context,
                fornitore,
              );
              if (modificata == null) return;
              await FornitoriRepository.instance.update(modificata);
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                fornitore.nome[0].toUpperCase(),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              fornitore.nome,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  if (fornitore.descrizione.isNotEmpty) ...[
                    InfoRow(
                      icon: Icons.notes_outlined,
                      label: l10n.commonDescription,
                      value: fornitore.descrizione,
                    ),
                  ],
                  if (fornitore.telefono.isNotEmpty) ...[
                    const Divider(indent: 56, endIndent: 16, height: 1),
                    InfoRow(
                      icon: Icons.phone_outlined,
                      label: l10n.commonPhone,
                      value: fornitore.telefono,
                    ),
                  ],
                ],
              ),
            ),
            const Divider(height: 32),
            if (_spese.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: Text(l10n.supplierNoneExpenses)),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _spese.length,
                itemBuilder: (context, index) {
                  final s = _spese[index];
                  return ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: Text(s.alimento),
                    subtitle: s.dettagli.isNotEmpty ? Text(s.dettagli) : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${s.dataOra.day.toString().padLeft(2, '0')}/${s.dataOra.month.toString().padLeft(2, '0')}/${s.dataOra.year}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          onPressed: () => _apriDialogSpesa(spesa: s),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _apriDialogSpesa(),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.supplierAddExpense),
      ),
    );
  }
}
