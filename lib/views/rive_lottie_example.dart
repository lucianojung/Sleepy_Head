import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class RiveLottieExample extends StatefulWidget {
  RiveLottieExample({Key? key}) : super(key: key);

  @override
  _RiveLottieExampleState createState() => _RiveLottieExampleState();
}

class _RiveLottieExampleState extends State<RiveLottieExample> {
  SMITrigger? _greet;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Greeting');
    artboard.addController(controller!);
    _greet = controller.findInput<bool>('greeting trigger') as SMITrigger;
  }

  void _hitGreet() => _greet?.fire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            Lottie.asset('assets/60346-rainforest.json', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
            RiveAnimation.asset(
              'assets/Sam_Lit.riv',
              artboard: 'Sam Hanging',
              stateMachines: ['Sam_State_Hanging'],
              alignment: Alignment.topRight,
              fit: BoxFit.fitHeight,
            ),
            // RiveAnimation.asset(
            //   'assets/Sam_Lit.riv',
            //   artboard: 'Sam Greeting',
            //   stateMachines: ['Sam_State_Greeting'],
            //   alignment: Alignment.topRight,
            //   fit: BoxFit.fitHeight,
            //   onInit: _onRiveInit,
            // ),
            // RiveAnimation.asset(
            //   'assets/Sam_Lit.riv',
            //   artboard: 'Sam Walking',
            //   stateMachines: ['Sam_State_Walking'],
            //   alignment: Alignment.topRight,
            //   fit: BoxFit.fitHeight,
            // ),
          ],
        ),
        onTap: _hitGreet,
      ),
    );
  }
}
