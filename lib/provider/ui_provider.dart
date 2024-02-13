import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1; // Opció de menú seleccionada per defecte

  // Getter per a l'opció de menú seleccionada
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  // Setter per a l'opció de menú seleccionada
  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index; // Assigna el nou valor de l'opció de menú seleccionada
    notifyListeners(); // Notifica als widgets que han de ser actualitzats
  }
}
