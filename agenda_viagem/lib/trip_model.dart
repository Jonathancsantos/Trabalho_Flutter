// In trip_model.dart

class Trip {
  int? id;
  final String destination;
  final DateTime date;
  final String notes;

  Trip({required this.destination, required this.date, this.notes = ''});

  // This method converts the Trip object to a Map for SQFlite
  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'date': date.toString(), // Convert DateTime to String for SQFlite
      'notes': notes,
    };
  }
}
