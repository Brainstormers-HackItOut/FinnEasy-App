// Flutter imports:
import 'dart:math';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/information_cell.dart';
import 'package:finneasy/src/widget/list_cell.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// Project imports:

class ReferralScreen extends StatefulWidget {
  final String referral;
  const ReferralScreen({Key? key, required this.referral}) : super(key: key);


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
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/referral.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: null),
          InformationCell(
            heading: "You Get",
            content: "1. 420 Coins on successful SignUp of Friend. \n\n2. 1 Year Amazon Prime Subscription on Friend 5th MileStone",
          ),
          InformationCell(
            heading: "Friends Get",
            content: "1. 240 Coins on successful SignUp. \n\n2. 3 Month Zomato Gold Subscription on 1st MileStone",
          ),
          RoundedButton(
            width: 200,
            blurRadius: 0,
            borderColor: AppColors.white,
            splashColor: AppColors.white,
            onTap: () {
              Share.share('Check Out FinnEasy App, to get exclusive deals on popular brands along with stock investment. \n Download the App, and use referral code ${widget.referral}');
            },
            height: 50,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: AppColors.success,
            child: Text("Invite!",
                style: TextStyle(color: AppColors.white, fontSize: 15)),
          ),

        ],
      ),
    ));
  }
}
