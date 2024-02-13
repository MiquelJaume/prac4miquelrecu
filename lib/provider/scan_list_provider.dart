import 'package:flutter/foundation.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = []; // Llista de scans
  String tipoSeleccionat = 'http'; // Tipus de scan seleccionat per defecte

  // Mètode per afegir un nou scan
  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor); // Crear un nou ScanModel
    final id = await DBProvider.db.insertScan(nouScan); // Insereix el scan a la base de dades

    nouScan.id = id; // Assigna l'ID del scan

    // Si el tipus del nou scan coincideix amb el tipus seleccionat
    if (nouScan.tipo == tipoSeleccionat) {
      scans.add(nouScan); // Afegir el nou scan a la llista
      notifyListeners(); // Notificar als widgets que han de ser actualitzats
    }

    return nouScan; // Retorna el nou scan
  }

  // Mètode per carregar tots els scans
  carregaScans() async {
    final scans = await DBProvider.db.getAllScans(); // Obté tots els scans de la base de dades
    this.scans = [...scans]; // Actualitza la llista de scans

    notifyListeners(); // Notificar als widgets que han de ser actualitzats
  }

  // Mètode per carregar scans per tipus
  carregaScansPerTipo(String tipo) async {
    final scans = await DBProvider.db.getScanByTipo(tipo); // Obté els scans pel tipus
    this.scans = [...scans]; // Actualitza la llista de scans
    this.tipoSeleccionat = tipo; // Actualitza el tipus seleccionat

    notifyListeners(); // Notificar als widgets que han de ser actualitzats
  }

  // Mètode per esborrar tots els scans
  esborraTots() async {
    await DBProvider.db.deleteAllScan(); // Esborra tots els scans de la base de dades
    this.scans = []; // Esborra tots els scans de la llista

    notifyListeners(); // Notificar als widgets que han de ser actualitzats
  }

  // Mètode per esborrar un scan per identificador
  esborraPerId(int id) async {
    await DBProvider.db.deleteScan(id); // Esborra el scan de la base de dades
    carregaScansPerTipo(tipoSeleccionat); // Recarrega els scans del mateix tipus

    notifyListeners(); // Notificar als widgets que han de ser actualitzats
  }
}
