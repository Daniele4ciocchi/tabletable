import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/dati_screen.dart';

import '../widgets/navbar.dart';
import 'lista_prenotazioni_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    DatiScreen(),
    ListaPrenotazioniScreen(),
    Center(child: Text('Impostazioni')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TableTable')),
      body: _pages[_currentIndex],
      bottomNavigationBar: MyNavbar(
        selectedIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
