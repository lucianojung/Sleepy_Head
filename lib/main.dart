import 'package:flutter/material.dart';
import 'package:sleepy_head/global_variables.dart';
import 'package:sleepy_head/services/route_generator.dart';
import 'package:sleepy_head/theme_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: GlobalVariables().appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightTheme,
        initialRoute: GlobalVariables().initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
