// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:finneasy/src/ui/rewards/store/reward_store.dart';
import 'package:finneasy/src/ui/rewards/widget/milestone.dart';
import 'package:finneasy/src/ui/rewards/widget/redeemed_rewards.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:timelines/timelines.dart';

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
  final HomeStore _homeStore = HomeStore(notHome: true);

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
              body: _homeStore.user.milestoneNumber != null ? ObserverNetworkState(
                networkState: _rewardsStore.isLoading,
                taskToBeDone: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.95,
                        margin: EdgeInsets.fromLTRB(0, screenWidth * 0.04, screenWidth * 0.04,0),
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.lighten(Theme.of(context).focusColor, 0.2),
                              Theme.of(context).focusColor,
                              AppColors.darken(Theme.of(context).focusColor, 0.1),
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.1)
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MileStones",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: screenWidth * 0.065,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Flexible(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.white,
                                    size: screenWidth * 0.05,
                                  ),
                                  SizedBox(width: screenWidth * 0.015),
                                  Text(
                                    "Milestones are points where you earn exclusive \nrewards from our partners",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                          ],
                        )
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Center(
                      child: SizedBox(
                        height: 150,
                        child: Timeline.tileBuilder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          builder: TimelineTileBuilder.fromStyle(
                            contentsBuilder: (context, index) => Card(
                              color: index < _homeStore.user.milestoneNumber! ? Theme.of(context).cardColor : AppColors.darken(AppColors.error),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_rewardsStore.rewards[index].title.toString()),
                              ),
                            ),
                            oppositeContentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Milestone $index"),
                            ),
                            contentsAlign: ContentsAlign.alternating,
                            itemCount: _rewardsStore.rewards.length,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    Text(
                      "Rewards collected and in Progress right now ..",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Milestone(rewards: _rewardsStore.rewards, currentMileStone: _homeStore.user.milestoneNumber!),
                  ],
                ),
                errorOccured: ErrorScreen(
                  refresh: initstate,
                ),
              ) : SizedBox.shrink()
          );
        }
    );
  }
}