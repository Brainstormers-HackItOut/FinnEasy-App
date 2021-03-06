// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:

// Package imports:
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/orders/api/order_api.dart';
import 'package:finneasy/src/ui/orders/model/order.dart';
import 'package:finneasy/src/utils/greeting.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;


abstract class _OrderStore with Store {
  final String TAG = "_OrderStore";

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
  List<Order> orders = [];

  _OrderStore() {
    refreshOrder();
  }

  @action
  Future<void> refreshOrder() async {
    isLoading = NetworkState.loading;
    try {
      orders = await OrderApi.fetchAllOrder();
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
    }
  }

}

