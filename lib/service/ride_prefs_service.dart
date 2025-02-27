
import '../dummy_data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';
import '../model/user/user.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///
class RidePrefService {

  ///
  /// List of past entered ride prefs. LIFO (most recents first)
  ///
  static List<RidePref> ridePrefsHistory = fakeRidePrefs;   // TODO for now fake data

  static RidePref? currentRidePref;
 
  static bool get hasCurrentRidePref => currentRidePref != null;

  List<RidePref> getRidePrefsHistory(){
    return ridePrefsHistory;
  }

  List<RidePref> getRidePrefsByUser(User user){
    return fakeRidePrefs;
  }
}