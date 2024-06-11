import 'package:agenda_viagem/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'trip_model.dart';
import 'trip_controller.dart';
import 'package:get/get.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final TripController _tripController = Get.put(TripController());

  @override
  void initState() {
    super.initState();
    _loadTripsFromDatabase();
  }

  Future<void> _loadTripsFromDatabase() async {
    final db = await _database; // Get the database instance

    if (db == null) {
      print('Error: Database is null');
      return; // Handle the case where the database is not available
    }

    final results = await db.query('trips'); // Query the trips table

    _tripController.trips.clear(); // Clear the existing trips list

    for (final row in results) {
      final trip = Trip.fromMap(row); // Convert each row to a Trip object
      _tripController.trips.add(trip); // Add the trip to the TripController
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Viagens'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the ScheduleScreen for adding trips
              Get.to(ScheduleScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        return _tripController.trips.isEmpty
            ? Center(
                child: Text('Você ainda não possui viagens cadastradas.'),
              )
            : ListView.builder(
                itemCount: _tripController.trips.length,
                itemBuilder: (context, index) {
                  Trip trip = _tripController.trips[index] as Trip;
                  return ListTile(
                    title: Text(trip.destination),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(trip.date)),
                    onTap: () {
                      _launchMaps(trip.destination);
                    },
                  );
                },
              );
      }),
    );
  }

  void _launchMaps(String destination) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(destination)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Trip {
  int? id;
  final String destination;
  final DateTime date;
  final String notes;

  Trip({required this.destination, required this.date, this.notes = '', required int id});

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as int,
      destination: map['destination'] as String,
      date: DateTime.parse(map['date'] as String),
      notes: map['notes'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'date': date.toString(),
      'notes': notes,
    };
  }
}
