import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sleepy_head/global_variables.dart';
import 'package:sleepy_head/services/route_generator.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:sleepy_head/theme_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserDataProvider>(
      create: (context) => UserDataProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserDataProvider>(context).lastUpdateToday);
    return MaterialApp(
        key: UniqueKey(), // fast fix to fix right initial Route loading
        debugShowCheckedModeBanner: false,
        title: GlobalVariables().appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightTheme,
        initialRoute: Provider.of<UserDataProvider>(context, listen: false)
                .lastUpdateToday
            ? '/intro'
            : '/',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
