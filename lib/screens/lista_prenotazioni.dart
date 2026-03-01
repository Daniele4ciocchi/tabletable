import 'package:flutter/material.dart';
import '../database/database.dart';
import '../model/prenotazione.dart';

class ListaPrenotazioni extends StatefulWidget {
  const ListaPrenotazioni({super.key});

  @override
  State<ListaPrenotazioni> createState() => _ListaPrenotazioniState();
}

class _ListaPrenotazioniState extends State<ListaPrenotazioni> {
  List<Prenotazione> _listaPrenotazioni = [];

  @override
  void initState() {
    super.initState();
    _caricaPrenotazioni();
  }

  void _caricaPrenotazioni() async {
    final lista = await PrenotazioniDatabase.instance.readAllPrenotazioni();
    setState(() {
      _listaPrenotazioni = lista;
    });
  }

  void _eliminaPrenotazione(int id) async {
    await PrenotazioniDatabase.instance.deletePrenotazione(id);
    _caricaPrenotazioni(); // aggiorna la lista dopo l'eliminazione
  }

  Future<void> _aggiungiPrenotazione() async {
    final nomeController = TextEditingController();
    final personeController = TextEditingController();

    final risultato = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuova prenotazione'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: personeController,
                decoration: const InputDecoration(labelText: 'Numero persone'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Aggiungi'),
            ),
          ],
        );
      },
    );

    if (risultato != true) {
      return;
    }

    final nome = nomeController.text.trim();
    final numeroPersone = int.tryParse(personeController.text.trim()) ?? 0;

    if (nome.isEmpty || numeroPersone <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inserisci dati validi')));
      return;
    }

    final nuovaPrenotazione = Prenotazione(
      nome: nome,
      numeroPersone: numeroPersone,
      dataOra: DateTime.now(),
    );

    await PrenotazioniDatabase.instance.createPrenotazione(nuovaPrenotazione);
    _caricaPrenotazioni();
  }

  @override
  Widget build(BuildContext context) {
    final body = _listaPrenotazioni.isEmpty
        ? const Center(child: Text('Nessuna prenotazione'))
        : ListView.builder(
            itemCount: _listaPrenotazioni.length,
            itemBuilder: (context, index) {
              final pren = _listaPrenotazioni[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(pren.nome),
                  subtitle: Text(
                    '${pren.numeroPersone} persone - ${pren.dataOra.toLocal()}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _eliminaPrenotazione(pren.id!),
                  ),
                ),
              );
            },
          );

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: _aggiungiPrenotazione,
        tooltip: 'Aggiungi prenotazione',
        child: const Icon(Icons.add),
      ),
    );
  }
}
