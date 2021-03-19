import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PostosSaudeMap extends StatefulWidget {
  @override
  _PostosSaudeMapState createState() => _PostosSaudeMapState();
}

class _PostosSaudeMapState extends State<PostosSaudeMap> {
  Completer<GoogleMapController> _controller = Completer();

  /// TODO Add Markers get data from all hospitals and Postos de Saude from Google API Places while checking DataSus API
  /// Document all this on the infrastructure document
  Iterable markers = [];

  @override
  void initState() {
    super.initState();
    getHealthInstitutionsGeo('-23.533773', '-46.625290');
  }

  getHealthInstitutionsGeo(String latitude, String longitude) async {

    var endpointUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    Map<String, String> queryParams = {
      'location': "$latitude,$longitude",
      'radius': '1500',
      'type': 'hospitals',
      'key': 'AIzaSyCPB41SY3hMIJZcBz1cePKI-cDnAdWgMjQ'
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = Uri.parse(endpointUrl + '?' + queryString);

    try{
      final response = await http.get(requestUrl);
      final int statusCode = response.statusCode;


      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(10, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);
          return Marker(
              markerId: MarkerId("marker$index"), position: latLngMarker);
        });

        setState(() {
          markers = _markers;
        });
      }else {
        throw Exception("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// HardCode Sao Paulo as Initial Geolocation
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.533773, -46.625290),
    ///target: LatLng(-33.8670522, 151.1957362),
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
        markers: Set.from(markers),
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
    getHealthInstitutionsGeo(position.latitude.toString(), position.longitude.toString());
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0
        ),
      ),
    );
  }

}