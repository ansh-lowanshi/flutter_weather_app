import 'dart:convert';
import 'package:flutter/material.dart';
import 'additional_info.dart';
import 'hourly_info.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String city = 'london';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=London&APPID=782e3cb969bd8b2c15eaa82e13c6933a'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw "an unaccepted error occured";
      }
      return data;
      // data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }

    // print(result.body);
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
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  
                });
              },
              icon: const Icon(Icons.refresh))
        ],
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

          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentSky = data['list'][0]['weather'][0]['main'];

          return Padding(
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
                            '$currentTemp K',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(
                            currentSky == 'Clouds' || currentSky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 48,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(currentSky),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // const Text(
                //   'Weather Forcast',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       hourly(
                //         time: '00:00',
                //         icon: Icons.sunny,
                //         data: '300',
                //       ),
                //       hourly(
                //           time: '09:00',
                //           icon: Icons.cloudy_snowing,
                //           data: '300'),
                //       hourly(
                //           time: '12:00',
                //           icon: Icons.cloud_outlined,
                //           data: '300'),
                //       hourly(time: '03:00', icon: Icons.cloud, data: '300'),
                //       hourly(time: '06:00', icon: Icons.sunny, data: '300'),
                //     ],
                //   ),
                // ),

                // // const Placeholder(
                // //   fallbackHeight: 100,
                // // ),

                const SizedBox(
                  height: 20,
                ),

                // const Placeholder(
                //   fallbackHeight: 150,
                // )

                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    additionalInfo(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '$currentHumidity',
                    ),
                    additionalInfo(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '$currentWindSpeed',
                    ),
                    additionalInfo(
                      icon: Icons.beach_access,
                      value: '$currentPressure',
                      label: 'Pressure',
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
