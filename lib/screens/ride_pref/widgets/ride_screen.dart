import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../model/user/user.dart';

class RidesScreen extends StatelessWidget {
  final RidePref ridePref;

  const RidesScreen({super.key, required this.ridePref});

  @override
  Widget build(BuildContext context) {
    // For now, we use dummy data for rides
    final List<Ride> matchingRides = [
      Ride(
        departureLocation: ridePref.departure,
        departureDate: ridePref.departureDate,
        arrivalLocation: ridePref.arrival,
        arrivalDateTime: ridePref.departureDate.add(Duration(hours: 2)),
        driver: User(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phone: '123-456-7890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        availableSeats: 3,
        pricePerSeat: 20.0,
        acceptPets: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Matching Rides')),
      body: ListView.builder(
        itemCount: matchingRides.length,
        itemBuilder: (context, index) {
          final ride = matchingRides[index];
          return ListTile(
            title: Text('${ride.departureLocation.name} to ${ride.arrivalLocation.name}'),
            subtitle: Text('Driver: ${ride.driver.firstName} ${ride.driver.lastName}, Price: \$${ride.pricePerSeat}'),
            onTap: () {
              // Handle ride selection
            },
          );
        },
      ),
    );
  }
}

