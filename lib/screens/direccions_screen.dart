import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retorna el widget ScanTiles amb el tipus 'http' per mostrar escaneigs de direccions
    return ScanTiles(tipo: 'http');
  }
}
