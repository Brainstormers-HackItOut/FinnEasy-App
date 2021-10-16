// Flutter imports:
import 'dart:async';
import 'dart:math';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/stock_game/store/stock_game_store.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class StockGameScreen extends StatefulWidget {
  const StockGameScreen({Key? key}) : super(key: key);

  @override
  _StockGameScreenState createState() => _StockGameScreenState();
}

class _StockGameScreenState extends State<StockGameScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StockGameStore _stockGameStore;

  @override
  Widget build(BuildContext context) {
    _stockGameStore = StockGameStore(context);

    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          key: _scaffoldKey,
          appBar: Appbar(
            title: "StockGame",
            trailingIcon: _stockGameStore.start_or_stop == 'START' ? Icon(Icons.play_arrow) : Icon(Icons.stop),
            trailingFunction: () {
              _stockGameStore.startStopFuntion();
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10),
                height: screenHeight / 3,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "FinnEasy!",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: screenWidth * 0.1,
                                color: AppColors.primaryColor
                            )
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Wrap(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                '₹' + _stockGameStore.price.toStringAsFixed(2),
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: screenWidth * 0.075,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Icon(
                                _stockGameStore.myicon,
                                color: _stockGameStore.iconcolor,
                              ),
                              Baseline(
                                baseline: 30,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  _stockGameStore.updownprice.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: _stockGameStore.icon_text,
                                    fontSize: screenWidth * 0.065,
                                  ),
                                ),
                              )
                            ]),
                      ]),
                    ),
                    SizedBox(
                      width: screenWidth / 2,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Low',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: screenWidth * 0.065,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _stockGameStore.low.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'High',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: screenWidth * 0.065,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _stockGameStore.high.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: screenHeight / 2.5,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text(
                        'BUY THIS',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: screenWidth * 0.063,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: screenWidth / 1.2,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          for (var i in [1.2, 2.4, 3.6, _stockGameStore.sharesbought])
                          MaterialButton(
                            onPressed: () {
                              _stockGameStore.totalnumofshare =
                                    _stockGameStore.number_of_shares ~/ i;
                            },
                            child: Text(
                              (_stockGameStore.number_of_shares / i).toStringAsFixed(0),
                              style: TextStyle(
                                color: Color(0xff2B76C6),
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                            shape: Border.all(
                              color: const Color(0xff2B76C6),
                            ),
                            minWidth: screenWidth / 9,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * .9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              if (_stockGameStore.totalnumofshare > 1) {
                                _stockGameStore.totalnumofshare--;
                              }
                            },
                            child: Icon(
                              Icons.expand_more,
                              color: AppColors.white,
                              size: screenWidth * 0.075,
                            ),
                            color: AppColors.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            color: AppColors.white,
                            width: MediaQuery.of(context).size.width / 2.5,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                _stockGameStore.totalnumofshare.toString(),
                                style: TextStyle(
                                  color: Color(0xff1B1D38),
                                  wordSpacing: 1.5,
                                  fontSize: screenWidth * 0.055,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              _stockGameStore.totalnumofshare++;
                            },
                            color: AppColors.success,
                            child: Icon(
                              Icons.expand_less,
                              color: AppColors.white,
                              size: screenWidth * 0.075,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      RoundedButton(
                        onTap: () {
                          _stockGameStore.buy();
                        },
                        child: Text(
                          '  BUY  ',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w900),
                        ),
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(5),
                        splashColor: AppColors.white,
                        height: 40,
                        width: 100,
                        blurRadius: 0,
                        borderColor: AppColors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RoundedButton(
                        onTap: () {
                          _stockGameStore.sell();
                        },
                        child: Text(
                          '  SELL  ',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w900),
                        ),
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(5),
                        splashColor: AppColors.primaryColor,
                        height: 40,
                        width: 100,
                        blurRadius: 0,
                        borderColor: AppColors.primaryColor,
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "BANK : ₹" + _stockGameStore.userwealth.toStringAsFixed(2),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: screenWidth * 0.065
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}