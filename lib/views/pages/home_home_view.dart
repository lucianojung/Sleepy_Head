import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../shared/chat_widgets.dart';

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
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Hanging');
    artboard.addController(controller!);
    _greet = controller.findInput<bool>('greeting trigger') as SMITrigger;
  }

  void _hitGreet() => _greet?.fire();

  @override
  void initState() {
    chat.add(SamBubble('Hey how are you doing?'));
    options.addAll([
      AnswerButton('Thanks I\'m fine.', callback('Thanks I\'m fine.')),
      AnswerButton('Well today is not my day.', callback('Well today is not my day.')),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _hitGreet(),
          child: RiveAnimation.asset(
            'assets/sam_lit.riv',
            artboard: 'Sam Hanging',
            stateMachines: ['Sam_State_Hanging'],
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

  VoidCallback callback(text) {
    return () async {
      setState(() {
        chat.add(UserBubble(text));
        options.clear();
      });
      Future.delayed(const Duration(milliseconds: 500),
          () => setState(() => chat.add(SamBubble('Maybe I can chear you up. Tap on me!'))));
    };
  }
}
