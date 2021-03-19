import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostosSaudeMap extends StatefulWidget {
  @override
  _PostosSaudeMapState createState() => _PostosSaudeMapState();
}

class _PostosSaudeMapState extends State<PostosSaudeMap> {
  Completer<GoogleMapController> _controller = Completer();

  /// TODO Add Markers get data from all hospitals and Postos de Saude from Google API Places while checking DataSus API
  /// Document all this on the infrastructure document

  /// HardCode Sao Paulo as Initial Geolocation
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.533773, -46.625290),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getCurrentLocation,
        label: Text('Postos mais pertos'),
        icon: Icon(Icons.center_focus_strong_outlined),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0
        ),
      ),
    );
  }

}