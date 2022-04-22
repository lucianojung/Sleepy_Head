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

  get bedTimeBeforeNow => DateTime.now().difference(
      DateTimeCopyWith(DateTime.now(),
      hour: _userData.plannedBedTime.hour,
      minute: _userData.plannedBedTime.minute)).inMinutes > 0;

  get bedTimeSchedule => DateTimeCopyWith(DateTime.now(),
      day: bedTimeBeforeNow ? DateTime.now().day + 1 : DateTime.now().day,
      hour: _userData.plannedBedTime.hour,
      minute: _userData.plannedBedTime.minute);

  get bedTimeString =>
      '${timeFormatter.format(_userData.plannedBedTime.hour)}:${timeFormatter.format(_userData.plannedBedTime.minute)}';

  get wakeUpTimeString =>
      '${timeFormatter.format(_userData.plannedWakeupTime.hour)}:${timeFormatter.format(_userData.plannedWakeupTime.minute)}';

  get sleepingTimeString =>
      '${timeFormatter.format(sleepingTime.inHours)}:${timeFormatter.format(sleepingTime.inMinutes % 60)}';

  // CRUD Methods for local Variables

  void updateUsername(String username) {
    _userData.username = username;

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

  DateTime DateTimeCopyWith(DateTime dateTime,
      {int? year, int? month, int? day, int? hour, int? minute, int? second}) {
    return DateTime(
      year ?? dateTime.year,
      month ?? dateTime.month,
      day ?? dateTime.day,
      hour ?? dateTime.hour,
      minute ?? dateTime.minute,
      second ?? dateTime.second,
    );
  }
}
