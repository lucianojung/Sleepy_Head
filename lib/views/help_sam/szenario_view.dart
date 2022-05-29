import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sleepy_head/models/szenario_handler.dart';

import '../../models/szenario.dart';
import '../../shared/chat_widgets.dart';
import '../../shared/my_material_button.dart';

class SzenarioView extends StatefulWidget {
  SzenarioHandler szenarioHandler;

  SzenarioView({required this.szenarioHandler, Key? key}) : super(key: key);

  @override
  _SzenarioViewState createState() => _SzenarioViewState();
}

class _SzenarioViewState extends State<SzenarioView> {
  List<Bubble> chat = [];
  List<Widget> options = [];
  SMITrigger? _greet;
  var _answered = false;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Greeting');
    artboard.addController(controller!);
    _greet = controller.findInput<bool>('greeting trigger') as SMITrigger;
  }

  void _hitGreet() => _greet?.fire();

  @override
  void initState() {
    for (String chatText in (widget.szenarioHandler.isInfoStep
        ? widget.szenarioHandler.szenario.info.split('\n')
        : widget.szenarioHandler.szenario.samSzenario.split('\n'))) {
      setState(() => chat.add(SamBubble(chatText)));
    }
    Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() => options.add(AnswerButton(
            widget.szenarioHandler.isInfoStep ? 'Got it!' : widget.szenarioHandler.szenario.userAnswer,
            callback(widget.szenarioHandler.isInfoStep ? 'Got it!' : widget.szenarioHandler.szenario.userAnswer)))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: () => _hitGreet(),
              child: RiveAnimation.asset(
                'assets/sam_lit.riv',
                artboard: 'Sam Greeting',
                stateMachines: ['Sam_State_Greeting'],
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
                onInit: _onRiveInit,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (() => _hitGreet),
                    child: SizedBox(
                      height:  MediaQuery.of(context).size.height/4,
                      width: width,
                      child: Container(),
                    ),
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
