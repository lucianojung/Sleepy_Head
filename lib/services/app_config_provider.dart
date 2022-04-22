import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../models/app_config.dart';

class AppConfigProvider extends ChangeNotifier {
  AppConfig _appConfig = AppConfig();

  AppConfig get appConfig => _appConfig;

  AppConfigProvider() {
    initialState();
  }

  void initialState() {
    syncDataWithProvider();
  }

  // additional getters

  get lastUpdateToday => DateTime.now().isAfter(_appConfig.lastUpdate
      .subtract(Duration(
      hours: _appConfig.lastUpdate.hour,
      minutes: _appConfig.lastUpdate.minute))
      .add(const Duration(days: 1)));


  // CRUD Methods for local Variables

  void updateInitialRoute(String route) {
    if (_appConfig.initialRoute == route) {
      return;
    }
    _appConfig.initialRoute = route;

    updateSharedPrefrences();
    notifyListeners();
  }

  void updateHomeIndex(int index) {
    _appConfig.homeIndex = index;

    updateSharedPrefrences();
    notifyListeners();
  }

  void update(DateTime lastUpdate) {
    _appConfig.lastUpdate = lastUpdate;

    updateSharedPrefrences();
    notifyListeners();
  }

  // shared preference Methods

  void updateSharedPrefrences() async {
    String appConfigString = json.encode(_appConfig.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('appConfig', appConfigString);
    notifyListeners();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString('appConfig');

    if (result != null) {
      _appConfig = AppConfig.fromJson(json.decode(result));
    }
    if (_appConfig.initialRoute == '') {
      updateInitialRoute(lastUpdateToday ? '/' : '/intro');
    }
    notifyListeners();
  }
}
