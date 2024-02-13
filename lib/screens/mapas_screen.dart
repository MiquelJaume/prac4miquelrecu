import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retorna el widget ScanTiles amb el tipus 'geo' per mostrar escanejos de mapes
    return ScanTiles(tipo: 'geo');
  }
}
