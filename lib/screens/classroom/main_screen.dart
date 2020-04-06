import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  int _pageSelectedIndex = 0;
  final List<Widget> _pageChildren = [
    Text('Stream'),
    Text('Schedules'),
    Text('Task'),
    Text('Classmates'),
  ];

  List<GButton> _tabs = new List();
  double _tabGap = 30;
  EdgeInsets _tabPadding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 5
  );
  TextStyle _navTextStyle = TextStyle(
      fontFamily: ConstantHelper.PRIMARY_FONT,
      color: Colors.blue,
      fontWeight: FontWeight.w600
  );

  @override
  void initState() {
    super.initState();

    _tabs.add(GButton(
      gap: _tabGap,
      iconActiveColor: Colors.blue,
      iconColor: Colors.blue,
      backgroundColor: Colors.blue[50],
      iconSize: 24,
      padding: _tabPadding,
      icon: LineIcons.home,
      textStyle: _navTextStyle,
      text: 'Updates',
    ));

    _tabs.add(GButton(
      gap: _tabGap,
      iconActiveColor: Colors.blue,
      iconColor: Colors.blue,
      backgroundColor: Colors.blue[50],
      iconSize: 24,
      padding: _tabPadding,
      icon: LineIcons.list_alt,
      textStyle: _navTextStyle,
      text: 'Schedule',
    ));

    _tabs.add(GButton(
      gap: _tabGap,
      iconActiveColor: Colors.blue,
      iconColor: Colors.blue,
      backgroundColor: Colors.blue[50],
      iconSize: 24,
      padding: _tabPadding,
      icon: LineIcons.tasks,
      textStyle: _navTextStyle,
      text: 'Task',
    ));

    _tabs.add(GButton(
      gap: _tabGap,
      iconActiveColor: Colors.blue,
      iconColor: Colors.blue,
      backgroundColor: Colors.blue[50],
      iconSize: 24,
      padding: _tabPadding,
      icon: LineIcons.users,
      textStyle: _navTextStyle,
      text: 'Classmates',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _tabs.length,
        itemBuilder: (context, position) => _pageChildren[position],
        onPageChanged: (page) {
          setState(() {
            _pageSelectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _bottomNav() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color :Colors.white,boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            blurRadius: 60,
            color: Colors.black.withOpacity(.20),
            offset: Offset(0,15)
          )
        ]),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            tabs: _tabs,
            selectedIndex: _pageSelectedIndex,
            onTabChange: (index) {
              setState(() {
                _pageSelectedIndex = index;
              });
              _pageController.jumpToPage(index);
            }
          ),
        ),
      ),
    );
  }
}
