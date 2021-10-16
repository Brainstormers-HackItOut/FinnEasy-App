// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/home/model/blog_response.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:finneasy/src/ui/home/widget/blog_create_alert.dart';
import 'package:finneasy/src/ui/home/widget/fweets.dart';
import 'package:finneasy/src/ui/home/widget/home_card.dart';
import 'package:finneasy/src/ui/home/widget/news.dart';
import 'package:finneasy/src/ui/notification/notification_screen.dart';
import 'package:finneasy/src/ui/profile/profile_screen.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late HomeStore _homeStore;
  List<bool> selected = [];
  List<String> tabs = ["Fweets", "News"];

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
    _homeStore = HomeStore();
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
              key: _homeStore.scaffoldKey,
              floatingActionButton: FloatingActionButton(
                onPressed: () async{
                  await showDialog(
                      context: context,
                      builder: (context) =>  BlogCreateForm(store: _homeStore));
                },
                child: Icon(
                  Icons.add
                ),
              ),
              appBar: Appbar(
                title: _homeStore.shouldShow ? _homeStore.greetingMessage : "",
                trailingIcon: const Icon(Icons.notifications),
                trailingFunction: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()))
                ,
              ),
              body: ObserverNetworkState(
                networkState: _homeStore.isLoading,
                taskToBeDone: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HomeCard(store: _homeStore,),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: screenWidth * 0.55,
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.transparent,
                            tabs: [
                              for (int i = 0; i < tabs.length; i++)
                                Container(
                                  height: screenWidth*0.1,
                                  width: screenWidth*0.35,
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
                              Fweets(blogs: _homeStore.blog, store: _homeStore,),
                              News(news: _homeStore.news)
                            ],
                          ),
                        )
                      ],
                    )
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