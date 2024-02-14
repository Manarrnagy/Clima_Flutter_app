
class WeatherData {
   int? condition;
   String? cityName;
   double? temperature;

   WeatherData.fromWeatherData({
     this.condition,
     this.cityName,
     this.temperature,
  });
    WeatherData();


  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData.fromWeatherData(
      condition: json['weather'][0]['id'],
      cityName: json['name'],
      temperature: json['main']['temp'],
    );
  }


}