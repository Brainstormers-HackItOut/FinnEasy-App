// Flutter imports:
import 'dart:math';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:flutter/material.dart';


class Tweets extends StatelessWidget {
  final StockTweets tweets;

  const Tweets({Key? key, required this.tweets}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          for (int i =0; i < min(tweets.twList!.length, 8); i++)
              Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).selectedRowColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.black
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).selectedRowColor,
                        blurRadius: 0.0,
                    ),
                  ]
              ),
              child: ListTile(
                title: Text(
                  tweets.twList![i].substring(0, min(tweets.twList![i].length, 100)) + '...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ),
        ]
      ),
    );
  }
}
