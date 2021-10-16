import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finneasy/src/ui/home/home_screen.dart';
import 'package:finneasy/src/ui/more/setting_screen.dart';
import 'package:finneasy/src/ui/orders/order_screen.dart';
import 'package:finneasy/src/ui/rewards/rewards_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class DashBoardScreen extends StatefulWidget {
  final int index;

  const DashBoardScreen({Key? key, required this.index}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initialise();
  }

  late List<Widget> _widgetOptions = [];

  int _selectedIndex = 0;
  void initialise() async {
    _widgetOptions = [HomeScreen(), StockMarketScreen(), RewardsScreen(), OrderScreen(), SettingScreen()];
    _selectedIndex = widget.index;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title:  const Text('Are you sure?'),
        content: const Text('Do you want to exit the App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child:  _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: widget.index,
          height: 50.0,
          color: Theme.of(context).bottomAppBarColor,
          buttonBackgroundColor: Theme.of(context).focusColor,
          backgroundColor: Theme.of(context).backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          letIndexChange: (index) => true,
          items: const <Widget>[
            Icon(Icons.home_outlined),
            Icon(Icons.search),
            Icon(Icons.local_offer_outlined),
            Icon(Icons.shopping_cart_outlined),
            Icon(Icons.settings)
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}