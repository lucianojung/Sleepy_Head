import 'package:flutter/material.dart';
import 'package:sleepy_head/global_variables.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = GlobalVariables().initialHomePageIndex;
  final _pageController =
      PageController(initialPage: GlobalVariables().initialHomePageIndex);

  final List<Widget> _pages = <Widget>[
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: T ext(widget.title),
        //   actions: [
        //     ThemeSwitcher(
        //       clipper: const ThemeSwitcherCircleClipper(),
        //       builder: (context) {
        //         return IconButton(
        //             onPressed: () {
        //               setState(() {
        //                 _isDark = !_isDark;
        //               });
        //             },
        //             icon: Icon(
        //                 !_isDark ? Icons.brightness_2 : Icons.wb_sunny));
        //       },
        //     )
        //   ],
        // ),
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            children: _pages),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }
}
