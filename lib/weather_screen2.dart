// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/daily_info.dart';
import 'additional_info.dart';
import 'hourly_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:weather_icons/weather_icons.dart';

class WeatherScreen2 extends StatefulWidget {
  const WeatherScreen2 ({super.key});

  @override
  State<WeatherScreen2> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen2> {
  // String API2 = dotenv.env['API'].toString();
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
     try {
      final apiKey = dotenv.env['API_KEY']; // Fetch the API key from .env

      if (apiKey == null) {
        throw 'API key is missing';
      }
    var result = await http.get(
        Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=22.49158,77.40768&days=3&aqi=no&alerts=no',
        ),
      );
      var data = jsonDecode(result.body);
       if (data['location']['tz_id'] != 'Asia/Kolkata') {
        throw "An unaccepted error occurred";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('An unexpected error occured'));
          }
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
            'Clear': Icons.mode_night_outlined,
            'Partly Cloudy ': Icons.cloud,
            'Partly Cloudy': Icons.cloud,
            'Overcast ': Icons.cloud,
            'Overcast': Icons.cloud,
          };
          final data = snapshot.data!;
          var currentTime =
              DateTime.parse(data['current']['last_updated'].toString());
          var tme = DateFormat.jm().format(currentTime);
          var date = DateFormat.yMEd().format(currentTime);
          var currentHour = DateFormat.H().format(currentTime);
          final currentprecipitation = data['forecast']['forecastday'][0]
              ['hour'][(int.parse(currentHour))]['chance_of_rain'];
          final currentTemp = data['current']['temp_c'];
          final currentcloud_cover = data['current']['cloud'];
          // final currentHumidity = data['list'][0]['main']['humidity'];
          final currentIcon = data['current']['condition']['text'];
          final currentWind = data['current']['wind_kph'].toString();

          return ListView(scrollDirection: Axis.vertical, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp°C',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Icon(
                              weatherIcons[currentIcon] ?? Icons.error,
                              size: 32,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              tme,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            // Text(
                            //   currentWind,
                            //   style: const TextStyle(
                            //     fontSize: 20,
                            //   ),
                            // ),

                            const SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   date,
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 15,
                            //   ),
                            // )
                            // Text(currentSky),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // const Text(
                  //   'Additional Information',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20,
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 20,
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      additionalInfo(
                        icon: Icons.water_drop,
                        label: 'Rain',
                        value: '$currentprecipitation %',
                      ),
                      additionalInfo(
                        icon: Icons.cloud,
                        label: 'Cloud Cover',
                        value: '$currentcloud_cover %',
                      ),
                      additionalInfo(
                        icon: Icons.air,
                        value: '$currentWind Kmph',
                        label: 'Wind Speed',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Weather Forcast Hourly',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 24,
                      itemBuilder: (BuildContext context, int index) {
                        var currentTime = DateTime.parse(
                            data['location']['localtime'].toString());
                        var time2 = DateFormat.H().format(currentTime);
                        // var tme3 = time2.substring(0, 2);

                        int targetIndex = int.parse(time2) + index + 1;
                        List<dynamic> forecastHours =
                            data['forecast']['forecastday'][0]['hour'];
                        if (targetIndex < 0 ||
                            targetIndex >= forecastHours.length) {
                          // Do not return the widget if the index is out of bounds
                          return const SizedBox
                              .shrink(); // Return an empty placeholder widget
                        }

                        var futureTime = DateTime.parse(data['forecast']
                                    ['forecastday'][0]['hour']
                                [(int.parse(time2) + index + 1)]['time']
                            .toString());
                        var time4 =
                            DateFormat.jm().format(futureTime).toString();
                        final futureTemp = data['forecast']['forecastday'][0]
                                    ['hour'][(int.parse(time2) + index + 1)]
                                ['temp_c']
                            .toString();
                        final icon = data['forecast']['forecastday'][0]['hour']
                                    [(int.parse(time2) + index + 1)]
                                ['condition']['text']
                            .toString();
                        final pop = data['forecast']['forecastday'][0]['hour']
                                    [(int.parse(time2) + index + 1)]
                                ['chance_of_rain']
                            .toString();
                        return hourly(
                          time: time4,
                          icon: icon,
                          temp: futureTemp,
                          pop: pop,
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Weather Forcast Daily',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 280,
                    child: RepaintBoundary(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                      
                          var currentTime = DateTime.parse(
                              data['location']['localtime'].toString());
                          var time2 = DateFormat.H().format(currentTime);
                          // var tme3 = time2.substring(0, 2);
                      
                          int targetIndex = index;
                      
                          // int targetIndex = int.parse(time2) + index + 1;
                      
                          // List<dynamic> forecastHours =
                          //     data['forecast']['forecastday'][0]['hour'];
                          // if (targetIndex < 0 ||
                          //     targetIndex >= forecastHours.length) {
                          //   // Do not return the widget if the index is out of bounds
                          //   return const SizedBox
                          //       .shrink(); // Return an empty placeholder widget
                          // }
                      
                          var futureTime = DateTime.parse(data['forecast']
                                      ['forecastday'][targetIndex]['date']
                              .toString());
                          var time4 =
                              DateFormat('dd MMMM').format(futureTime).toString();
                      
                          final futureTempMax = data['forecast']['forecastday'][targetIndex]
                                      ['day']['maxtemp_c']
                              .toString();
                          final futureTempMin = data['forecast']['forecastday'][targetIndex]
                                      ['day']['mintemp_c']
                              .toString();
                          final icon = data['forecast']['forecastday'][targetIndex]
                                      ['day']['condition']['text']
                              .toString();
                          final pop = data['forecast']['forecastday'][targetIndex]
                                      ['day']['daily_chance_of_rain']
                              .toString();
                          final sunrise =  data['forecast']['forecastday'][targetIndex]
                                      ['astro']['sunrise']
                              .toString();
                          final sunset =  data['forecast']['forecastday'][targetIndex]
                                      ['astro']['sunset']
                              .toString();
                          final condition =  data['forecast']['forecastday'][targetIndex]
                                      ['day']['condition']['text']
                              .toString();
                          return daily(
                            date: time4,
                            icon: icon,
                            condition: condition,
                            tempMax: futureTempMax,
                            tempMin: futureTempMin,
                            sunrise: sunrise,
                            sunset: sunset,
                            pop: pop,
                          );
                        },
                      ),
                    ),
                  )

                  // const SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       hourly(time: '06:00', icon: Icons.sunny, data: '300'),
                  //     ],
                  //   ),
                  // ),

                  // // const Placeholder(
                  // //   fallbackHeight: 100,
                  // // ),

                  ,
                  const SizedBox(
                    height: 18,
                  ),

                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: IconButton(
                  //         iconSize: 35,
                  //         onPressed: () {
                  //           setState(() {});
                  //         },
                  //         icon: const Icon(Icons.refresh)),
                  //   ),
                  // )

                  // const Placeholder(
                  //   fallbackHeight: 150,
                  // )
                ],
              ),
            ),
          ]);
        },
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          child: Icon(Icons.refresh,color: Colors.black,),
            onPressed: () {
              setState(() {});
            },
            backgroundColor: Colors.white),
      ),
    );
  }
}
