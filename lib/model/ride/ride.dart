

import '../../utils/date_time_util.dart';
import '../user/user.dart';
import 'locations.dart';

enum RideStatus {
  created,
  published,
  ongoing,
  finished;
}

///
/// This model describes a  Ride.
///
class Ride {
  final Location departureLocation;
  final DateTime departureDate;

  final Location arrivalLocation;
  final DateTime arrivalDateTime;

  final User driver;

  final int availableSeats;
  final double pricePerSeat;

  RideStatus status = RideStatus.created;

  final List<User> passengers = [];

  final bool acceptPets;

  Ride({
    required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.arrivalDateTime,
    required this.driver,
    required this.availableSeats,
    required this.pricePerSeat,
    required this.acceptPets,
  });

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => availableSeats - passengers.length;

  @override
  String toString() {
    return 'Ride from $departureLocation at ${DateTimeUtils.formatDateTime(departureDate)} '
        'to $arrivalLocation arriving at ${DateTimeUtils.formatDateTime(arrivalDateTime)}, '
        'Driver: $driver, Seats: $availableSeats, Price: \$${pricePerSeat.toStringAsFixed(2)}';
  }
}
