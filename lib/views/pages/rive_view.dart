import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiveAnimation.asset(
        'assets/sam_lit.riv',
        artboard: 'Sam Walking',
        stateMachines: ['Sam_State_Walking'],
        alignment: Alignment.topRight,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
