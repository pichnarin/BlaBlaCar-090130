import 'model.dart';
// import 'ride_preference.dart';
import 'ride_preferences_listener.dart';

class RidePreferencesService {
  RidePreference? _selectedPreference;
  final List<RidePreferencesListener> _listeners = [];

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void removeListener(RidePreferencesListener listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      if (_selectedPreference != null) {
        listener.onPreferenceSelected(_selectedPreference!);
      }
    }
  }

  void selectPreference(RidePreference preference) {
    _selectedPreference = preference;
    notifyListeners();
  }
}
