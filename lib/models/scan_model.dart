import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  int? id;
  String? tipo; // Tipus d'escaneig (http o geo)
  String valor; // Valor escanejat

  // Constructor de la classe ScanModel
  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    // Verifiquem si el valor conté 'http' per determinar el tipus
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  // Mètode per obtenir un objecte LatLng a partir del valor escanejat
  LatLng getLatLng() {
    if (valor.contains('geo')) {
      // Si el valor conté 'geo', en traiem latitud i longitud
      final latLng = valor.substring(4).split(',');
      final latitude = double.parse(latLng[0]);
      final longitude = double.parse(latLng[1]);

      return LatLng(latitude, longitude); // Retornar LatLng
    } else {
      // Si no conté 'geo', retornem una ubicació per defecte
      return const LatLng(39.566303, 2.649170);
    }
  }

  // Mètode de fàbrica per crear una instància de ScanModel des de JSON
  factory ScanModel.fromRawJson(String str) =>
      ScanModel.fromJson(json.decode(str));

  // Mètode per convertir ScanModel a JSON
  String toRawJson() => json.encode(toJson());

  // Mètode de fàbrica per crear una instància de ScanModel des d'un mapa JSON
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  // Mètode per convertir ScanModel a un mapa JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
