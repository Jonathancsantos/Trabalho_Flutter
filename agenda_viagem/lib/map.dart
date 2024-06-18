import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Map extends StatefulWidget {
  final String destination;

  Map({required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<Map> {
  late GoogleMapController mapController;
  LatLng? _center;
  final String apiKey =
      "AIzaSyCSU7q7Ww2akGYE1LAcVwHxC-5NktibGI8"; // Substitua pela sua chave de API

  @override
  void initState() {
    super.initState();
    _getLatLngFromDestination(widget.destination);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getLatLngFromDestination(String destination) async {
    final String endpoint =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$destination&key=$apiKey';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'][0];
      final geometry = results['geometry'];
      final location = geometry['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];

      setState(() {
        _center = LatLng(lat, lng);
      });
    } else {
      throw Exception('Failed to load coordinates for the destination');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination),
      ),
      body: _center == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center!,
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.destination),
            position: _center!,
          ),
        },
      ),
    );
  }
}
