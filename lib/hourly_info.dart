import 'package:flutter/material.dart';
class hourly extends StatelessWidget {
  final String time;
  final IconData icon;
  final String data;
  const hourly(
      {super.key,
      required this.time,
      required this.icon,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 110,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(icon,
                size: 30,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
