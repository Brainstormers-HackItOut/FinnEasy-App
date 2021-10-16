// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/notification/notification_screen.dart';
import 'package:finneasy/src/ui/orders/store/order_store.dart';
import 'package:finneasy/src/ui/orders/widget/orders.dart';
import 'package:finneasy/src/ui/orders/widget/rewards.dart';
import 'package:finneasy/src/ui/profile/profile_screen.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late OrderStore _orderStore;
  List<bool> selected = [];
  List<String> tabs = ["Stock Purchased", "Rewards Redeemed"];

  @override
  void initState() {
    super.initState();
    initstate();
  }

  void _handleTabSelection() {
    setState(() {
      selected = List.filled(2, true);
      selected[_tabController.index] = false;
    });
  }

  initstate() async{
    _orderStore = OrderStore();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabSelection);
    setState(() {
      selected = List.filled(tabs.length, true);
      selected[_tabController.index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Observer(
        builder: (context) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              key: _orderStore.scaffoldKey,
              appBar: Appbar(
                title: _orderStore.shouldShow ? _orderStore.greetingMessage : "",
                leadingIcon: const Icon(Icons.account_circle_outlined),
                leadingFunction: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
                trailingIcon: const Icon(Icons.notifications),
                trailingFunction: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()))
                ,
              ),
              body: ObserverNetworkState(
                networkState: _orderStore.isLoading,
                taskToBeDone: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      width: screenWidth * 0.95,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          for (int i = 0; i < tabs.length; i++)
                            Container(
                              height: screenWidth*0.1,
                              width: screenWidth*0.45,
                              child: Center(
                                child: Text(
                                  tabs[i].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: screenWidth*0.03,
                                    color: selected[i]
                                        ? Theme.of(context).focusColor
                                        : Theme.of(context).secondaryHeaderColor,),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: !selected[i]
                                    ? Theme.of(context).focusColor
                                    : Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.all(Radius.circular(screenWidth*0.3)),
                                border: Border.all(
                                    width: 1.5,
                                    color: !selected[i]
                                        ? Theme.of(context).focusColor
                                        : Theme.of(context).primaryColor
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.015,
                    ),
                    Expanded(
                      flex: 1,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Orders(),
                          Rewards()
                        ],
                      ),
                    )
                  ],
                ),
                errorOccured: ErrorScreen(
                  refresh: initstate,
                ),
              )
          );
        }
    );
  }
}