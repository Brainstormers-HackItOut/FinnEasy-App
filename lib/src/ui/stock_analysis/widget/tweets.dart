// Flutter imports:
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
          for (int i =0; i < tweets.twList!.length ; i++)
              Container(
                width: screenWidth * 0.9,
                margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.02),
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
                  tweets.twList![i],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.05,
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
