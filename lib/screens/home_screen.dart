import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/provider/scan_list_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

import '../provider/db_provider.dart';
import '../provider/ui_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              // Esborra tots els escanejos quan es fa clic a l'icona de la paperera
              Provider.of<ScanListProvider>(context, listen: false).esborraTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    // Inicia la base de dades quan es mostra el cos de la pantalla principal
    DBProvider.db.database;

    // Comutador per canviar entre les pantalles basat en l'índex actual seleccionat
    switch (currentIndex) {
      case 0:
        // Carrega els escanejos de tipus 'geo' i mostra la pantalla de mapes
        scanListProvider.carregaScansPerTipo('geo');
        return MapasScreen();
      case 1:
        // Carrega els escanejos de tipus 'http' i mostra la pantalla de direccions
        scanListProvider.carregaScansPerTipo('http');
        return DireccionsScreen();
      default:
        // Per defecte, carrega els escanejos de tipus 'geo' i mostra la pantalla de mapes
        scanListProvider.carregaScansPerTipo('geo');
        return MapasScreen();
    }
  }
}
