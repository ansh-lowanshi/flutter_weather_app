import 'package:flutter/material.dart';
// import 'package:weather_icons/weather_icons.dart';

class daily extends StatelessWidget {
  final String date;
  final String tempMax;
  final String tempMin;
  final String icon;
  final String condition;
  final String pop;
  final String sunrise;
  final String sunset;
  const daily(
      {super.key,
      required this.date,
      required this.condition,
      required this.tempMax,
      required this.tempMin,
      required this.icon,
      required this.pop,
      required this.sunrise,
      required this.sunset});

  @override
  Widget build(BuildContext context) {
    final weatherIcons = {
      'Sunny': Icons.wb_sunny,
      'Cloudy': Icons.cloud,
      'Rainy': Icons.umbrella,
      'Thunderstorm': Icons.flash_on,
      'Snowy': Icons.ac_unit,
      'Sunny ': Icons.wb_sunny,
      'Cloudy ': Icons.cloud,
      'Rainy ': Icons.umbrella,
      'Thunderstorm ': Icons.flash_on,
      'Snowy ': Icons.ac_unit,
      'Error': Icons.error_outlined,
      'Clear ': Icons.mode_night_outlined,
      'Partly Cloudy ': Icons.cloud,
      'Partly Cloudy': Icons.cloud,
      'Overcast ': Icons.cloud,
      'Overcast': Icons.cloud,
    };
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                weatherIcons[icon] ?? Icons.error,
                size: 32,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '$condition',
                style: const TextStyle(fontSize: 16),
              ),

              Text(
                'Max - $tempMax°C',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'Min - $tempMin°C',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Rain - $pop %',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Sunrise - $sunrise',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Sunset - $sunset',
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}

