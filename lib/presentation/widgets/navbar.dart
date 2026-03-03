import 'package:flutter/material.dart';

/// Barra di navigazione inferiore dell'app.
///
/// È un widget **stateless**: non gestisce internamente l'indice selezionato.
/// Lo stato viene mantenuto dal genitore ([HomeScreen]) e passato tramite
/// [selectedIndex]; i cambi di tab vengono notificati tramite [onTap].
class MyNavbar extends StatelessWidget {
  /// Indice della tab attualmente selezionata (0 = Home, 1 = Prenotazioni, 2 = Impostazioni).
  final int selectedIndex;

  /// Callback invocata quando l'utente preme una tab.
  /// Riceve l'indice della tab premuta come parametro.
  final ValueChanged<int> onTap;

  const MyNavbar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Theme.of(context).colorScheme.primary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Prenotazioni',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_rounded),
          label: 'Fornitori',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Cibi'),
      ],
    );
  }
}
