import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../services/user_data_provider.dart';
import '../theme_config.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();

  final String homeRoute;

  const IntroductionView({required this.homeRoute});
}

class _IntroductionViewState extends State<IntroductionView> {
  TextEditingController tecQuestion1 = TextEditingController();
  TextEditingController tecQuestion2 = TextEditingController();
  var _showNextButton = true;
  double _score = 0;
  var _tecMap = {};

  @override
  Widget build(BuildContext context) {
    _tecMap = {1: tecQuestion1, 2: tecQuestion2};
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
        bodyWidget: textWidget(AppLocalizations.of(context)
            !.newUserWelcomeText('Sleepy Head', 'Sid')),
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
              textFieldWidget(tecQuestion1),
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
              textFieldWidget(tecQuestion2),
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
            (_tecMap[value] as TextEditingController).text == '');
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
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
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
    Provider.of<UserDataProvider>(context, listen: false).update(DateTime.now());
    Navigator.popAndPushNamed(context, widget.homeRoute);
  }

  void onTextInputChanges(newValue) {
    setState(() {
      _showNextButton = newValue != '';
      var exactScore = (double.tryParse(tecQuestion1.text) ?? 0) /
          (double.tryParse(tecQuestion2.text) ?? 1);
      _score = double.parse(exactScore.toStringAsFixed(2));
    });
  }

  Widget introImage(String assetName) {
    //widget to show intro image
    return Image.asset(assetName,
        colorBlendMode: BlendMode.lighten,
        color: Colors.white10,
        fit: BoxFit.fitHeight,
        height: MediaQuery.of(context).size.height,);
  }

  Widget textWidget(String? text) {
    return Text(
      text ?? '',
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget textFieldWidget(TextEditingController textEditingController) {
    return TextField(
      style: textStyle,
      textAlign: TextAlign.center,
      controller: textEditingController,
      onChanged: onTextInputChanges,
    );
  }
}
