import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import '../../shared/chat_widgets.dart';

class NightView extends StatefulWidget {
  NightView({Key? key}) : super(key: key);

  @override
  _NightViewState createState() => _NightViewState();
}

class _NightViewState extends State<NightView> {
  SMITrigger? _action;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Waking_Up');
    artboard.addController(controller!);
    _action = controller.findInput<bool>('Trigger') as SMITrigger;
  }

  void _wakeUpSam() => _action?.fire();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).backgroundColor,
        body: GestureDetector(
          onTap: (() => _wakeUpSam()),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerRight,
              ),
              RiveAnimation.asset(
                'assets/sam_lit.riv',
                artboard: 'Sam Waking Up',
                stateMachines: ['Sam_State_Waking_Up'],
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
                onInit: _onRiveInit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
