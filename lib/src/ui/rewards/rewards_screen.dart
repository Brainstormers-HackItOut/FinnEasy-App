// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/rewards/store/reward_store.dart';
import 'package:finneasy/src/ui/rewards/widget/milestone.dart';
import 'package:finneasy/src/ui/rewards/widget/redeemed_rewards.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late RewardsStore _rewardsStore;
  List<bool> selected = [];
  List<String> tabs = ["MileStone", "Rewards Redeemed"];

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
    _rewardsStore = RewardsStore();
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
              key: _rewardsStore.scaffoldKey,
              appBar: Appbar(
                title: "Rewards",
              ),
              body: ObserverNetworkState(
                networkState: _rewardsStore.isLoading,
                taskToBeDone: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
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
                          Milestone(),
                          RedeemedRewards()
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