import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;

import '../services/app_config_provider.dart';
import '../services/category_provider.dart';
import '../shared/progress_cloud.dart';

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
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Lottie.asset('assets/60346-rainforest.json', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
        Align(
          child: Image.asset(
            'assets/images/junglescene.png',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
          alignment: Alignment.bottomRight,
        ),
        rive.RiveAnimation.asset(
          'assets/Sam_Lit.riv',
          artboard: 'Sam Hanging',
          stateMachines: ['Sam_State_Hanging'],
          alignment: Alignment.topRight,
          fit: BoxFit.fitHeight,
        ),
        Consumer<CategoryProvider>(
          builder: (context, data, _) => ListView.builder(
            itemCount: data.categories.length,
            itemBuilder: (context, index) {
              var category = data.categories[index];
              return ProgressCloud(category);
            },
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: width),
            SizedBox(
              width: width,
              child: ElevatedButton(
                onPressed: (() {
                  context.read<AppConfigProvider>().update(
                        DateTime.fromMillisecondsSinceEpoch(1000),
                      );
                }),
                child: const Text('Reset LastUpdate (-> to see welcome screen again after reload)'),
              ),
            ),
            Text('Last Update: ${context.read<AppConfigProvider>().appConfig.lastUpdate.toString()}')
          ],
        ),
      ],
    );
  }
}
