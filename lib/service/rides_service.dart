
import 'package:untitled/service/rides_reposistory.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - The list of available rides
///
// class RidesService {
//
//   static List<Ride> availableRides = fakeRides;   // TODO for now fake data
//
//   List<Ride> getRides(){
//     return availableRides;
//   }
//
//   List<Ride> getRideByDate(DateTime date){
//     return availableRides.where((ride) =>
//     ride.departureDate.day == date.day
//         && ride.departureDate.month == date.month
//         && ride.departureDate.year == date.year).toList();
//   }
//   ///
//   ///  Return the relevant rides, given the passenger preferences
//   ///
//   static List<Ride> getRidesFor(RidePref preferences) {
//     //  print(availableRides);
//
//     // For now, just a test
//     return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
//   }
//
// }

class RidesService {
  static final RidesService _instance = RidesService._internal();
  late RidesRepository _repository;

  RidesService._internal();

  factory RidesService() {
    return _instance;
  }


  void initialize(RidesRepository repository) {
    _repository = repository;
  }

  List<Ride> getRides(RidePref preference, RidesFilter? filter) {
    return _repository.getRides(preference, filter);
  }

  List<Ride> getRideByDate(DateTime date){
    return availableRides.where((ride) =>
    ride.departureDate.day == date.day
        && ride.departureDate.month == date.month
        && ride.departureDate.year == date.year).toList();
  }

  List<Ride> get availableRides {
    return _repository.getAvailableRides();
  }
}

class RidesFilter {
  final bool petAccepted;

  RidesFilter({required this.petAccepted});
}

void main() {
  RidesService service = RidesService();
  DateTime today = DateTime.now();

  List<Ride> ridesToday = service.getRideByDate(today);

  print("ride available on today: ${today}");

  for(Ride ride in ridesToday){
    print("Departure: ${ride.departureLocation.name}"
        " at ${ride.departureDate}, "
        "Arrival: ${ride.arrivalLocation.name}"
        " at ${ride.arrivalDateTime},"
        " Driver: ${ride.driver},"
        " Seats: ${ride.availableSeats},"
        " Price: ${ride.pricePerSeat}");
  }

  List<Ride> allRides = service.availableRides;
  print("all rides: ");
  for(Ride ride in allRides){

    print("Departure: ${ride.departureLocation.name} "
        "at ${ride.departureDate}, "
        "Arrival: ${ride.arrivalLocation.name} "
        "at ${ride.arrivalDateTime}, Driver: ${ride.driver}, "
        "Seats: ${ride.availableSeats}, "
        "Price: ${ride.pricePerSeat}");
  }
}