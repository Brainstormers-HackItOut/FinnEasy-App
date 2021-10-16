// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/stock_analysis/store/stock_store.dart';
import 'package:finneasy/src/ui/stock_analysis/widget/tweets.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

class ShoppingBottomSheet extends StatelessWidget {
  final StockStore store;
  final String stockname;

  late double screenHeight, screenWidth;

  ShoppingBottomSheet({Key? key, required this.store, required this.stockname}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return BottomSheet(
      onClosing: () {  },
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)
                )
            ),
            child: Observer(
                builder: (_) {
                  return ObserverNetworkState(
                    taskToBeDone: sheet(),
                    networkState: store.isLoading,
                  );
                }
            )
        );
      },
    );
  }


  Widget sheet(){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight*0.02),
          Flexible(
            flex: 1,
            child: Text(
              '${store.tweets.twPol} THIS',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: screenWidth * 0.063,
              ),
            ),
          ),
          Tweets(tweets: store.tweets),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: screenWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    if (store.totalnumofshare > 1) {
                      store.totalnumofshare--;
                    }
                  },
                  child: Icon(
                    Icons.expand_more,
                    color: AppColors.white,
                    size: screenWidth * 0.075,
                  ),
                  color: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  color: AppColors.white,
                  width: screenWidth / 2.5,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      store.totalnumofshare.toString(),
                      style: TextStyle(
                        color: Color(0xff1B1D38),
                        wordSpacing: 1.5,
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    store.totalnumofshare++;
                  },
                  color: AppColors.success,
                  child: Icon(
                    Icons.expand_less,
                    color: AppColors.white,
                    size: screenWidth * 0.075,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                  onTap: () {
                    store.buy();
                  },
                  child: Text(
                    '  BUY  ',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w900),
                  ),
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(5),
                  splashColor: AppColors.white,
                  height: 40,
                  width: 100,
                  blurRadius: 0,
                  borderColor: AppColors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                RoundedButton(
                  onTap: () {
                    store.sell();
                  },
                  child: Text(
                    '  SELL  ',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w900),
                  ),
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(5),
                  splashColor: AppColors.primaryColor,
                  height: 40,
                  width: 100,
                  blurRadius: 0,
                  borderColor: AppColors.primaryColor,
                ),
              ]),

        ]
      )
    );
  }

}