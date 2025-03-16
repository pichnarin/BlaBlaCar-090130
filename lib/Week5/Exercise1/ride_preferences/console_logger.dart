import 'model.dart';
import 'ride_preferences_listener.dart';
// import 'ride_preference.dart';

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePreference selectedPreference) {
    print('😭😭😭😭😭 Ride preference changed to: ${selectedPreference.name}');
  }
}
