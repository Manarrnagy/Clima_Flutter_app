
class WeatherData {
  final int condition;
  final String cityName;
  final double temperature;

  const WeatherData({
    required this.condition,
    required this.cityName,
    required this.temperature,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      condition: json['weather'][0]['id'],
      cityName: json['name'],
      temperature: json['main']['temp'],
    );
  }


}