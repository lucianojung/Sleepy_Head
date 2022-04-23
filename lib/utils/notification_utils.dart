import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/user_data_provider.dart';

class NotificationUtils {

  static scheduleBedTimePushNotification(BuildContext context) async {
    if(Platform.isAndroid || Platform.isIOS) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'channelKey',
              title:
              'Its BedTime (${Provider.of<UserDataProvider>(context, listen: false).bedTimeString})',
              body:
              'Your alarm is ringing at ${Provider.of<UserDataProvider>(context, listen: false).wakeUpTimeString}'),
          schedule: NotificationCalendar.fromDate(
              date: Provider.of<UserDataProvider>(context, listen: false)
                  .bedTimeSchedules[0]));
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 2,
              channelKey: 'channelKey',
              title:
              'Its BedTime (${Provider.of<UserDataProvider>(context, listen: false).bedTimeString})',
              body:
              'Your alarm is ringing at ${Provider.of<UserDataProvider>(context, listen: false).wakeUpTimeString}'),
          schedule: NotificationCalendar.fromDate(
              date: Provider.of<UserDataProvider>(context, listen: false)
                  .bedTimeSchedules[1]));
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 3,
              channelKey: 'channelKey',
              title:
              'Its BedTime (${Provider.of<UserDataProvider>(context, listen: false).bedTimeString})',
              body:
              'Your alarm is ringing at ${Provider.of<UserDataProvider>(context, listen: false).wakeUpTimeString}'),
          schedule: NotificationCalendar.fromDate(
              date: Provider.of<UserDataProvider>(context, listen: false)
                  .bedTimeSchedules[2]));
    } else {
      print('schedule BedTime Alarm is not possible. Plattform is neither Android nor IOS');
    }
  }
}
