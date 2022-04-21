import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:provider/provider.dart';

import '../services/user_data_provider.dart';

class TimerHomeView extends StatefulWidget {
  TimerHomeView({Key? key}) : super(key: key);

  @override
  _TimerHomeViewState createState() => _TimerHomeViewState();
}

class _TimerHomeViewState extends State<TimerHomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton.icon(
          icon: Icon(Icons.alarm, size: 32),
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              start: context.read<UserDataProvider>().userData.plannedBedTime,
              end: context.read<UserDataProvider>().userData.plannedWakeupTime,
              interval: const Duration(minutes: 15),
              minDuration: context.read<UserDataProvider>().sleepingTime,
              maxDuration: context.read<UserDataProvider>().sleepingTime,
              clockRotation: 180,
              labels: [
                ClockLabel.fromDegree(deg: 0, text: '18 o\'clock'),
                ClockLabel.fromDegree(deg: 90, text: 'Midnight'),
                ClockLabel.fromDegree(deg: 180, text: '6 o\'clock'),
                ClockLabel.fromDegree(deg: 270, text: '12 o\'clock'),
              ],
              strokeWidth: 32,
              handlerRadius: 16,
              labelOffset: -30,
              // backgroundWidget: Image.asset(
              //   "assets/images/day-night.png",
              //   height: 200,
              //   width: 200,
              // ),
            );
            context
                .read<UserDataProvider>()
                .updatePlannedBedTime(result!.startTime);
            context
                .read<UserDataProvider>()
                .updatePlannedWakeupTime(result.endTime);
          },
          label: Text(
            context.read<UserDataProvider>().sleepingTimeString,
            style: TextStyle(fontSize: 44),
          ),
        )
      ],
    );
  }
}
