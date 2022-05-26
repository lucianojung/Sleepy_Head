import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:sleepy_head/services/user_data_provider.dart';

import '../theme_config.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();

  final String homeRoute;

  const IntroductionView({required this.homeRoute});
}

class _IntroductionViewState extends State<IntroductionView> {
  var textFieldController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var _pages = [
      PageViewModel(
          title: GradientText(
            AppLocalizations.of(context)!.welcomeTitle,
            gradient: headerGradient
          ),
          body: textWidget(AppLocalizations.of(context)!.newUserWelcomeText('Sam')),
          mainImage: SizedBox(
            child: rive.RiveAnimation.asset(
              'assets/sam_lit.riv',
              artboard: 'Sam Hanging',
              stateMachines: ['Sam_State_Hanging'],
              alignment: Alignment.topRight,
              fit: BoxFit.fitHeight,
            ),
          ),
          pageColor: Color(0xFF0A0A0A),
          // decoration: pageDecoration,
          ),
      PageViewModel(
        title: GradientText(
          'Who I am!',
          gradient: headerGradient
        ),
        body: textWidget('I am Sam the sloth...'),
        mainImage: SizedBox(
          child: rive.RiveAnimation.asset(
            'assets/sam_lit.riv',
            artboard: 'Sam Hanging',
            stateMachines: ['Sam_State_Hanging'],
            alignment: Alignment.topRight,
            fit: BoxFit.fitHeight,
          ),
        ),
        pageColor: Color(0xFF0A0A0A),
        // decoration: pageDecoration,
      ),
      PageViewModel(
        title: GradientText(
          'Who are you?',
          gradient: headerGradient
        ),
        body: Column(
          children: [
            Text(
              'Fill in your nickname:',
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 512,
              child: TextField(
                controller: textFieldController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Enter your nickname',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                cursorColor: Colors.white,
              ),
            ),
          ],
        ),
        mainImage: SizedBox(
          child: rive.RiveAnimation.asset(
            'assets/sam_lit.riv',
            artboard: 'Sam Hanging',
            stateMachines: ['Sam_State_Hanging'],
            alignment: Alignment.topRight,
            fit: BoxFit.fitHeight,
          ),
        ),
        pageColor: Color(0xFF0A0A0A),
        // decoration: pageDecoration,
      ),
      //add more screen here
    ];

    return SafeArea(
      child: Builder(builder: (context) {
        return IntroViewsFlutter(
          _pages,
          pageButtonsColor: Colors.white,
          background: Theme.of(context).backgroundColor,
          onTapDoneButton: () => goHomepage(context),
          //go to home page on done
          onTapSkipButton: () => {},
          showBackButton: true,
          showSkipButton: false,
          showNextButton: true,
          backText: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          nextText: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          doneText: Text(
            AppLocalizations.of(context)!.nameHome,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          pageButtonTextStyles: TextStyle(color: Colors.white),
          // dotsDecorator: const DotsDecorator(
          //   size: Size(10.0, 10.0), //size of dots
          //   color: Colors.black, //color of dots
          //   activeSize: Size(22.0, 10.0),
          //   spacing: EdgeInsets.all(4),
          //   //activeColor: Colors.white, //color of active dot
          //   activeShape: RoundedRectangleBorder(
          //     //shave of active dot
          //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
          //   ),
          // ),
        );
      }),
    );
  }

  void goHomepage(context) {
    Provider.of<UserDataProvider>(context, listen: false).updateUsername(textFieldController.text);
    print(textFieldController.text);
    Provider.of<AppConfigProvider>(context, listen: false).update(DateTime.now());
    // Provider.of<AppConfigProvider>(context, listen: false)
    //     .updateInitialRoute('/');
    Navigator.popAndPushNamed(context, widget.homeRoute);
  }

  // custom images

  Widget introImage() {
    //widget to show intro image
    return Image.asset(
      'assets/images/background.png',
      // colorBlendMode: BlendMode.lighten,
      // color: Colors.white10,
      fit: BoxFit.fitHeight,
      // alignment: Alignment.centerRight,
    );
  }

  Widget textWidget(String? text) {
    return SizedBox(
      height: 500,
      child: Text(
        text ?? '',
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style, textAlign: textAlign,),
    );
  }
}
