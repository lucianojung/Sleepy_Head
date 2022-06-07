import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  SMIInput<double>? _action;

  Artboard? _riveArtboard;
  StateMachineController? _controller;

  bool get isPlaying => _controller?.isActive ?? false;

  @override
  void initState() {
    chat.add(SamBubble('Hey how are you doing?'));
    options.addAll([
      AnswerButton('Thanks I\'m fine.', callback('Thanks I\'m fine.')),
      AnswerButton('Well today is not my day.', callback('Well today is not my day.')),
    ]);
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/sam_lit.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.artboardByName('Sam Eating');
        var controller = StateMachineController.fromArtboard(artboard!, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          _action = controller.findInput<double>('Number 1') as SMIInput<double>;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  void _hitAction(number) => _action?.value == 0
      ? _action?.value = number
      : !isPlaying
          ? _action?.value = 0
          : null;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        _riveArtboard != null
            ? GestureDetector(
                onTap: () => _hitAction(Random().nextInt(3) + 1),
                child: Rive(
                  artboard: _riveArtboard!,
                  alignment: Alignment.topRight,
                  fit: BoxFit.fitWidth,
                ),
              )
            : SizedBox(
                height: 350,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 300,
                width: width,
                child: Container(),
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
