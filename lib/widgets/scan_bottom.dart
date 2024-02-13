import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/provider/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        // Quan es prem el botó, es crida aquesta funció
        print('Botó polsat!');

        // Escaneja el codi de barres
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        // Obté el proveïdor de la llista d'escanejos
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

        // Crea un nou model d'escaneig amb el valor escanejat
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);

        // Afegeix el nou escaneig a la llista
        scanListProvider.nouScan(barcodeScanRes);

        // Llança l'URL o obre la pantalla del mapa segons el tipus d'escaneig
        launchURL(context, nouScan);
      },
    );
  }
}
