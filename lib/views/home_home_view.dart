import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_config_provider.dart';

class HomeHomeView extends StatefulWidget {
  HomeHomeView({Key? key}) : super(key: key);

  @override
  _HomeHomeViewState createState() => _HomeHomeViewState();
}

class _HomeHomeViewState extends State<HomeHomeView> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (() {
            context.read<AppConfigProvider>().update(
                  DateTime.fromMillisecondsSinceEpoch(0),
                );
            context.read<AppConfigProvider>().updateInitialRoute('/intro');
          }),
          child: const Text('Reset LastUpdate (-> to see welcome screen again after reload)'),
        ),
        Text(context.read<AppConfigProvider>().appConfig.lastUpdate.toString())
      ],
    );
  }
}
