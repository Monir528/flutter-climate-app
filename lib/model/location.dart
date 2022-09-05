import 'package:geolocator/geolocator.dart';

class Location {
//  creating some propertines
  late double latitude;
  late double longitude;

//  for getting the location we ar goin to do this
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("The permission is dennied");
    }
  }
}
