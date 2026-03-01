import 'package:flutter/material.dart';

class DynamicWidget extends StatefulWidget {
  const DynamicWidget({super.key});

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  // Lista interna
  final List<String> _items = ['Elemento 1', 'Elemento 2', 'Elemento 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.star),
                title: Text(_items[index]),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Mostra una nuova schermata per inserire testo
          final String? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );

          // Se l'utente ha inserito qualcosa, aggiungilo alla lista
          if (result != null && result.isNotEmpty) {
            setState(() {
              _items.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Schermata per aggiungere un nuovo elemento
class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aggiungi elemento")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Scrivi qualcosa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ritorna il testo inserito alla schermata precedente
                Navigator.pop(context, _controller.text);
              },
              child: const Text("Aggiungi"),
            ),
          ],
        ),
      ),
    );
  }
}
