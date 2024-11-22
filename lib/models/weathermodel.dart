

class WeatherData {
  final String location;
  final String country;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String localTime;

  WeatherData({
    required this.location,
    required this.country,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.localTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> data) {
    final locationData = data['location'] as Map<String, dynamic>;
    final current = data['current'] as Map<String, dynamic>;
    
    return WeatherData(
      location: locationData['name'] ?? 'Unknown',
      country: locationData['country'] ?? '',
      temperature: (current['temperature'] ?? 0).toDouble(),
      description: (current['weather_descriptions'] as List?)?.firstOrNull?.toString() ?? 'No description',
      feelsLike: (current['feelslike'] ?? 0).toDouble(),
      humidity: current['humidity'] ?? 0,
      windSpeed: (current['wind_speed'] ?? 0).toDouble(),
      pressure: current['pressure'] ?? 0,
      localTime: locationData['localtime'] ?? '',
    );
  }
}



