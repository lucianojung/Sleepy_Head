import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sleepy_head/theme_config.dart';

import '../../shared/my_material_button.dart';
import '../intro_view.dart';

class CelebrationView extends StatefulWidget {
  String text;

  CelebrationView({required this.text, Key? key}) : super(key: key);

  @override
  _CelebrationViewState createState() => _CelebrationViewState();
}

class _CelebrationViewState extends State<CelebrationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/Star2.png', fit: BoxFit.fitWidth,)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RiveAnimation.asset(
              'assets/sam_lit.riv',
              artboard: 'Sam Celebrating',
              animations: ['sam_celebrating'],
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 100,
            width: MediaQuery.of(context).size.width,
            child: GradientText(
              // 'You won 10 Points!',
              widget.text,
              gradient: headerGradient,
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyMaterialButton(
                text: 'CONTINUE',
                backgroundColor: MaterialStateProperty.all(Colors.white),
                onPressed: () => onContinue(context),
              ),
            ),
          )
        ],
      ),
    );
  }


  void onContinue(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
