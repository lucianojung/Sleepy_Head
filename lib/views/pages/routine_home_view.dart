import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:provider/provider.dart';

import '../../services/user_data_provider.dart';

class RoutineHomeView extends StatefulWidget {
  RoutineHomeView({Key? key}) : super(key: key);

  @override
  _RoutineHomeViewState createState() => _RoutineHomeViewState();
}

class _RoutineHomeViewState extends State<RoutineHomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
          child: RiveAnimation.asset(
            'assets/Sam_Lit.riv',
            artboard: 'Sam Walking',
            stateMachines: ['Sam_State_Walking'],
            alignment: Alignment.topRight,
            fit: BoxFit.fitHeight,
          ),
        ),
        TextButton.icon(
          icon: Icon(Icons.alarm, size: 32),
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              start: context.read<UserDataProvider>().userData.plannedBedTime,
              end: context.read<UserDataProvider>().userData.plannedWakeupTime,
              interval: const Duration(minutes: 1),
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
            if(result != null) {
              context
                  .read<UserDataProvider>()
                  .updatePlannedBedTime(result.startTime);
              context
                  .read<UserDataProvider>()
                  .updatePlannedWakeupTime(result.endTime);
            }

          },
          label: Text(
            context.read<UserDataProvider>().wakeUpTimeString,
            style: const TextStyle(fontSize: 44),
          ),
        )
      ],
    );
  }
}
