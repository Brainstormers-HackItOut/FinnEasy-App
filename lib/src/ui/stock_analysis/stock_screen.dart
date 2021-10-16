// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/search_picker.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_game/stock_game_screen.dart';
import 'package:finneasy/src/ui/stock_analysis/store/stock_store.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({Key? key}) : super(key: key);


  @override
  _StockMarketScreenState createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StockStore _store;
  final telephony = Telephony.instance;
  List<Map<String, dynamic>> messageList = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
          "sms" : message.body,
          "date" : DateTime.fromMillisecondsSinceEpoch(message.date!).toString().split(" ")[0]
        });
      }
      setState(() {
        messageList = temp;
      });
      // print(messageList);
      _store.cashFlowAnalysis(messageList);
    }
  }

  @override
  Widget build(BuildContext context) {
    _store = StockStore(context);
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      appBar: Appbar(
        title: "Stock Market",
        trailingIcon: const Icon(Icons.play_arrow),
        trailingFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StockGameScreen())),
      ),
      body: SingleChildScrollView(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}