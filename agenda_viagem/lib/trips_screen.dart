import 'package:agenda_viagem/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'trip_model.dart';
import 'trip_controller.dart';
import 'package:get/get.dart';

class TripsScreen extends StatelessWidget {
  final TripController _tripController = Get.find<TripController>(); // Get the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Viagens'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ScheduleScreen()); // Navigate to ScheduleScreen
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
            final trip = _tripController.trips[index];
            final tripDateTime = DateTime.fromMillisecondsSinceEpoch(trip.date);
            return ListTile(
              title: Text(trip.destination),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(tripDateTime)),
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