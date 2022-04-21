import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../views/home_view.dart';
import '../views/intro_view.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeView(
              key: UniqueKey(),
              title: args is String ? args : GlobalVariables().appTitle),
        );
      case '/intro':
        return MaterialPageRoute(
            builder: (_) =>
                IntroductionView(homeRoute: args is String ? args : '/'));
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