// data/weather_repository.dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/weather.dart';

part 'weather_repository.g.dart';

class WeatherRepository {
  WeatherRepository(this.client);
  // this is the data source (from the http package)
  final http.Client client;

  Future<Weather> fetchWeather(String city) {
    Future.delayed(const Duration(milliseconds: 400), () {
      return Weather(23.55);
    });
    throw(const HttpException('[-] Request failed'));
  }
}

// this will generate a weatherRepositoryProvider
@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return WeatherRepository(http.Client());
}

// this will generate a fetchWeatherProvider
@riverpod
Future<Weather> fetchWeather(FetchWeatherRef ref, String city) {
  return ref.watch(weatherRepositoryProvider).fetchWeather(city);
}