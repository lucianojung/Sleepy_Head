import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepy_head/global_variables.dart';
import 'package:sleepy_head/services/route_generator.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:sleepy_head/theme_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserData userData = UserData();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var result = prefs.getString('userData');

  if (result != null) {
    userData = UserData.fromJson(json.decode(result));
  }
  runApp(MultiProvider(providers: providers, child: MyApp(userData)));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserDataProvider>(
      create: (context) => UserDataProvider()),
];

class MyApp extends StatelessWidget {
  UserData userData = UserData();
  MyApp(this.userData, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserDataProvider>(context).lastUpdateToday);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: GlobalVariables().appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightTheme,
        initialRoute: DateTime.now().isAfter(userData.lastUpdate.subtract(Duration(hours: userData.lastUpdate.hour, minutes: userData.lastUpdate.minute)).add(const Duration(days: 1)))
            ? '/intro'
            : '/',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
