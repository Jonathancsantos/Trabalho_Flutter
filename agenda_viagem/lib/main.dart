import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trip_controller.dart';
import 'schedule_screen.dart';
import 'trips_screen.dart';
import 'home_screen.dart';
import 'database.dart'; // Import your database file

void main() async { // Use `async` to wait for the database initialization
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before calling async operations
  final database = await $FloorAppDatabase.databaseBuilder('trips.db').build(); // Initialize the database
  Get.put(TripController(database)); // Pass the database to the TripController

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App de Viagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/schedule', page: () => ScheduleScreen()),
        GetPage(name: '/trips', page: () => TripsScreen()),
      ],
    );
  }
}