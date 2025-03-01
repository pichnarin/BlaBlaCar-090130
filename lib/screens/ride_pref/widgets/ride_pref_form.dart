import 'package:flutter/material.dart';
import 'package:untitled/screens/ride_pref/widgets/location_picker.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  final _formKey = GlobalKey<FormState>();
  late Location departure;
  late DateTime departureDate;
  late Location arrival;
  late int requestedSeats;

  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure ?? Location(name: '', country: Country.france);
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival ?? Location(name: '', country: Country.france);
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    _departureController.text = departure.name;
    _arrivalController.text = arrival.name;
    _dateController.text = departureDate.toLocal().toString().split(' ')[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
        _dateController.text = departureDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;

      _departureController.text = departure.name;
      _arrivalController.text = arrival.name;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final ridePref = RidePref(
        departure: departure,
        departureDate: departureDate,
        arrival: arrival,
        requestedSeats: requestedSeats,
      );

      print('Departure: ${ridePref.departure.name}');
      print('Departure Date: ${ridePref.departureDate.toLocal().toString().split(' ')[0]}');
      print('Arrival: ${ridePref.arrival.name}');
      print('Requested Seats: ${ridePref.requestedSeats}');

      Navigator.pop(context, ridePref);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ride Preference Form')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextFormField(
                controller: _departureController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Departure Location',
                  icon: Icon(Icons.location_on),
                ),
                onTap: () async {
                  final selectedLocation = await Navigator.push<Location>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPicker(),
                    ),
                  );

                  if (selectedLocation != null) {
                    setState(() {
                      departure = selectedLocation;
                      _departureController.text = selectedLocation.name;
                    });
                  }
                },
              ),

              SizedBox(height: 8),

              TextFormField(
                controller: _arrivalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Arrival Location',
                  icon: Icon(Icons.location_on),
                ),
                onTap: () async {
                  final selectedLocation = await Navigator.push<Location>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPicker(),
                    ),
                  );

                  if (selectedLocation != null) {
                    setState(() {
                      arrival = selectedLocation;
                      _arrivalController.text = selectedLocation.name;
                    });
                  }
                },
              ),

              SizedBox(height: 8),

              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Departure Date',
                  icon: Icon(Icons.date_range),
                ),
                onTap: () => _selectDate(context),
              ),

              SizedBox(height: 8),

              DropdownButtonFormField<int>(
                value: requestedSeats,
                decoration: InputDecoration(
                  labelText: 'Requested Seats',
                  icon: Icon(Icons.event_seat),
                ),
                items: List.generate(4, (index) => index + 1)
                    .map((value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    requestedSeats = value!;
                  });
                },
              ),

              SizedBox(height: 16),

              if (_departureController.text.isNotEmpty && _arrivalController.text.isNotEmpty)
                ElevatedButton(
                  onPressed: _switchLocations,
                  child: Text('Switch Locations'),
                ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RidePrefForm(),
  ));
}