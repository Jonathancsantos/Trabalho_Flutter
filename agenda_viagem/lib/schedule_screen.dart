import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'trip_model.dart';
import 'trip_controller.dart';
import 'package:get/get.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  var _selectedDate = DateTime.now();
  final TripController _tripController = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Viagem'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destino'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o destino da viagem.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(labelText: 'Data da Viagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data da viagem.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Observações'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTrip();
                    Navigator.pop(context);
                  }
                },
                child: Text('Agendar Viagem'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
    }
  }

  void _addTrip() {
    final newTrip = Trip(
      destination: _destinationController.text,
      date: _selectedDate,
      notes: _notesController.text,
    );
    _tripController.addTrip(newTrip);
  }
}
