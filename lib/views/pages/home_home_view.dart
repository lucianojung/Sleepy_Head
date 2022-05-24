import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../theme_config.dart';

class HomeHomeView extends StatefulWidget {
  HomeHomeView({Key? key}) : super(key: key);

  @override
  _HomeHomeViewState createState() => _HomeHomeViewState();
}

class _HomeHomeViewState extends State<HomeHomeView> {
  List<Bubble> chat = [];
  List<Widget> options = [];
  SMITrigger? _greet;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Greeting');
    artboard.addController(controller!);
    _greet = controller.findInput<bool>('greeting trigger') as SMITrigger;
  }

  void _hitGreet() => _greet?.fire();

  @override
  void initState() {
    chat.add(SamBubble('Hey how are you doing?'));
    options.addAll([
      AnswerButton('Thanks I\'m fine.'),
      AnswerButton('Well today is not my day.'),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _hitGreet(),
          child: RiveAnimation.asset(
            'assets/Sam_Lit.riv',
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
                  height: 300,
                  width: width,
                  child: Container(),
                ),
              ),
              for (Bubble message in chat) message,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                alignment: WrapAlignment.end,
                children: options,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget AnswerButton(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (() async {
          setState(() {
            chat.add(UserBubble(text));
            options.clear();
          });
          Future.delayed(const Duration(milliseconds: 500), () =>
              setState(() => chat.add(SamBubble('Maybe I can chear you up. Tap on me!'))));
        }),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: textStyle18,
          ),
        ),
        style: buttonStyleUser,
      ),
    );
  }

  Bubble UserBubble(text) {
    return Bubble(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(text, style: textStyle18),
        ),
        style: bubbleStyleUser);
  }

  Bubble SamBubble(text) {
    return Bubble(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(text, style: textStyle18),
        ),
        style: bubbleStyleSam);
  }
}
