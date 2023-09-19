import 'package:Perso/core/navigation/bottom_nav_bar_tab_item.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final tabs = [
  const ScaffoldWithNavBarTabItem(
    initialLocation: ScreenNavigationKey.home,
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: ScreenNavigationKey.trainings,
    icon: Icon(Icons.sports_gymnastics),
    label: 'Training',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: ScreenNavigationKey.chat,
    icon: Icon(Icons.chat),
    label: 'Chat',
  ),
];

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {

  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    // if (tabIndex != _currentIndex) {
    //   // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
