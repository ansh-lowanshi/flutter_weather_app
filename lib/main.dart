import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/weather_screen2.dart';

void main() async{
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Weather APP',
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}