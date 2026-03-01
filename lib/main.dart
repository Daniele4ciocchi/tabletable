import 'package:flutter/material.dart';
import 'package:tabletable/screens/lista_prenotazioni.dart';
import 'widgets/navbar.dart'; // import del widget della navbar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTable',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomePage(),
    );
  }
}

// Schermata principale
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
    const ListaPrenotazioni(), // Schermata delle prenotazioni
    const Center(child: Text("Prenotazioni")),
    const Center(child: Text("Impostazioni")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TableTable")),
      body: _pages[_currentIndex], // Mostra la schermata corrente
      bottomNavigationBar: MyNavbar(
        selectedIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // cambia tab
          });
        },
      ),
    );
  }
}
