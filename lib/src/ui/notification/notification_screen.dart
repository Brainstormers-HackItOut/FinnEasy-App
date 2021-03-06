// Flutter imports:
import 'dart:math';

import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/list_cell.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// Project imports:

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);


  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

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
          title: "Notifications",
        ),
        body: SingleChildScrollView(
      child: Column (
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/notification.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: null)
        ],
      ),
    ));
  }
}
