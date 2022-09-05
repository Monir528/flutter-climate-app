import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clime/model/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clime/screens/location_screen.dart';
import 'package:clime/services/weather.dart';

const apiKey = 'a952bc894d80eb9e83fa867c5eb20cd0';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationweather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
