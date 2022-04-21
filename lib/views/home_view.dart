import 'package:flutter/material.dart';
import 'package:sleepy_head/global_variables.dart';

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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined),
                activeIcon: Icon(Icons.timer),
                label: "Timer"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_outline),
                activeIcon: Icon(Icons.star),
                label: "Rewards")
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
