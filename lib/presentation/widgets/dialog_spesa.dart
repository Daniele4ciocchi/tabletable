import 'package:flutter/material.dart';
import 'package:tabletable/data/models/spesa.dart';

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
    return AlertDialog(
      title: Text(_isModifica ? 'Modifica spesa' : 'Nuova spesa'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _alimentoController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Alimento',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _dettagliController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Dettagli (opzionale)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prezzoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prezzo (opzionale)',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return double.tryParse(v.trim()) == null
                    ? 'Inserisci un valore numerico valido'
                    : null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        FilledButton(
          onPressed: _conferma,
          child: Text(_isModifica ? 'Salva' : 'Aggiungi'),
        ),
      ],
    );
  }
}
