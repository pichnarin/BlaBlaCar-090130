

import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {

  static const List<Location> availableLocations = fakeLocations;   // TODO for now fake data

  List<Location> getLocationsByName(String name){
    return availableLocations.where((location) => location.name.toLowerCase().contains(name.toLowerCase())).toList();
  }
 
}