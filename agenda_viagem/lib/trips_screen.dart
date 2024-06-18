import 'package:agenda_viagem/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'trip_controller.dart';
import 'map.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Viagens'),
      ),
      body: GetX<TripController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.trips.length,
            itemBuilder: (context, index) {
              Trip trip = controller.trips[index];
              final tripDateTime = DateTime.fromMillisecondsSinceEpoch(trip.date);
              return ListTile(
                title: Text(trip.destination),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(tripDateTime)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Map(destination: trip.destination),
                    ),
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}
