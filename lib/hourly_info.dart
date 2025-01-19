import 'package:flutter/material.dart';
// import 'package:weather_icons/weather_icons.dart';

class hourly extends StatelessWidget {
  final String time;
  final String temp;
  final String icon;
  final String pop;
  const hourly(
      {super.key,
      required this.time,
      required this.temp,
      required this.icon,
      required this.pop});

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
      width: 110,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 18),
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
                '$temp°C',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '$pop %',
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

