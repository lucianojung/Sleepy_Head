import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:sleepy_head/views/rewards_home_view.dart';
import 'package:sleepy_head/views/timer_home_view.dart';
import 'package:provider/provider.dart';

import '../models/reward.dart';
import '../services/user_reward_provider.dart';
import '../utils/notification_utils.dart';
import 'home_home_view.dart';

class HomeView extends StatefulWidget {
  final String title;
  final int initialPageIndex;

  const HomeView({Key? key, required this.title, required this.initialPageIndex}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex);
    NotificationUtils.scheduleBedTimePushNotification(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      TimerHomeView(),
      HomeHomeView(),
      RewardsHomeView()
    ];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.timer_outlined),
                activeIcon: const Icon(Icons.timer),
                label: AppLocalizations.of(context)!.nameTimer),
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.nameHome),
            BottomNavigationBarItem(
                icon: const Icon(Icons.star_outline),
                activeIcon: const Icon(Icons.star),
                label: AppLocalizations.of(context)!.nameRewards)
          ],
          currentIndex: Provider.of<AppConfigProvider>(context, listen: true).appConfig.homeIndex,
          onTap: _onItemTapped,
        ),
        body: PageView(
            physics: const BouncingScrollPhysics(),
            onPageChanged: ((index) => Provider.of<AppConfigProvider>(context, listen: false).updateHomeIndex(index)),
            controller: _pageController,
            children: _pages),
      ),
    );
  }

  void _onItemTapped(int index) {
    print(index);
    Provider.of<AppConfigProvider>(context, listen: false).updateHomeIndex(index);
    _pageController.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }
}
