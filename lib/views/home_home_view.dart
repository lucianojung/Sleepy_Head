import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class HomeHomeView extends StatefulWidget {
  HomeHomeView({Key? key}) : super(key: key);

  @override
  _HomeHomeViewState createState() => _HomeHomeViewState();
}

class _HomeHomeViewState extends State<HomeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: (() => context.read<UserDataProvider>().update(
                DateTime.now().subtract(const Duration(days: 12)),
              )),
          child: const Text(
              'Reset LastUpdate (-> to see welcome screen again after reload)'),
        ),
      ],
    );
  }
}
