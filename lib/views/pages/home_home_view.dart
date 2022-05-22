import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

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
        rive.RiveAnimation.asset(
          'assets/Sam_Lit.riv',
          artboard: 'Sam Hanging',
          stateMachines: ['Sam_State_Hanging'],
          alignment: Alignment.topRight,
          fit: BoxFit.fitHeight,
        ),
        // ElevatedButton(
        //   onPressed: (() {
        //     context.read<AppConfigProvider>().update(
        //       DateTime.fromMillisecondsSinceEpoch(1000),
        //     );
        //   }),
        //   child: const Text('Reset LastUpdate (-> to see welcome screen again after reload)'),
        // ),
      ],
    );
  }
}
