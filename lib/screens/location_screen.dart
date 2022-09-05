import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clime/utilities/constants.dart';
import 'package:clime/services/weather.dart';
import 'package:clime/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //creating the instance of Weather classs
  WeatherModel weatherModel = WeatherModel();
  late int temparature;
  late String weatherIcon;
  late String country;
  late String message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateUI(widget.locationweather);
    updateUI(jsonDecode(widget.locationweather));
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temparature = 0;
        country = "";
        weatherIcon = 'Error';
        message = "Unable to load the data";
        return;
      }
      double temp = weatherData['main']['temp'];
      temparature = temp.toInt();
      int id = weatherData['weather'][0]['id'];
      country = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(id);
      message = weatherModel.getMessage(temparature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      //  we have to do something here
                      var weatherData =
                          await weatherModel.getLocationWeatherData();
                      updateUI(jsonDecode(weatherData));
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        print(typedName);
                        var weatherData =
                            await WeatherModel().getCityWeatherData(typedName);
                        print("the body : ${jsonDecode(weatherData)}l");
                        updateUI(jsonDecode(weatherData));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temparature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      "${weatherIcon}",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${message} in ${country}",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
