// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:

// Package imports:
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/rewards/model/reward.dart';
import 'package:finneasy/src/ui/rewards/api/reward_api.dart';
import 'package:finneasy/src/utils/greeting.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'reward_store.g.dart';

class RewardsStore = _RewardsStore with _$RewardsStore;


abstract class _RewardsStore with Store {
  final String TAG = "_RewardsStore";

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
  List<Reward> rewards = [];

  _RewardsStore() {
    refreshRewards();
  }

  @action
  Future<void> refreshRewards() async {
    isLoading = NetworkState.loading;
    try {
      rewards = await RewardApi.rewardsMileStone();
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
    }
  }

}

