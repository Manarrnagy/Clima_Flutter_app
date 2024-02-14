import 'dart:convert';

import 'package:clima/screens/location_screen.dart';
import 'package:clima/service/networking.dart';
import 'package:clima/service/weather.dart';
import 'package:clima/service/weather_dm.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:clima/service/location_dm.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  late WeatherData weatherData;

  void initState() {
    super.initState();
    getLocation();
  }
  void getLocation() async{
    weatherData = await WeatherModel().getLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);
    },),);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        )
      ),
    );
  }


}