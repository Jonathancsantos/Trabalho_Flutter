import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  TextEditingController _searchController = TextEditingController();
  LatLng? _selectedLocation;

  final Map<String, LatLng> citiesCoordinates = {
    "Canela": LatLng(-29.3620, -50.8165),
    "Gramado": LatLng(-29.3747, -50.8765),
    "Florianopolis": LatLng(-27.5954, -48.5480),
    "Santa Maria": LatLng(-29.6864, -53.8069),
    "Rio Grande": LatLng(-32.0372, -52.0986),
    "Passo Fundo": LatLng(-28.2639, -52.4047),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _searchCity(String cityName) {
    final cityCoordinates = citiesCoordinates[cityName];
    if (cityCoordinates != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(cityCoordinates, 10),
      );
      setState(() {
        _selectedLocation = cityCoordinates;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cidade não encontrada.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS-Guri Personalizado south'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Digite o nome da cidade',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchCity(_searchController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-30.0331, -51.23), // Porto Alegre
                zoom: 7,
              ),
              markers: _selectedLocation != null
                  ? {
                      Marker(
                        markerId: MarkerId('selected-location'),
                        position: _selectedLocation!,
                        infoWindow: InfoWindow(
                          title: 'Cidade Selecionada',
                        ),
                      ),
                    }
                  : {},
            ),
          ),
        ],
      ),
    );
  }
}