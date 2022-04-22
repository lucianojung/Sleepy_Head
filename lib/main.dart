import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sleepy_head/global_variables.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:sleepy_head/services/route_generator.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:sleepy_head/theme_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserDataProvider>(
      create: (context) => UserDataProvider()),
  ChangeNotifierProvider<AppConfigProvider>(
      create: (context) => AppConfigProvider()),
];

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return context.read<AppConfigProvider>().appConfig.initialRoute != ''
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: GlobalVariables().appTitle,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: lightTheme,
            initialRoute: context.read<AppConfigProvider>().appConfig.initialRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
          )
        : Center(key: UniqueKey(), child: CircularProgressIndicator());
  }
}
