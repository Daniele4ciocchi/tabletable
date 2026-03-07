import 'package:flutter/material.dart';
import 'package:tabletable/data/models/fornitore.dart';
import 'package:tabletable/l10n/app_localizations.dart';

/// Apre la schermata di aggiunta e restituisce la [Fornitore] inserita,
/// oppure `null` se l'utente torna indietro senza confermare.
Future<Fornitore?> apriSchermataAggiungiFornitore(BuildContext context) {
  return Navigator.push<Fornitore>(
    context,
    MaterialPageRoute(builder: (_) => FornitoreFormScreen()),
  );
}

/// Apre la schermata di modifica e restituisce la [Fornitore] modificata,
/// oppure `null` se l'utente torna indietro senza confermare.
Future<Fornitore?> apriSchermataModificaFornitore(
  BuildContext context,
  Fornitore fornitore,
) {
  return Navigator.push<Fornitore>(
    context,
    MaterialPageRoute(
      builder: (_) => FornitoreFormScreen(fornitore: fornitore),
    ),
  );
}

/// Schermata unificata per aggiungere o modificare una prenotazione.
///
/// Se [prenotazione] è `null` si è in modalità aggiunta; altrimenti modifica.
class FornitoreFormScreen extends StatefulWidget {
  final Fornitore? fornitore;

  const FornitoreFormScreen({super.key, this.fornitore});

  @override
  State<FornitoreFormScreen> createState() => _FornitoreFormScreenState();
}

class _FornitoreFormScreenState extends State<FornitoreFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descrizioneController = TextEditingController();
  final _telefonoController = TextEditingController();

  bool get _isModifica => widget.fornitore != null;

  @override
  void initState() {
    super.initState();
    final f = widget.fornitore;
    _nomeController.text = f?.nome ?? '';
    _descrizioneController.text = f?.descrizione ?? '';
    _telefonoController.text = f?.telefono ?? '';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descrizioneController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _conferma() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Fornitore(
        id: widget.fornitore?.id,
        nome: _nomeController.text.trim(),
        descrizione: _descrizioneController.text.trim(),
        telefono: _telefonoController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_isModifica ? l10n.supplierFormEdit : l10n.supplierFormNew),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: l10n.commonName,
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.supplierNameRequired
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descrizioneController,
                decoration: InputDecoration(
                  labelText: l10n.commonDescription,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(
                  labelText: l10n.commonPhone,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _conferma,
                child: Text(_isModifica ? l10n.commonSave : l10n.commonAdd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
