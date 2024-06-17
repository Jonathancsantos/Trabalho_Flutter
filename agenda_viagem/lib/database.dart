import 'dart:async';
import 'package:floor/floor.dart';
import 'package:agenda_viagem/trip_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:floor_annotation/src/database.dart' as floor;
import 'package:sqflite_common/sqlite_api.dart' as sqflite;

// Define the database and entities
part 'database.g.dart'; // This line is important!

const List<Type> trips = [Trip];

@floor.Database(version: 1, entities: trips)
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