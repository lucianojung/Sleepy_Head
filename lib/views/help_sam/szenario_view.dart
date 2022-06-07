import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sleepy_head/models/szenario_handler.dart';

import '../../models/szenario.dart';
import '../../shared/chat_widgets.dart';
import '../../shared/my_material_button.dart';
import '../../theme_config.dart';

class SzenarioView extends StatefulWidget {
  SzenarioHandler szenarioHandler;

  SzenarioView({required this.szenarioHandler, Key? key}) : super(key: key);

  @override
  _SzenarioViewState createState() => _SzenarioViewState();
}

class _SzenarioViewState extends State<SzenarioView> {
  List<Bubble> chat = [];
  List<Widget> options = [];
  var _answered = false;

  @override
  void initState() {
    for (String chatText in (widget.szenarioHandler.isInfoStep
        ? widget.szenarioHandler.szenario.info.split('\n')
        : widget.szenarioHandler.szenario.samSzenario.split('\n'))) {
      setState(() => chat.add(widget.szenarioHandler.isInfoStep ? NarratorBubble(chatText) : SamBubble(chatText)));
    }
    Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
              if (widget.szenarioHandler.isInfoStep) {
                options.add(AnswerButton('Got it!', callback('Got it!')));
              } else {
                options.add(AnswerButton(
                    widget.szenarioHandler.szenario.userAnswer, callback(widget.szenarioHandler.szenario.userAnswer)));
                options.add(AnswerButton(
                    'Nope I hate you!', callback('Sure thing!')));
              }
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.centerRight,
            ),
            AnimatedSwitcher(duration: Duration(seconds: 0),
              child: widget.szenarioHandler.isInfoStep ?
              RiveAnimation.asset(
                'assets/sam_lit.riv',
                artboard: 'Sam Hanging',
                stateMachines: ['Sam_State_Hanging'],
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ) : RiveAnimation.asset(
                'assets/sam_lit.riv',
                artboard: 'Sam Questioning',
                stateMachines: ['Sam_State_Questioning'],
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: width,
                    child: Container(),
                  ),
                  for (Bubble message in chat) message,
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      alignment: WrapAlignment.end,
                      children: options,
                    ),
                  ),
                  if (_answered)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyMaterialButton(
                        text: 'CONTINUE',
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        onPressed: () => onContinue(widget.szenarioHandler.szenario, context),
                          textStyle: textStyle.copyWith(color: Colors.black87)
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  VoidCallback callback(text) {
    return () async {
      setState(() {
        chat.add(UserBubble(text));
        options.clear();
        _answered = true;
      });
    };
  }

  void onContinue(Szenario szenario, context) {
    widget.szenarioHandler.followingSteps.removeAt(0);
    if (widget.szenarioHandler.followingSteps[0] == 'Question') {
      widget.szenarioHandler.currentQuestionIndex++;
    }
    (!(widget.szenarioHandler.followingSteps.length == 1) || widget.szenarioHandler.correctAnswers > 0)
        ? Navigator.of(context).pushNamed(widget.szenarioHandler.nextRoute, arguments: [widget.szenarioHandler])
        : Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
