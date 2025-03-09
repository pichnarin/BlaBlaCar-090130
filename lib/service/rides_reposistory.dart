import 'package:untitled/service/rides_service.dart';
import '../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePref preference, RidesFilter? filter);

  List<Ride> getRideByDate(DateTime date);

  List<Ride> getAvailableRides();
}