import 'package:flutter/material.dart';

class UserData {
  var id = -1;
  var username = 'Sleepy Head';
  var correctAnswers = 0;
  var plannedBedTime = TimeOfDay.now();
  var plannedWakeupTime = TimeOfDay(hour: (TimeOfDay.now().hour + 8) % 24, minute: TimeOfDay.now().minute);

  UserData({id, username, homeIndex, plannedBedTime, correctAnswers, plannedWakeupTime, lastUpdate}){
    this.id = id ?? this.id;
    this.username = username ?? this.username;
    this.correctAnswers = correctAnswers ?? this.correctAnswers;
    this.plannedBedTime = plannedBedTime ?? this.plannedBedTime;
    this.plannedWakeupTime = plannedWakeupTime ?? this.plannedWakeupTime;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'correctAnswers': correctAnswers,
        'plannedBedTime': _timeOfDayToMillisecondsSinceEpoch(plannedBedTime),
        'plannedWakeupTime': _timeOfDayToMillisecondsSinceEpoch(plannedWakeupTime),
      };

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        correctAnswers = json['correctAnswers'],
        plannedBedTime = _millisecondsSinceEpochToTimeOfDay(json['plannedBedTime']),
        plannedWakeupTime = _millisecondsSinceEpochToTimeOfDay(json['plannedWakeupTime'])
  ;

  static TimeOfDay _millisecondsSinceEpochToTimeOfDay(int millisecondsSinceEpoch) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static int _timeOfDayToMillisecondsSinceEpoch(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return dateTime.millisecondsSinceEpoch;
  }
}
