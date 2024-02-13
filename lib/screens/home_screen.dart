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

    final scanListProvidre = Provider.of<ScanListProvider>(context, listen: false);



    DBProvider.db.database;



    switch (currentIndex) {
      case 0:
        scanListProvidre.carregaScansPerTipo('geo');

        return MapasScreen();
      case 1:
        scanListProvidre.carregaScansPerTipo('http');

        return DireccionsScreen();
      default:
        scanListProvidre.carregaScansPerTipo('geo');

        return MapasScreen();
    }
  }
}
