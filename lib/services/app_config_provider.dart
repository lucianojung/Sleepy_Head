import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepy_head/utils/date_time_utils.dart';

import 'dart:convert';

import '../models/app_config.dart';

class AppConfigProvider extends ChangeNotifier {
  AppConfig _appConfig = AppConfig();

  AppConfig get appConfig => _appConfig;

  String get initialRoute => lastUpdateToday ? '/' : '/intro';

  AppConfigProvider() {
    initialState();
  }

  void initialState() {
    syncDataWithProvider();
  }

  // additional getters

  get lastUpdateToday => DateTime.now().isBefore(
        DateTimeUtils.DateTimeCopyWith(_appConfig.lastUpdate,
            day: _appConfig.lastUpdate.day + 1, hour: 0, minute: 0, second: 0),
      );

  // CRUD Methods for local Variables

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
    if (_appConfig.lastUpdate == DateTime.fromMillisecondsSinceEpoch(0)) {
      update(DateTime.fromMillisecondsSinceEpoch(1000));
    }
    notifyListeners();
  }
}
