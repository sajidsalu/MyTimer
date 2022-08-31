import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _clockScreenState();
}

class _clockScreenState extends State<ClockScreen> {
  String getSystemTime(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat("hh:mm:ss a");
    final String formatted = formatter.format(now);
    return formatted;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orange[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
                return Text(
                  getSystemTime().toString(),
                  style: const TextStyle(
                      color: Color(0xff2d386b),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                );
              }),
            ],
          ),
        ),
    );
  }
}
