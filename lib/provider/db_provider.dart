import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  // Obté la instància de la base de dades
  Future<Database> get database async {
    if(_database == null) _database = await initDB();

    return _database!;
  }

  // Inicialitza la base de dades
  Future<Database> initDB() async {
    // Obtenir el directori de documents de l'aplicació
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Obrir o crear la base de dades
    return await openDatabase(
      path,
      version: 1,
      onOpen:(db) {},
      onCreate: (Database db, int version) async {
        // Crear la taula Scans si no existeix
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );
  }

  // Insereix un escaneig a la base de dades utilitzant una consulta SQL bruta
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipo = nouScan.tipo;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES($id, $tipo, $valor)
    ''');

    return res;
  }

  // Insereix un escaneig a la base de dades utilitzant la classe ScanModel
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.insert('Scans', nouScan.toJson());

    print(res);

    return res;
  }

  // Obté tots els escaneigs de la base de dades
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  // Obté un escaneig per identificador de la base de dades
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromJson(res.first);
    } else {
      return null;
    }
  }

  // Obté escaneigs per tipus de la base de dades
  Future<List<ScanModel>> getScanByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  // Actualitza un escaneig a la base de dades
  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.update('Scans', nouScan.toJson(), where: 'id = ?', whereArgs: [nouScan.id]);

    return res;
  }

  // Esborra tots els escaneigs de la base de dades
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }

  // Esborra un escaneig per identificador de la base de dades
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }
}
