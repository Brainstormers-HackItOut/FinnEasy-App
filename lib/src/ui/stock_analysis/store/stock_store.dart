// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:

// Package imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/api/fin_news_api.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/ui/stock_analysis/api/stock_api.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:finneasy/src/utils/greeting.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'stock_store.g.dart';

class StockStore = _StockStore with _$StockStore;


abstract class _StockStore with Store {
  final String TAG = "_StockStore";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  NetworkState isLoading = NetworkState.initial;
  @observable
  double price = 100.00;
  @observable
  double userwealth = 100000;
  @observable
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
  @observable
  StockTweets tweets = StockTweets();

  late BuildContext context;

  _StockStore(BuildContext context_) {
    context = context_;
  }

  @action
  Future<void> stockTweetAnalysis(String query) async {
    isLoading = NetworkState.loading;
    try {
      tweets = await StockApi.stockTweetAnalysis(query);
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
    }
  }

  @action
  Future<void> cashFlowAnalysis(List<Map<String, dynamic>> messages) async {
    isLoading = NetworkState.loading;
    try {
      tweets = await StockApi.cashFlowAnalysis(messages);
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
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
  Future<void> buy() async {
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

  }

  @action
  Future<void> sell() async {
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
    }
}

