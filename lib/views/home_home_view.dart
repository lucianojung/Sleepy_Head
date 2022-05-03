import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

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
    return Stack(
      children: [
        Lottie.asset('assets/60346-rainforest.json', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
        RiveAnimation.asset(
          'assets/Sam_Lit.riv',
          artboard: 'Sam Hanging',
          stateMachines: ['Sam_State_Hanging'],
          alignment: Alignment.topRight,
          fit: BoxFit.fitHeight,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: (() {
                    context.read<AppConfigProvider>().update(
                          DateTime.fromMillisecondsSinceEpoch(1000),
                        );
                    // context.read<AppConfigProvider>().updateInitialRoute('/intro');
                  }),
                  child: const Text('Reset LastUpdate (-> to see welcome screen again after reload)'),
                ),
              ),
              Text('Last Update: ${context.read<AppConfigProvider>().appConfig.lastUpdate.toString()}')
            ],
          ),
        ),
      ],
    );
  }
}
