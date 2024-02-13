import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/scan_list_provider.dart';
import '../utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  final String tipo; // Tipus d'escaneig que es mostra en aquesta llista

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context); // Obté el proveïdor de la llista d'escanejos
    final scans = scanListProvider.scans; // Obté la llista d'escanejos

    return ListView.builder(
      itemCount: scans.length, // Nombre total d'elements a mostrar
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(), // Clau única per a cada element de la llista
        background: Container(
          color: Colors.red, // Color del fons de l'acció de deslizar
          child: Align(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete_forever), // Icona d'eliminar
            )
          ),
          alignment: Alignment.centerRight, // Alineació de l'acció de deslizar
        ),
        onDismissed: (DismissDirection direccio) {
          // Esborra l'escaneig quan es desliza cap a la dreta o cap a l'esquerra
          Provider.of<ScanListProvider>(context, listen: false).esborraPerId(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined, // Icona segons el tipus d'escaneig
          ),
          title: Text(scans[index].valor), // Text principal de l'escaneig
          subtitle: Text(scans[index].id.toString()), // Text secundari de l'escaneig (ID)
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,), // Icona de navegació cap a la dreta
          onTap: () {
            // Acció que es realitza quan es fa clic a l'element de la llista
            launchURL(context, scans[index]); // Llança l'URL o obre la pantalla del mapa segons el tipus d'escaneig
          },
        ),
      )
    );
  }
}
