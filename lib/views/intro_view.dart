import 'dart:math';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:sleepy_head/services/user_reward_provider.dart';

import '../models/reward.dart';
import '../theme_config.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();

  final String homeRoute;

  const IntroductionView({required this.homeRoute});
}

class _IntroductionViewState extends State<IntroductionView> {
  Duration _sleepTime = const Duration(hours: 8);
  Duration _bedTime = const Duration(hours: 8);
  var _showNextButton = true;
  double _score = 1;
  Map<int, Duration> _showButtonMap = {};

  @override
  Widget build(BuildContext context) {
    _showButtonMap = {1: _sleepTime, 2: _bedTime};
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.w700, color: Colors.white),
      //tile font size, weight and color
      bodyTextStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
      //body text size and color
      titlePadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      footerPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      //decription padding
      imagePadding: const EdgeInsets.all(20),
      pageColor: Theme.of(context).primaryColor,
      fullScreen: true,
      bodyAlignment: Alignment.bottomCenter,
      bodyFlex: 2
    );

    var _pages = [
      PageViewModel(
        title: AppLocalizations.of(context)!.welcomeTitle,
        bodyWidget: textWidget(AppLocalizations.of(context)!
            .newUserWelcomeText('Sleepy Head', 'Sid')),
        image: introImage('assets/images/slothBackground1.gif'),
        decoration: pageDecoration,
      ),
      PageViewModel(
          title: AppLocalizations.of(context)!.nameQuestionX(1),
          bodyWidget: Column(
            children: [
              textWidget(AppLocalizations.of(context)!.question1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DurationPicker(
                  height: 200,
                  duration: _sleepTime,
                  onChange: (val) {
                    setState(() {
                      _sleepTime = val;
                      _bedTime = Duration(minutes: _sleepTime.inMinutes);
                      _showNextButton = _sleepTime.inMinutes >= 120;
                    });
                  },
                  snapToMins: 5.0,
                ),
              ),
            ],
          ),
          image: introImage('assets/images/slothBackground2.gif'),
          decoration: pageDecoration,
          useScrollView: false),
      PageViewModel(
          title: AppLocalizations.of(context)!.nameQuestionX(2),
          bodyWidget: SizedBox(
            width: 600,
            child: Column(
              children: [
                textWidget(AppLocalizations.of(context)!.question2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DurationPicker(
                    height: 200,
                    duration: Duration(
                        minutes: max(_bedTime.inMinutes, _sleepTime.inMinutes)),
                    onChange: (val) {
                      setState(() {
                        _bedTime = val;
                        _showNextButton = _bedTime.inMinutes >= 120;
                      });
                    },
                    snapToMins: 5.0,
                  ),
                ),
              ],
            ),
          ),
          image: introImage('assets/images/slothBackground3.gif'),
          decoration: pageDecoration,
          useScrollView: false),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameReward,
        bodyWidget: textWidget(AppLocalizations.of(context)!.rewardText1),
        image: introImage('assets/images/slothBackground4.gif'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameReward,
        bodyWidget:
            textWidget(AppLocalizations.of(context)!.rewardText5(_score)),
        image: introImage('assets/images/slothBackground5.gif'),
        decoration: pageDecoration,
      ),
      //add more screen here
    ];

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).backgroundColor,
      //main background of screen
      pages: _pages,
      onDone: () => goHomepage(context),
      //go to home page on done
      onSkip: () => {},
      // You can override on skip
      onChange: (index) => setState(() {
        var exactScore =
            _sleepTime.inMinutes / _bedTime.inMinutes;
        _score = double.parse(exactScore.toStringAsFixed(2));
      }),
      showBackButton: true,
      showSkipButton: false,
      showNextButton: _showNextButton,
      showDoneButton: _showNextButton,
      isProgressTap: false,
      scrollPhysics: NeverScrollableScrollPhysics(),
      // dotsFlex: 0,
      // skipFlex: 0,
      // nextFlex: 0,
      // skip: Text(
      //   'Skip',
      //   style: TextStyle(color: Colors.white),
      // ),
      back: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: Text(
        AppLocalizations.of(context)!.nameHome,
        style:
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0), //size of dots
        color: Colors.black, //color of dots
        activeSize: Size(22.0, 10.0),
        spacing: EdgeInsets.all(4),
        //activeColor: Colors.white, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Provider.of<AppConfigProvider>(context, listen: false)
        .update(DateTime.now());
    Provider.of<AppConfigProvider>(context, listen: false)
        .updateInitialRoute('/');
    Navigator.popAndPushNamed(context, widget.homeRoute);
  }

  // custom images

  Widget introImage(String assetName) {
    //widget to show intro image
    return Image.asset(
      assetName,
      colorBlendMode: BlendMode.lighten,
      color: Colors.white10,
      fit: BoxFit.fitHeight,
      height: MediaQuery.of(context).size.height,
    );
  }

  Widget textWidget(String? text) {
    return Text(
      text ?? '',
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }
}
