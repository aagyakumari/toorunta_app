import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null; // Location services are not enabled
  }

  // Check permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null; // Permission denied
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return null; // Permissions are permanently denied
  }

  // Get location
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
