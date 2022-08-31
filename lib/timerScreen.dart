import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:timer_builder/timer_builder.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TimerBuilder.scheduled([alert], builder: (context) {
        // This function will be called once the alert time is reached
        var now = DateTime.now();
        var reached = now.compareTo(alert) >= 0;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                reached ? Icons.alarm_on : Icons.alarm,
                color: reached ? Colors.red : Colors.green,
                size: 48,
              ),
              !reached
                  ? TimerBuilder.periodic(Duration(seconds: 1),
                  alignment: Duration.zero, builder: (context) {
                    // This function will be called every second until the alert time
                    var now = DateTime.now();
                    var remaining = alert.difference(now);
                    return Text(
                      formatDuration(remaining),
                    );
                  })
                  : Text("Alert"),
              RaisedButton(
                child: Text("Reset"),
                onPressed: () {
                  setState(() {
                    alert = DateTime.now().add(Duration(seconds: 10));
                  });
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
