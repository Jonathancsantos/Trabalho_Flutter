import 'package:get/get.dart';
import 'package:agenda_viagem/trip_model.dart';
import 'package:agenda_viagem/database.dart'; // Import the database

class TripController extends GetxController {
  final AppDatabase _database; // Store the database instance

  var trips = <Trip>[].obs; // Observable list to hold trips

  TripController(this._database); // Constructor to receive the database

  @override
  void onInit() {
    super.onInit();
    _loadTrips(); // Load trips from the database on initialization
  }

  Future<void> _loadTrips() async {
    trips.value = await _database.tripDao.findAllTrips(); // Load trips
  }

  void addTrip(Trip trip) async {
    await _database.tripDao.insertTrip(trip); // Insert the trip into the database
    _loadTrips(); // Update the list of trips
  }

  void deleteTrip(Trip trip) async {
    await _database.tripDao.deleteTrip(trip); // Delete from database
    _loadTrips(); // Update the list of trips
  }
  // ... add other methods for updating trips, etc.
}