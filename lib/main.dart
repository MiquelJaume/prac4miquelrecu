import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/screens/mapa_screen.dart';

import 'provider/scan_list_provider.dart';
import 'provider/ui_provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => UIProvider()),
    ChangeNotifierProvider(create: (_) => ScanListProvider()),
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mapa': (_) => MapaScreen(),
      },
      theme: ThemeData(
        // Estils
        colorScheme: ColorScheme.light().copyWith(
          primary: Color.fromARGB(255, 22, 149, 163),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 22, 149, 163),
        ),
      ),
    );
  }
}
