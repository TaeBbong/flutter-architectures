// presentation/weather_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/weather_repository.dart';

class WeatherUi extends ConsumerWidget {
  const WeatherUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // note 
    final weatherAsync = ref.watch(fetchWeatherProvider('London'));
    return weatherAsync.when(
      data: (weather) => Text(weather.temp.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text(e.toString()),
    );
  }
}