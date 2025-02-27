import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference Form is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
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

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure ?? Location(name: '', country: Country.france);
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival ?? Location(name: '', country: Country.france);
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    _departureController.text = departure.name;
    _arrivalController.text = arrival.name;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
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

      // _departureController.text = departure.name.isNotEmpty ? departure.name : "Unknown";
      // _arrivalController.text = arrival.name.isNotEmpty ? arrival.name : "Unknown";
    });
  }

  // ----------------------------------
  // Handle form submission
  // ----------------------------------
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final ridePref = RidePref(
        departure: departure,
        departureDate: departureDate,
        arrival: arrival,
        requestedSeats: requestedSeats,
      );

      // Print the ride preference to the console
      print('Departure: ${ridePref.departure.name}');
      print('Departure Date: ${ridePref.departureDate.toLocal().toString().split(' ')[0]}');
      print('Arrival: ${ridePref.arrival.name}');
      print('Requested Seats: ${ridePref.requestedSeats}');

      Navigator.pop(context, ridePref);
    }
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TextFormField(
          //   controller: _departureController,
          //   decoration: InputDecoration(
          //     labelText: 'Departure Location',
          //     icon: Icon(Icons.location_on),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter a departure location';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     departure = Location(name: value!, country: Country.france);
          //   },
          // ),
          // TextFormField(
          //   controller: _arrivalController,
          //   decoration: InputDecoration(
          //     labelText: 'Arrival Location',
          //     icon: Icon(Icons.location_on),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter an arrival location';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     arrival = Location(name: value!, country: Country.france);
          //   },
          // ),
          TextFormField(
            controller: _departureController,
            decoration: InputDecoration(
              labelText: 'Departure Location',
              icon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a departure location';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                departure = Location(name: value, country: Country.france);
              });
            },
          ),
          TextFormField(
            controller: _arrivalController,
            decoration: InputDecoration(
              labelText: 'Arrival Location',
              icon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an arrival location';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                arrival = Location(name: value, country: Country.france);
              });
            },
          ),


          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Departure Date',
              icon: Icon(Icons.date_range),
            ),
            onTap: () => _selectDate(context),
            controller: TextEditingController(text: departureDate.toLocal().toString().split(' ')[0]),
          ),
          DropdownButtonFormField<int>(
            value: requestedSeats,
            decoration: InputDecoration(
              labelText: 'Requested Seats',
              icon: Icon(Icons.event_seat),
            ),
            items: List.generate(10, (index) => index + 1)
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
          ElevatedButton(
            onPressed: _switchLocations,
            child: Text('Switch Locations'),
          ),
          ElevatedButton(
            onPressed: _onSubmit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------
// Test the RidePrefForm
// ----------------------------------
class TestRidePrefForm extends StatelessWidget {
  const TestRidePrefForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test RidePrefForm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RidePrefForm(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: TestRidePrefForm()));
}