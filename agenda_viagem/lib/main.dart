import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'trip_controller.dart';
import 'schedule_screen.dart';
import 'trips_screen.dart';
import 'home_screen.dart';

void main() {
  Get.put(TripController()); // Inicializa o controlador de viagens
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
