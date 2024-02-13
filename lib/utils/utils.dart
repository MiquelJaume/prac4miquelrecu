import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

// Funció per llançar una URL o obrir la pantalla del mapa depenent del tipus d'escaneig
void launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor; // Obté la URL de l'escaneig
  
  if (scan.tipo == 'http') {
    // Si el tipus d'escaneig és 'http', intenta obrir la URL en un navegador
    if (!await launch(url)) throw 'Could not launch $url';
  } else {
    // Si el tipus d'escaneig no és 'http', obre la pantalla del mapa amb les dades de l'escaneig
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
