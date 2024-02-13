import 'package:flutter/foundation.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);

    nouScan.id = id;

    if (nouScan.tipo == tipoSeleccionat) {
      scans.add(nouScan);
      notifyListeners();
    }

    return nouScan;
  }

  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];

    notifyListeners();
  }

  carregaScansPerTipo(String tipo) async {
    final scans = await DBProvider.db.getScanByTipo(tipo);
    this.scans = [...scans];
    
    this.tipoSeleccionat = tipo;

    notifyListeners();
  }

  esborraTots() async {
    final scans = await DBProvider.db.deleteAllScan();
    this.scans = [];
    
    notifyListeners();
  }

  esborraPerId(int id) async {
    await DBProvider.db.deleteScan(id);
    carregaScansPerTipo(tipoSeleccionat);

    notifyListeners();
  }
}