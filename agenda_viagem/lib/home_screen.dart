import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'schedule_screen.dart';
import 'trips_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Viagens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Organize suas viagens com facilidade!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Planeje, agende e gerencie suas viagens em um só lugar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Get.to(ScheduleScreen());
                  },
                  child: Text('Agendar Viagem'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(TripsScreen());
                  },
                  child: Text('Minhas Viagens'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
