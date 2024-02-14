import 'dart:convert';

import 'package:clima/service/weather_dm.dart';
import 'package:http/http.dart' as http;

class NetworkHelper{
  String url;
  NetworkHelper({required this.url});

   Future<WeatherData> getData()async{
    http.Response response = await http.get(Uri.parse(url));
    late WeatherData weatherData;
    if(response.statusCode == 200){
      weatherData = WeatherData.fromJson(jsonDecode(response.body));


    }
    return weatherData;

  }




 // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
}