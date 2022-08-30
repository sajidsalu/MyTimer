import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _clockScreenState();
}

class _clockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        body: Center(
        child: Text("Clock screeen"),
      ),
    );
  }
}
