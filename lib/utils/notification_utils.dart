import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/user_data_provider.dart';

class NotificationUtils {

  static scheduleBedTimePushNotification(BuildContext context) async {
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
                .bedTimeSchedule));
  }
}
