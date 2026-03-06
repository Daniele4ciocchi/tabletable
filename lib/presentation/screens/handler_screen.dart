import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/lista_fornitori_screen.dart';
import 'package:tabletable/presentation/screens/dati_screen.dart';
import 'package:tabletable/presentation/screens/settings.dart';
import 'package:tabletable/presentation/screens/spese_screen.dart';

import '../widgets/navbar.dart';
import 'lista_prenotazioni_screen.dart';

class HandlerScreen extends StatefulWidget {
  const HandlerScreen({super.key});

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    DatiScreen(),
    ListaPrenotazioniScreen(),
    FornitoriScreen(),
    SpeseScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TableTable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Impostazioni',
            onPressed: () => openSettings(context),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: MyNavbar(
        selectedIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
