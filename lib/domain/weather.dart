// domain/weather.dart
class Weather {
  Weather(this.temp);
  final double temp;

  // just a basic implementation
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(json['temp'] as double);
  }
  // TODO: Implement ==, hashCode, toString()
}