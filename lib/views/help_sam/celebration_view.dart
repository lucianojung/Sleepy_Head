import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:sleepy_head/theme_config.dart';

import '../../models/szenario_handler.dart';
import '../../shared/gradient_text.dart';
import '../../shared/my_material_button.dart';

class CelebrationView extends StatefulWidget {
  SzenarioHandler szenarioHandler;

  CelebrationView({required this.szenarioHandler, Key? key}) : super(key: key);

  @override
  _CelebrationViewState createState() => _CelebrationViewState();
}

class _CelebrationViewState extends State<CelebrationView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                widget.szenarioHandler.celebrationText,
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
      ),
    );
  }


  void onContinue(context) {
    if (widget.szenarioHandler.wrongAnswers <= 0) {
      // todo enable reward on all answers right
      // Provider.of<UserRewardProvider>(context, listen: false).increaseProgress(szenario.id, isSzenarioId: true);
    }
    Provider.of<UserDataProvider>(context, listen: false).updateCorrectAnswers(widget.szenarioHandler.correctAnswers);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
