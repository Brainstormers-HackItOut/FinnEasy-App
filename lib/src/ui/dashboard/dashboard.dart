import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finneasy/src/ui/home/home_screen.dart';
import 'package:finneasy/src/ui/more/setting_screen.dart';
import 'package:finneasy/src/ui/orders/order_screen.dart';
import 'package:finneasy/src/ui/rewards/rewards_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_screen.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  final int index;

  const DashBoardScreen({Key? key, required this.index}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _bottomNavigationKey = GlobalKey();
  late String firstName;

  @override
  void initState() {
    super.initState();
    initialise();
  }

  int _selectedIndex = 0;
  void initialise() async {
    _selectedIndex = widget.index;
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  final List<Widget> _widgetOptions = const [HomeScreen(), StockMarketScreen(), RewardsScreen(), OrderScreen(), SettingScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child:  _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: widget.index,
        height: 50.0,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
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
    );
  }
}