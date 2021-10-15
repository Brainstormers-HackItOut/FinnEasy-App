// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:

// Package imports:
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/api/fin_news_api.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/utils/greeting.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;


abstract class _HomeStore with Store {
  final String TAG = "_HomeStore";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  Map<String, dynamic> data = {};

  @observable
  bool shouldShow = true;

  @observable
  String greetingMessage = "";

  @observable
  NetworkState isLoading = NetworkState.initial;

  @observable
  FinNews news = FinNews();

  _HomeStore() {
    refreshHome();
    shouldShowGreeting();
  }

  @action
  Future<void> refreshHome() async {
    isLoading = NetworkState.loading;
    try {
      news = await FinNewsApi.fetchNews();
      greetingMessage = greeting();
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
    }
  }

  @action
  Future<void> shouldShowGreeting() async {
    await Future.delayed(Duration(seconds: 5));
    shouldShow = false;
  }

}

