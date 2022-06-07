import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/models/szenario_handler.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:sleepy_head/views/help_sam/celebration_view.dart';
import 'package:sleepy_head/views/help_sam/szenario_view.dart';
import 'package:sleepy_head/views/pages/night_view.dart';
import '../views/help_sam/question_view.dart';

import '../global_variables.dart';
import '../views/home_view.dart';
import '../views/intro_view.dart';
import '../views/pages/rive_view.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final List<dynamic> args = settings.arguments is List<dynamic> ? settings.arguments as List<dynamic> : [null, null];

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomeView(
              key: UniqueKey(),
              title: args[0] is String ? args[0] : GlobalVariables().appTitle,
              initialPageIndex: Provider.of<AppConfigProvider>(context).appConfig.homeIndex),
        );
      case '/intro':
        return MaterialPageRoute(
            builder: (_) =>
                IntroductionView(homeRoute: args[0] is String ? args[0] : '/'));
      case '/szenario':
        return MaterialPageRoute(
            builder: (_) => SzenarioView(szenarioHandler: args[0] is SzenarioHandler ? args[0] : SzenarioHandler()));
      case '/szenarioQuestion':
        return MaterialPageRoute(
            builder: (_) => SzenarioQuestionView(szenarioHandler: args[0] is SzenarioHandler ? args[0] : SzenarioHandler()));
      case '/szenarioCelebration':
        return MaterialPageRoute(
            builder: (_) => CelebrationView(szenarioHandler: args[0] is SzenarioHandler ? args[0] : SzenarioHandler()));
      case '/rive':
        return MaterialPageRoute(
            builder: (_) => RiveView());
      case '/night':
        return MaterialPageRoute(
            builder: (_) => NightView());
      default:
        return _errorRoute(message: 'wrong routing name');
    }
  }

  static Route<dynamic> _errorRoute({String? message}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('ERROR: ' + message!),
        ),
      );
    });
  }
}