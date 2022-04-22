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
              ticks: 24,
              ticksOffset: -16,
              ticksColor: Theme.of(context).primaryColor,
              ticksLength: 8,
              labels: [
                ClockLabel.fromDegree(deg: 90, text: '0'),
                ClockLabel.fromDegree(deg: 120, text: '2'),
                ClockLabel.fromDegree(deg: 150, text: '4'),
                ClockLabel.fromDegree(deg: 180, text: '6'),
                ClockLabel.fromDegree(deg: 210, text: '8'),
                ClockLabel.fromDegree(deg: 240, text: '10'),
                ClockLabel.fromDegree(deg: 270, text: '12'),
                ClockLabel.fromDegree(deg: 300, text: '14'),
                ClockLabel.fromDegree(deg: 330, text: '16'),
                ClockLabel.fromDegree(deg: 0, text: '18'),
                ClockLabel.fromDegree(deg: 30, text: '20'),
                ClockLabel.fromDegree(deg: 60, text: '22'),
              ],
              strokeWidth: 24,
              handlerRadius: 12,
              labelOffset: -42,
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
            style: const TextStyle(fontSize: 44),
          ),
        )
      ],
    );
  }
}
