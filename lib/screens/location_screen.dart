import 'package:clima/screens/city_screen.dart';
import 'package:clima/service/networking.dart';
import 'package:clima/service/weather_dm.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/service/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late int temperature;
  late int condition;
  late String weatherIcon;
  late String weatherMessage;
  late String cityName;
  WeatherData weatherData=WeatherData();


  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(WeatherData weatherData) {
    setState(() {
      if (weatherData.cityName == null) {
        this.temperature = 0;
        this.weatherIcon = "Error";
        this.weatherMessage = "Unable to get weather data";
        this.cityName = "";

        return;
      }
      double temperature = weatherData.temperature!;
      condition = weatherData.condition!;
      cityName = weatherData.cityName!;
      this.temperature = temperature.round();
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage =
          weatherModel.getMessage(this.temperature) + " in " + cityName;
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
                  IconButton(
                    onPressed: () async {
                      WeatherData newWeatherData =
                          await WeatherModel().getLocation();
                      print("success");
                      updateUI(newWeatherData);
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: ()async {
                      var typedName = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if(typedName==null){
                       }
                      else{
                        NetworkHelper networkHelper= NetworkHelper(url: "${baseUrl}data/2.5/weather?q=${typedName}&appid=${apiKey}&units=metric");
                        updateUI( weatherData =await networkHelper.getData());

                      }
                    },
                    icon: Icon(
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage",
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
