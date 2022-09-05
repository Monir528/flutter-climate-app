import 'package:clime/services/networking.dart';
import 'package:clime/screens/location_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:clime/model/location.dart';

const apiKey = 'a952bc894d80eb9e83fa867c5eb20cd0';
//https://api.openweathermap.org/data/2.5/weather?q=Bangladesh&lon=89.5403187&lat=22.821797&appid=a952bc894d80eb9e83fa867c5eb20cd0&units=metric

class WeatherModel {
  late double latitude;
  late double longitude;
  Future<dynamic> getCityWeatherData(String typedName) async {
    Location location = await Location();
    String uri =
        'https://api.openweathermap.org/data/2.5/weather?q=${typedName}&appid=${apiKey}&units=metric';
    print(uri);
    var network = NetworkHelper(url: uri);
    var networkData = await network.getData();
    print(networkData);
    return networkData;
  }

  Future<dynamic> getLocationWeatherData() async {
    Location location = await Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print(latitude);
    print(longitude);
    String uri =
        'https://api.openweathermap.org/data/2.5/weather?lon=${longitude}&lat=${latitude}&exclude=hourly,daily&appid=${apiKey}&units=metric';
    var network = NetworkHelper(url: uri);
    var networkData = await network.getData();
    print(networkData);
    return networkData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
