import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch/button.dart';
import 'package:stopwatch/l10n/l10n.dart';

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({Key? key}) : super(key: key);

  @override
  State<StopWatchTimerPage> createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countDownDuration = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;
  bool countDown = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
  }

  void reset(){
    if(countDown){

      setState(() {
        duration=countDownDuration;
      });
    }else{

      setState(() {
        duration =const Duration();
      });
    }
  }
  void startTimer(){
    timer=Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }
  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds+addSeconds;
      if(seconds < 0){
        timer?.cancel();
      }else{
        duration=Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }
    setState(() {
      timer?.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(Localization.stopwatch),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimer(),
              const SizedBox(height: 80,),
              buildButtons()
            ],
          ),
        ),
      ),
    );

  }
  Widget buildTimer(){
    String twoDigits(int n)=> n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes= twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header:Localization.hours),
        const SizedBox(width: 8,),
        buildTimeCard(time: minutes, header:Localization.minutes),
        const SizedBox(width: 8,),
        buildTimeCard(time: seconds, header: Localization.seconds),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color:  Colors.black),
          ),
        ),
        const SizedBox(height: 24,),
        Text(header,style: const TextStyle(color: Colors.black54),),
      ],
    );
  }

  Widget buildButtons(){
    final isRunning = timer == null? false: timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(
            text:Localization.stop,
            onClicked: (){
              if (isRunning){
                stopTimer(resets: false);
              }
            }),
        const SizedBox(width: 12,),
        ButtonWidget(
            text: Localization.cancel,
            onClicked: stopTimer
        ),
      ],
    ): ButtonWidget(
        text: Localization.startTimer,
        color: Colors.black,
        backgroundColor: Colors.white,
        onClicked: (){
          startTimer();
        });

  }
}
