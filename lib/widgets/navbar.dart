import 'package:flutter/material.dart';

// Widget per la navbar in basso
class MyNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const MyNavbar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: "Prenotazioni",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Impostazioni",
        ),
      ],
    );
  }
}
