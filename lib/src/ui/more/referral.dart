// Flutter imports:
import 'dart:math';

import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/information_cell.dart';
import 'package:finneasy/src/widget/list_cell.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// Project imports:

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);


  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: Appbar(
          title: "Invite Your Friends",
        ),
        body: SingleChildScrollView(
      child: Column (
        children: <Widget>[
          InformationCell(
            heading: "You Get",
            content: "1. 420 Coins on successful SignUp of Friend. \n 2. 1 Year Amazon Prime Subscription on Friend 5th MileStone",
          ),
          InformationCell(
            heading: "Friends Get",
            content: "1. 240 Coins on successful SignUp. \n 2. 3 Month Zomato Gold Subscription on 1st MileStone",
          ),

        ],
      ),
    ));
  }
}
