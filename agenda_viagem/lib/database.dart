import 'package:floor/floor.dart';
import 'package:agenda_viagem/trip_model.dart';

// Define the database and entities
part 'database.g.dart'; // This line is important!

@Database(version: 1, entities: [Trip])
abstract class AppDatabase extends FloorDatabase {
  TripDao get tripDao;
}

@dao
abstract class TripDao {
  @Query('SELECT * FROM Trip')
  Future<List<Trip>> findAllTrips();

  @Query('SELECT * FROM Trip WHERE id = :id')
  Future<Trip?> findTripById(int id);

  @insert
  Future<int> insertTrip(Trip trip);

  @update
  Future<int> updateTrip(Trip trip);

  @delete
  Future<int> deleteTrip(Trip trip);
}