import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:stopwatch/configurations/globals.dart';
class L10n{
  static const all = [Locale('en')];

}
AppLocalizations get Localization => AppLocalizations.of(AppGlobals.rootNavKey.currentContext!)!;