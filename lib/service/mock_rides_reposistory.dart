import 'package:untitled/model/ride_pref/ride_pref.dart';
import 'package:untitled/service/rides_reposistory.dart';
import 'package:untitled/service/rides_service.dart';

import '../model/ride/locations.dart';
import '../model/ride/ride.dart';
import '../model/user/user.dart';

class MockRidesRepository implements RidesRepository {
  @override
  List<Ride> getRides(RidePref preference, RidesFilter? filter) {
    List<Ride> rides = [
      Ride(
        departureLocation: Location(name: 'Battambang', country: Country.kh),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.kh),
        departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 7, minutes: 30)),
        driver: User(firstName: 'Kannika', lastName: '', email: '', phone: '', profilePicture: '', verifiedProfile: true),
        availableSeats: 2,
        pricePerSeat: 10.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation: Location(name: 'Battambang', country: Country.kh),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.kh),
        departureDate: DateTime.now().add(Duration(hours: 20)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
        driver: User(firstName: 'Chaylim', lastName: '', email: '', phone: '', profilePicture: '', verifiedProfile: true),
        availableSeats: 0,
        pricePerSeat: 10.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation: Location(name: 'Battambang', country: Country.kh),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.kh),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: User(firstName: 'Mengtech', lastName: '', email: '', phone: '', profilePicture: '', verifiedProfile: true),
        availableSeats: 1,
        pricePerSeat: 10.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation: Location(name: 'Battambang', country: Country.kh),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.kh),
        departureDate: DateTime.now().add(Duration(hours: 20)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
        driver: User(firstName: 'Limhao', lastName: '', email: '', phone: '', profilePicture: '', verifiedProfile: true),
        availableSeats: 2,
        pricePerSeat: 10.0,
        acceptPets: true,
      ),
      Ride(
        departureLocation: Location(name: 'Battambang', country: Country.kh),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.kh),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: User(firstName: 'Sovanda', lastName: '', email: '', phone: '', profilePicture: '', verifiedProfile: true),
        availableSeats: 1,
        pricePerSeat: 10.0,
        acceptPets: false,
      ),
    ];

    if (filter != null) {
      rides = rides.where((ride) => ride.acceptPets == filter.petAccepted).toList();
    }

    return rides;
  }

  @override
  List<Ride> getAvailableRides() {
    return getRides(
      RidePref(
        departure: Location(name: 'Default Departure', country: Country.kh),
        departureDate: DateTime.now(),
        arrival: Location(name: 'Default Arrival', country: Country.kh),
        requestedSeats: 1,
      ),
      null,
    ).where((ride) => ride.availableSeats > 0).toList();
  }

  @override
  List<Ride> getRideByDate(DateTime date) {
    return getRides(
      RidePref(
        departure: Location(name: 'Default Departure', country: Country.kh),
        departureDate: date,
        arrival: Location(name: 'Default Arrival', country: Country.kh),
        requestedSeats: 1,
      ),
      null,
    ).where((ride) =>
    ride.departureDate.day == date.day &&
        ride.departureDate.month == date.month &&
        ride.departureDate.year == date.year).toList();
  }
}