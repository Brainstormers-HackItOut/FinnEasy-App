// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/search_picker.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_game/stock_game_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/store/stock_store.dart';
import 'package:finneasy/src/ui/stock_analysis/widget/credit.dart';
import 'package:finneasy/src/ui/stock_analysis/widget/debit.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:telephony/telephony.dart';

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({Key? key}) : super(key: key);


  @override
  _StockMarketScreenState createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen> with TickerProviderStateMixin {
late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StockStore _store;
  final telephony = Telephony.instance;
  List<Map<String, dynamic>> messageList = [];
  List<bool> selected = [];
  List<String> tabs = ["CREDIT", "DEBIT"];

  @override
  void initState() {
    super.initState();
    initstate();
    initPlatformState();
  }

  void _handleTabSelection() {
    setState(() {
      selected = List.filled(2, true);
      selected[_tabController.index] = false;
    });
  }

  initstate() async{
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

  Future<void> initPlatformState() async {

    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      log("Getting Messages");
      List<SmsMessage> messages = await telephony.getInboxSms(
          columns: [SmsColumn.BODY, SmsColumn.DATE],
          filter: SmsFilter
              .where(SmsColumn.BODY)
              .like("%debit%")
              .or(SmsColumn.BODY)
              .like("%credit%")
      );
      List<Map<String, dynamic>> temp = [];
      for (SmsMessage message in messages){
        temp.add({
          "msg" : message.body.toString().replaceAll(",", ""),
          "date" : DateTime.fromMillisecondsSinceEpoch(message.date!).toString().split(" ")[0]
        });
      }
      setState(() {
        messageList = temp;
      });
      // print(messageList);
    }
  }

  @override
  Widget build(BuildContext context) {
    _store = StockStore(context);
    _store.cashFlowAnalysis(messageList);
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      appBar: Appbar(
        title: "Stock Market",
      ),
      body:
            Observer(
              builder: (context) {
                print(_store.isLoading);
                return ObserverNetworkState(
                  taskToBeDone:  SingleChildScrollView(
                      child: Column(
                          children: [
                      Center(
                      child: Card(
                      margin: EdgeInsets.symmetric(vertical: 0.01 * screenHeight),
                      elevation: 5,
                      shadowColor: AppColors.primaryColor,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPicker(header: "Search", store: _store,)))
                        },
                        child: Container(
                            width: 0.8 *  MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            color: Theme.of(context).backgroundColor,
                            child: Center(
                              child: Text("Search in Listed Stocks",
                                  style: TextStyle(
                                      fontSize: 0.02 *  MediaQuery.of(context).size.height,
                                      color: AppColors.black
                                  )
                              ),
                            )
                        ),
                      )
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.9,
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
                          "Learn & Play with FinnEasy",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.white,
                              size: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Text(
                              "Learn Stock Market with us playing simple game!",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Card(
                            color: AppColors.error,
                            child: IconButton(
                              icon: Icon(Icons.play_arrow_rounded),
                              color: AppColors.white,
                              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const StockGameScreen())); },
                            )
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                      ],
                    )
                ),
                  SizedBox(height: screenHeight * 0.025),
                  Text(
                    "Cash Flow Analysis",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: screenWidth * 0.053,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
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
                  ), _store.cashFlow.isNotEmpty ? Container(
                              height: 300,
                    child: Expanded(
                      flex: 1,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Credit(credit: _store.cashFlow['CREDIT']),
                          Debit(debit: _store.cashFlow['DEBIT'])
                        ],
                      ),
                    ),
                  ) : SizedBox.shrink(),
                 ],
                ),
              ),
              networkState: _store.isLoading,
              errorOccured: ErrorScreen(
                refresh: initState,
              ),
            );
          }
      ),
    );
  }
}