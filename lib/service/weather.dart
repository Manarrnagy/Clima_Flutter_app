import '../utilities/constants.dart';
import 'networking.dart';
import 'package:clima/service/location_dm.dart';
import 'package:clima/service/weather_dm.dart';

class WeatherModel {
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
  Future<WeatherData> getLocation() async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(url: "${baseUrl}data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    WeatherData weatherData =await networkHelper.getData();
    return weatherData;
  }
}