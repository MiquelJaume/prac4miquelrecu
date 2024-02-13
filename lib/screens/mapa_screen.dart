import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // Obté el model d'escaneig dels arguments passats
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    // Defineix la posició inicial de la càmera basada en la ubicació de l'escaneig
    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    // Defineix els marcadors a mostrar en el mapa
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(markerId: MarkerId('id1'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
  
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.gps_fixed),
            onPressed: () {
              // Centra el mapa a la posició inicial
              _goToInitialPosition(_puntInicial);
            },
          ),
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: _currentMapType,
        markers: markers,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      // Botó flotant per canviar el tipus de mapa
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentMapType =
                _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
          });
        },
        child: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  // Mètode per moure la càmera a la posició inicial
  void _goToInitialPosition(CameraPosition _puntInicial) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_puntInicial));
  }
}
