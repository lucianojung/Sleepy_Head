import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/services/user_data_provider.dart';

class HomeHomeView extends StatefulWidget {
  HomeHomeView({Key? key}) : super(key: key);

  @override
  _HomeHomeViewState createState() => _HomeHomeViewState();
}

class _HomeHomeViewState extends State<HomeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: (() => context.read<UserDataProvider>().update(
                  DateTime.now().subtract(const Duration(days: 12)),
                )),
            child: const Text(
                'Reset LastUpdate (-> to see welcome screen again after reload)'))
      ],
    );
  }
}
