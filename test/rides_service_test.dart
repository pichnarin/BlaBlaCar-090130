import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/model/ride_pref/ride_pref.dart';
import 'package:untitled/service/rides_service.dart';
import 'package:untitled/service/mock_rides_reposistory.dart';
import 'package:untitled/model/ride/locations.dart';
import 'package:untitled/model/ride/ride.dart';
import 'package:untitled/model/user/user.dart';

void main() {
  group('RidesService Tests', () {
    late RidesService ridesService;

    setUp(() {
      ridesService = RidesService(repository: MockRidesRepository());
    });

    test('T1: Create a ride preference from Battambang to Siem Reap today for 1 passenger', () {
      final ridePref = RidePref(
        departure: Location(name: 'Battambang', country: Country.kh),
        departureDate: DateTime.now(),
        arrival: Location(name: 'Siem Reap', country: Country.kh),
        requestedSeats: 1,
      );

      final rides = ridesService.getRides(ridePref, null);

      expect(rides.length, 5); // Expecting 5 rides
      expect(rides.any((ride) => ride.availableSeats == 0), isTrue, reason: 'Warning: 1 ride is full!');
    });

    test('T2: Create a ride preference from Battambang to Siem Reap today for 1 passenger with pet allowed filter', () {
      final ridePref = RidePref(
        departure: Location(name: 'Battambang', country: Country.kh),
        departureDate: DateTime.now(),
        arrival: Location(name: 'Siem Reap', country: Country.kh),
        requestedSeats: 1,
      );

      final rideFilter = RidesFilter(petAccepted: true);
      final rides = ridesService.getRides(ridePref, rideFilter);

      expect(rides.length, 1);
      expect(rides.first.driver.firstName, 'Limhao'); // Fix: Limhao allows pets
    });
  });
}