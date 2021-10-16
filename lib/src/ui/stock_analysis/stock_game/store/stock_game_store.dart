// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:math';

// Flutter imports:

// Package imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'stock_game_store.g.dart';

class StockGameStore = _StockGameStore with _$StockGameStore;


abstract class _StockGameStore with Store {
  @observable
  int totatltime = 500;
  @observable
  double price = 100.00;
  @observable
  bool startstop = false;
  @observable
  double num = 0.00;
  @observable
  double add = 100.00;
  @observable
  int news = 0;
  @observable
  double updownprice = 0.0;
  @observable
  double startprice = 100;
  @observable
  Color icon_text = Colors.white;
  @observable
  String start_or_stop = 'START';
  @observable
  double userwealth = 100000;
  @observable
  IconData myicon = Icons.arrow_upward;
  @observable
  Color iconcolor = AppColors.success;
  @observable
  int number_of_shares = 0;
  @observable
  int totalnumofshare = 0;
  @observable
  int sharesbought = 0;
  @observable
  double high = 100;
  @observable
  double low = 100;
  
  late BuildContext context;

  _StockGameStore(BuildContext context_){
    context = context_;
  }
  @action
  Future<void> startStopFuntion() async {
    if (start_or_stop == 'START') {
      setstatesws('START');
      numberofshares(0);
      startstop = true;
      changeprice();
    } else if (start_or_stop == 'STOP') {
      startstop = false;
      setstatesws('STOP');
    }
  }
  _showFlushbar() {
    showFlushBar(
      context, 
      "Success, Bought $totalnumofshare shares at the rate of " +
      price.toStringAsFixed(2) +
      ', Shares owned: $sharesbought',
      backgroundColor: AppColors.success,
      icon: Icons.check
    );
  }

  _showFlushbarsell() {
    showFlushBar(
        context,
        "Success, Sold $totalnumofshare shares at the rate of " +
            price.toStringAsFixed(2) +
            ', shares owned: $sharesbought',
        backgroundColor: AppColors.success,
        icon: Icons.check
    );
  }

  @action
  void numberofshares(int num) {
    if (num == 0) {
      number_of_shares = userwealth ~/ startprice;
    } else if (num == 1) {}
  }

  @action
  void changecolor(double diff) {
    if (diff >= 0) {
      icon_text = AppColors.success;
      myicon = Icons.arrow_upward;
      iconcolor = AppColors.success;
    } else {
      myicon = Icons.arrow_downward;
      icon_text = AppColors.error;
      iconcolor = AppColors.error;
    }
  }

  double _getrandom() {
    int num = Random().nextInt(10);
    List<dynamic> addnum = [
      0.10,
      -0.10,
      0.05,
      -.05,
      0.15,
      -.10,
      0.20,
      -.05,
      0.10,
      -.05,
    ];
    return addnum[num];
  }

  @action
  void setstatesws(String onorof) {
      if (onorof == 'START') {
        start_or_stop = 'STOP';
      } else {
        start_or_stop = 'START';
      }
  }

  @action
  void changeprice() {
    if (startstop == true) {
      Timer _timer = Timer(Duration(milliseconds: totatltime), () {
        totatltime = 1800;
        if (startstop == true) {
          int news = Random().nextInt(10);
          switch (news) {
            case 0:
              add = add + _getrandom();
              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;

              break;
            case 1:
              add = add + _getrandom();

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 2:
              add = add + 0.30;

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 3:
              add = add - .40;

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 4:
              add = add + _getrandom();

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 5:
              add = add - .40;

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 6:
              add = add + _getrandom();

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 7:
              add = add + _getrandom();

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 8:
              add = add + _getrandom();

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
            case 9:
              add = add + 0.30;

              updownprice = add - startprice;
              changecolor(updownprice);
              price = add;
              break;
          }
          if (high < price) {
            high = price;
          } else if (low > price) {
            low = price;
          }
          changeprice();
        }
      });
      }
  }

  @action
  Future<void> buy() async {
    if (startstop == true) {
      if (price * totalnumofshare <= userwealth) {
        if (totalnumofshare > 0) {
          
            userwealth =
                userwealth - (price * totalnumofshare);
            sharesbought = sharesbought + totalnumofshare;
            number_of_shares = userwealth ~/ price;
            _showFlushbar();
        } else {
          showFlushBar(
            context,
            'Number of shares must be greater than 0',
          );
        }
      } else {
        showFlushBar(
          context,
          'Cannot buy because of low Bank Balance',
        );
      }
    } else {
      showFlushBar(
        context,
        'Press Start button to Buy',
      );
    }
  }

  @action
  Future<void> sell() async {
    if (startstop == true) {
      if (totalnumofshare <= sharesbought) {
        if (totalnumofshare > 0) {
            userwealth =
                userwealth + (totalnumofshare * price);
            sharesbought = sharesbought - totalnumofshare;
            number_of_shares = userwealth ~/ price;
            _showFlushbarsell();
        } else {
          showFlushBar(
            context,
            'Number of shares must be greater than 0',
          );
        }
      } else {
        showFlushBar(
          context,
          'Cannot sell because of low shares',
        );
      }
    } else {
      showFlushBar(
        context,
        'Press Start button to Sell',
      );
    }
  }

}

