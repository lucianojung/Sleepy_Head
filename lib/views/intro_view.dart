import 'dart:math';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../services/user_data_provider.dart';
import '../theme_config.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();

  final String homeRoute;

  const IntroductionView({required this.homeRoute});
}

class _IntroductionViewState extends State<IntroductionView> {
  Duration _sleepTime = Duration(hours: 8);
  Duration _bedTime = Duration(hours: 8);
  var _showNextButton = true;
  double _score = 0;
  var _tecMap = {};

  @override
  Widget build(BuildContext context) {
    _tecMap = {1: _sleepTime, 2: _bedTime};
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
        fullScreen: true);

    var _pages = [
      PageViewModel(
        title: AppLocalizations.of(context)!.welcomeTitle,
        bodyWidget: textWidget(AppLocalizations.of(context)!
            .newUserWelcomeText('Sleepy Head', 'Sid')),
        image: introImage('assets/images/slothBackground1.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameQuestionX(1),
        bodyWidget: SizedBox(
          width: 600,
          child: Column(
            children: [
              textWidget(AppLocalizations.of(context)!.question1),
              DurationPicker(
                duration: _sleepTime,
                onChange: (val) {
                  setState(() {
                    _sleepTime = val;
                    _showNextButton = _sleepTime != 0;
                    var exactScore = _sleepTime.inMinutes /
                        _bedTime.inMinutes;
                    _score = double.parse(exactScore.toStringAsFixed(2));
                  });
                },
                snapToMins: 5.0,
              ),
            ],
          ),
        ),
        image: introImage('assets/images/slothBackground3.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameQuestionX(2),
        bodyWidget: SizedBox(
          width: 600,
          child: Column(
            children: [
              textWidget(AppLocalizations.of(context)!.question2),
              DurationPicker(
                duration: Duration(minutes: max(_bedTime.inMinutes, _sleepTime.inMinutes)),
                onChange: (val) {
                  setState(() {
                    _bedTime = val;
                    _showNextButton = _bedTime != 0;
                    var exactScore = _sleepTime.inMinutes /
                        _bedTime.inMinutes;
                    _score = double.parse(exactScore.toStringAsFixed(2));
                  });
                },
                snapToMins: 5.0,
              ),
            ],
          ),
        ),
        image: introImage('assets/images/slothBackground3.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameReward,
        bodyWidget: textWidget(AppLocalizations.of(context)!.rewardText1),
        image: introImage('assets/images/slothBackground4.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context)!.nameReward,
        bodyWidget:
            textWidget(AppLocalizations.of(context)!.rewardText5(_score)),
        image: introImage('assets/images/slothBackground5.png'),
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
      onChange: (value) => setState(() {
        _showNextButton = !(_tecMap.containsKey(value) &&
            _tecMap[value].inMinutes() == 0);
      }),
      showBackButton: true,
      showSkipButton: false,
      showNextButton: _showNextButton,
      showDoneButton: _showNextButton,
      isProgressTap: false,
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
        //activeColor: Colors.white, //color of active dot
        activeShape: RoundedRectangleBorder(
          //shave of active dot
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Provider.of<UserDataProvider>(context, listen: false)
        .update(DateTime.now());
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
