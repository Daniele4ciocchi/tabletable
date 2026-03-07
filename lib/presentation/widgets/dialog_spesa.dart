import 'package:flutter/material.dart';
import 'package:tabletable/data/models/spesa.dart';
import 'package:tabletable/l10n/app_localizations.dart';

/// Mostra un dialog per aggiungere o modificare una [Spesa].
/// Restituisce la [Spesa] compilata, oppure `null` se annullato.
Future<Spesa?> showDialogSpesa(BuildContext context, {Spesa? spesa}) {
  return showDialog<Spesa>(
    context: context,
    builder: (_) => _DialogSpesa(spesa: spesa),
  );
}

class _DialogSpesa extends StatefulWidget {
  final Spesa? spesa;

  const _DialogSpesa({this.spesa});

  @override
  State<_DialogSpesa> createState() => _DialogSpesaState();
}

class _DialogSpesaState extends State<_DialogSpesa> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _alimentoController;
  late final TextEditingController _dettagliController;
  late final TextEditingController _prezzoController;

  bool get _isModifica => widget.spesa != null;

  @override
  void initState() {
    super.initState();
    _alimentoController = TextEditingController(
      text: widget.spesa?.alimento ?? '',
    );
    _dettagliController = TextEditingController(
      text: widget.spesa?.dettagli ?? '',
    );
    _prezzoController = TextEditingController(
      text: widget.spesa?.prezzo?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void dispose() {
    _alimentoController.dispose();
    _dettagliController.dispose();
    _prezzoController.dispose();
    super.dispose();
  }

  void _conferma() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Spesa(
        id: widget.spesa?.id,
        fornitore: widget.spesa?.fornitore,
        alimento: _alimentoController.text.trim(),
        dettagli: _dettagliController.text.trim(),
        prezzo: double.tryParse(_prezzoController.text.trim()),
        dataOra: widget.spesa?.dataOra ?? DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(_isModifica ? l10n.expenseDialogEdit : l10n.expenseDialogNew),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _alimentoController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.expenseFood,
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.expenseRequired : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _dettagliController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.expenseDetailsOptional,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prezzoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.expensePriceOptional,
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return double.tryParse(v.trim()) == null
                    ? l10n.expensePriceInvalid
                    : null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _conferma,
          child: Text(_isModifica ? l10n.commonSave : l10n.commonAdd),
        ),
      ],
    );
  }
}
