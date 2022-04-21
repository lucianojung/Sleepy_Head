import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../models/user_data.dart';

class UserDataProvider extends ChangeNotifier {
  UserData _userData = UserData();
  NumberFormat timeFormatter = new NumberFormat('00');

  UserData get userData => _userData;

  UserDataProvider() {
    initialState();
  }

  void initialState() {
    syncDataWithProvider();
  }

  // additional getters

  Duration get sleepingTime => Duration(
      hours:
          (_userData.plannedWakeupTime.hour - _userData.plannedBedTime.hour) %
              24,
      minutes: (_userData.plannedWakeupTime.minute -
              _userData.plannedBedTime.minute) %
          60);

  get lastUpdateToday => DateTime.now().isAfter(_userData.lastUpdate
      .subtract(Duration(
          hours: _userData.lastUpdate.hour,
          minutes: _userData.lastUpdate.minute))
      .add(const Duration(days: 1)));

  get bedTimeString =>
      '${_userData.plannedBedTime.hour}:${_userData.plannedBedTime.minute}';

  get wakeUpTimeString =>
      '${_userData.plannedWakeupTime.hour}:${_userData.plannedWakeupTime.minute}';

  get sleepingTimeString =>
      '${timeFormatter.format(sleepingTime.inHours)}:${timeFormatter.format(sleepingTime.inMinutes % 60)}';

  // CRUD Methods for local Variables

  void updateUsername(String username) {
    _userData.username = username;

    updateSharedPrefrences();
    notifyListeners();
  }

  void update(DateTime lastUpdate) {
    _userData.lastUpdate = lastUpdate;

    updateSharedPrefrences();
    notifyListeners();
  }

  void updatePlannedBedTime(TimeOfDay plannedBedTime) {
    _userData.plannedBedTime = plannedBedTime;

    updateSharedPrefrences();
    notifyListeners();
  }

  void updatePlannedWakeupTime(TimeOfDay plannedWakeupTime) {
    _userData.plannedWakeupTime = plannedWakeupTime;

    updateSharedPrefrences();
    notifyListeners();
  }

  void updateHomeIndex(int index) {
    _userData.homeIndex = index;

    updateSharedPrefrences();
    notifyListeners();
  }

  // shared preference Methods

  void updateSharedPrefrences() async {
    String userDataString = json.encode(_userData.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userData', userDataString);
    notifyListeners();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString('userData');

    if (result != null) {
      _userData = UserData.fromJson(json.decode(result));
    }
    notifyListeners();
  }
}
