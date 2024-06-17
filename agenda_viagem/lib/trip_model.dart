import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

@entity
class Trip {
  @PrimaryKey(autoGenerate: true)
  final int id; // Adicione um ID para a entidade

  final String destination;
  final String date;
  final String notes;

  Trip({
    required this.id, // Inclua o ID no construtor
    required this.destination,
    required this.date,
    required this.notes,
  });
}