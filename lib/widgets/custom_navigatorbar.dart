import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obté el proveïdor d'estat UIProvider per gestionar l'estat del menú seleccionat
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt; // Índex de l'element seleccionat

    // Retorna un widget BottomNavigationBar per gestionar la navegació
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i, // Gestiona les pulsacions a la barra de navegació
      elevation: 0, // Elevació de la barra de navegació
      currentIndex: currentIndex, // Índex de l'element seleccionat
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map), // Icona per a la pestanya de mapes
          label: 'Mapa', // Etiqueta per a la pestanya de mapes
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration), // Icona per a la pestanya de direccions
          label: 'Direccions', // Etiqueta per a la pestanya de direccions
        )
      ],
    );
  }
}
