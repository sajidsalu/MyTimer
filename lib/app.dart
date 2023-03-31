
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stopwatch/appBloc.dart';
import 'package:stopwatch/clock.dart';
import 'package:stopwatch/configurations/globals.dart';
import 'package:stopwatch/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:stopwatch/stopwatchtimer.dart';
import 'package:stopwatch/timerScreen.dart';

class SwApp extends StatefulWidget {
  const SwApp({Key? key}) : super(key: key);

  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> {
  final AppBloc _bloc = AppBloc();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState((){
      _selectedIndex= index;
    });
    _bloc.setIndex(index);
  }
  final _navigatorKeys = {
    TabItem.stopwatch: GlobalKey<NavigatorState>(),
    TabItem.timer: GlobalKey<NavigatorState>(),
    TabItem.clock: GlobalKey<NavigatorState>(),
  };

  Widget navDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text('Stop watch app')),
          ListTile(
            title: const Text('Stop Watch'),
            onTap: (){
              print("stop watch");
            },
          ),
          ListTile(
            title: const Text('Clock'),
            onTap: (){
              print('clock');
            },
          ),
          ListTile(
            title: Text('Timer'),
            onTap: (){
              print('timer');
            },
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppGlobals.rootNavKey,
      locale: const Locale('en'),
      supportedLocales: L10n.all,
      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'stop watch',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange.shade200,
            automaticallyImplyLeading: true,
            title: Text('Clock-Timer-StopWatch'),
          ),

          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                       Image.network("https://i.ibb.co/zSPLp1h/man.png",height: 50,width: 50,),
                       SizedBox(width: 20.0),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Clock Stop Watch",style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),),
                          Text("timer too",style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),),
                        ],
                      ),
        ]
                    )),
                ListTile(
                  title: const Text('Stop Watch'),
                  onTap: (){
                    print("stop watch");
                  },
                ),
                ListTile(
                  title: const Text('Clock'),
                  onTap: (){
                    print('clock');
                  },
                ),
                ListTile(
                  title: Text('Timer'),
                  onTap: (){
                    print('timer');
                  },
                )
              ],
            ),
          ),
          body:  StreamBuilder<int>(
            stream: _bloc.selectedIndexStream,
            builder: (context, snapshot) {
              var index = snapshot.data;
              if(index == 0) {
                return const StopWatchTimerPage();
              }else if(index == 1){
                return const TimerScreen();
              }else{
                return const ClockScreen();
              }
            }
          ),
           bottomNavigationBar: _bottomNavBarWidget(),),
    );
  }

  Widget _bottomNavBarWidget(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 40,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'StopWatch',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.watch),
          label: 'Clock',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
