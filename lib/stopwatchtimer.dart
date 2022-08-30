import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch/bloc.dart';
import 'package:stopwatch/button.dart';
import 'package:stopwatch/clock.dart';
import 'package:stopwatch/l10n/l10n.dart';
import 'package:stopwatch/timerScreen.dart';

enum TabItem { timer, stopwatch, clock }

const Map<TabItem, String> tabName = {
  TabItem.timer: 'timer',
  TabItem.stopwatch: 'stopwatch',
  TabItem.clock: 'clock',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.timer: Colors.red,
  TabItem.stopwatch: Colors.green,
  TabItem.clock: Colors.blue,
};

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({Key? key}) : super(key: key);

  @override
  State<StopWatchTimerPage> createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  StopWatchBloc _bloc = StopWatchBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose called");
  }

  void reset(){
    if(mounted) {
      if (_bloc.countDown) {
        _bloc.setDuration(_bloc.countDownDuration);
        setState(() {
          _bloc.setDuration(_bloc.countDownDuration);
        });
      } else {
        _bloc.setDuration(const Duration());
        setState(() {
          _bloc.setDuration(const Duration());
        });
      }
    }
  }
  
  void startTimer(){
    _bloc.setTimer(Timer.periodic(const Duration(seconds: 1), (_) => addTime()));
  }
  
  void addTime(){
    if(mounted) {
      final addSeconds = _bloc.countDown ? -1 : 1;
      setState(() {
        final seconds = _bloc.duration.inSeconds + addSeconds;
        if (seconds < 0) {
          _bloc.timer?.cancel();
        } else {
          _bloc.setDuration(Duration(seconds: seconds));
        }
      });
    }
  }

  void stopTimer({bool resets = true}){
    if(resets){
      reset();
    }
    setState(() {
      _bloc.timer?.cancel();
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
    final hours = twoDigits(_bloc.duration.inHours);
    final minutes= twoDigits(_bloc.duration.inMinutes.remainder(60));
    final seconds = twoDigits(_bloc.duration.inSeconds.remainder(60));
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
    final isRunning = _bloc.timer == null? false: _bloc.timer!.isActive;
    final isCompleted = _bloc.duration.inSeconds == 0;
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
