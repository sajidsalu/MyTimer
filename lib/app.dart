
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stopwatch/configurations/globals.dart';
import 'package:stopwatch/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:stopwatch/stopwatchtimer.dart';

class SwApp extends StatefulWidget {
  const SwApp({Key? key}) : super(key: key);

  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> {
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
      home: const StopWatchTimerPage(),
    );
  }
}
