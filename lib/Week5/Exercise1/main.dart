import 'ride_preferences/console_logger.dart';
import 'ride_preferences/model.dart';
import 'ride_preferences/ride_preferences_service.dart';

void main() {
  // Create the service
  RidePreferencesService service = RidePreferencesService();

  // Create a logger and register it as a listener
  ConsoleLogger logger = ConsoleLogger();
  service.addListener(logger);

  // Create ride preferences
  RidePreference eco = RidePreference("Eco Ride");
  RidePreference luxury = RidePreference("Luxury Ride");

  // Change ride preferences (ConsoleLogger should get notified)
  service.selectPreference(eco);
  service.selectPreference(luxury);
}
