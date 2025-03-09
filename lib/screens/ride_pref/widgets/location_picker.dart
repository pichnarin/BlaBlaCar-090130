import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../service/locations_repository.dart';

class LocationPicker extends StatefulWidget {
  final LocationsRepository repository;

  const LocationPicker({super.key, required this.repository});

  @override
  LocationPickerState createState() => LocationPickerState();
}

class LocationPickerState extends State<LocationPicker> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _searchResults = [];

  void _searchLocations(String query) {
    setState(() {
      _searchResults = widget.repository.getLocations()
          .where((location) => location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Location',
                icon: Icon(Icons.search),
              ),
              onChanged: _searchLocations,
            ),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final location = _searchResults[index];
                  return ListTile(
                    title: Text(location.name),
                    onTap: () {
                      Navigator.pop(context, location); // Return the selected location
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

