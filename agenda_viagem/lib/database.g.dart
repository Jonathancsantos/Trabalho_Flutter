// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TripDao? _tripDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Trip` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `destination` TEXT NOT NULL, `date` TEXT NOT NULL, `notes` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TripDao get tripDao {
    return _tripDaoInstance ??= _$TripDao(database, changeListener);
  }
}

class _$TripDao extends TripDao {
  _$TripDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tripInsertionAdapter = InsertionAdapter(
            database,
            'Trip',
            (Trip item) => <String, Object?>{
                  'id': item.id,
                  'destination': item.destination,
                  'date': item.date,
                  'notes': item.notes
                }),
        _tripUpdateAdapter = UpdateAdapter(
            database,
            'Trip',
            ['id'],
            (Trip item) => <String, Object?>{
                  'id': item.id,
                  'destination': item.destination,
                  'date': item.date,
                  'notes': item.notes
                }),
        _tripDeletionAdapter = DeletionAdapter(
            database,
            'Trip',
            ['id'],
            (Trip item) => <String, Object?>{
                  'id': item.id,
                  'destination': item.destination,
                  'date': item.date,
                  'notes': item.notes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Trip> _tripInsertionAdapter;

  final UpdateAdapter<Trip> _tripUpdateAdapter;

  final DeletionAdapter<Trip> _tripDeletionAdapter;

  @override
  Future<List<Trip>> findAllTrips() async {
    return _queryAdapter.queryList('SELECT * FROM Trip',
        mapper: (Map<String, Object?> row) => Trip(
            id: row['id'] as int,
            destination: row['destination'] as String,
            date: row['date'] as String,
            notes: row['notes'] as String));
  }

  @override
  Future<Trip?> findTripById(int id) async {
    return _queryAdapter.query('SELECT * FROM Trip WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Trip(
            id: row['id'] as int,
            destination: row['destination'] as String,
            date: row['date'] as String,
            notes: row['notes'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertTrip(Trip trip) {
    return _tripInsertionAdapter.insertAndReturnId(
        trip, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTrip(Trip trip) {
    return _tripUpdateAdapter.updateAndReturnChangedRows(
        trip, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTrip(Trip trip) {
    return _tripDeletionAdapter.deleteAndReturnChangedRows(trip);
  }
}
