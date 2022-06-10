import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleepy_head/services/app_config_provider.dart';
import 'package:sleepy_head/services/user_data_provider.dart';
import 'package:sleepy_head/views/pages/help_sam_view.dart';
import 'pages/rewards_home_view.dart';
import 'pages/routine_home_view.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/home_home_view.dart';

class HomeView extends StatefulWidget {
  final String title;
  final int initialPageIndex;

  const HomeView({Key? key, required this.title, required this.initialPageIndex}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  final starSize = 18.0;

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> _pages = <Widget>[
      HomeHomeView(),
      RoutineHomeView(),
      HelpSamView(),
      RewardsHomeView(),
    ];
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Image.asset('assets/images/logo.png'),
                // onPressed: () => print('todo navigate to profile page'),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.nameHome),
            BottomNavigationBarItem(
                icon: const Icon(Icons.timer_outlined), activeIcon: const Icon(Icons.timer), label: 'Routine'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.lightbulb_outline), activeIcon: const Icon(Icons.lightbulb), label: 'Help Sam'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.star_outline), activeIcon: const Icon(Icons.star), label: 'Reward')
          ],
          currentIndex: Provider.of<AppConfigProvider>(context, listen: true).appConfig.homeIndex,
          onTap: _onItemTapped,
        ),
        body: Stack(
          alignment: Alignment.centerRight,
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
            ),
            for (int i = 0; i < Provider.of<UserDataProvider>(context).userData.correctAnswers; i++)
              Positioned(
                child: Image.asset(
                  'assets/images/Star.png',
                ),
                width: starSize,
                height: starSize,
                top: Random().nextDouble() * size.height - starSize,
                left: Random().nextDouble() * size.width - starSize,
              ),
            Positioned(
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/Moon.png',
                ),
              ),
              width: size.width / 5,
              height: size.width / 5,
              top: 64,
              left: 96,
            ),
            PageView(
              physics: const BouncingScrollPhysics(),
              onPageChanged: ((index) => Provider.of<AppConfigProvider>(context, listen: false).updateHomeIndex(index)),
              controller: _pageController,
              children: _pages,
            ),
          ],
        ),
        drawer: drawer(),
      ),
    );
  }

  void _onItemTapped(int index) {
    // print(index);
    Provider.of<AppConfigProvider>(context, listen: false).updateHomeIndex(index);
    _pageController.animateToPage(index, duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  drawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('Created at FHSTP'),
            accountName: Text(Provider.of<UserDataProvider>(context).userData.username),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.globe, color: Colors.white),
            title: Text('Build.well.being'),
            onTap: () {
              _launchURL(GlobalVariables().buildWellBeingURL);
            },
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.idCard),
          //   title: Text(AppLocalizations.of(context)!.imprintName),
          //   onTap: () {
          //     Navigator.popAndPushNamed(context, '/impressum');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.cog),
          //   title: Text(AppLocalizations.of(context)!.settingsName),
          //   onTap: () {
          //     Navigator.popAndPushNamed(context, '/settings');
          //   },
          // ),
          Divider(),
          ListTile(
            title: Text('Version ${GlobalVariables().version}'),
          ),
          Divider(),
          Expanded(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
                // todo: logout/ login
                leading: Icon(
                  FontAwesomeIcons.arrowRightFromBracket,
                  color: Colors.white,
                ),
                title: Text('Close App'),
                onTap: () => SystemNavigator.pop()),
          )),
        ],
      ),
    );
  }

  _launchURL(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
