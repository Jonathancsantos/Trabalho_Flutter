import 'package:get/get.dart';
import 'trip_model.dart';

class TripController extends GetxController {
  var trips = <Trip>[].obs;

  void addTrip(Trip trip) {
    trips.add(trip);
  }
}
