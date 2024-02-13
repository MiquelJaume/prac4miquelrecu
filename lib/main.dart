import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/screens/mapa_screen.dart';

import 'provider/scan_list_provider.dart';
import 'provider/ui_provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    // Proveïdors per a la gestió de l'estat de l'aplicació
    ChangeNotifierProvider(create: (_) => UIProvider()), // Proveïdor per a l'estat de la UI
    ChangeNotifierProvider(create: (_) => ScanListProvider()), // Proveïdor per a la llista d'escanejos
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home', // Ruta inicial de l'aplicació
      routes: {
        // Rutes de l'aplicació
        'home': (_) => HomeScreen(), // Ruta per a la pantalla principal
        'mapa': (_) => MapaScreen(), // Ruta per a la pantalla del mapa
      },
      theme: ThemeData(
        // Tema de l'aplicació
        colorScheme: ColorScheme.light().copyWith(
          primary: Color.fromARGB(255, 22, 149, 163), // Color primari de l'aplicació
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 22, 149, 163), // Color del botó d'acció flotant
        ),
      ),
    );
  }
}
