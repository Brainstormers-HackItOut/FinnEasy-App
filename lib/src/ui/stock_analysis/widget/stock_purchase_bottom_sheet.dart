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
  final String symbol;
  final String stockName;
  final double stockPrice;

  late double screenHeight, screenWidth;

  ShoppingBottomSheet({
    Key? key,
    required this.store,
    required this.stockName,
    required this.symbol,
    required this.stockPrice}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    store.stockTweetAnalysis(symbol);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Observer(
      builder: (context) {
        return store.tweets != null ? ObserverNetworkState(
            networkState: store.isLoading,
            taskToBeDone: AlertDialog(
              title: Text(
                "${store.tweets.twPol} \n " + (store.tweets.globalPolarity! > 0 ? "BUY THIS" : "SELL THIS"),
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: screenWidth * 0.063,
                ),
              ),
              content: Column(
                children: [
                  Tweets(tweets: store.tweets,),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Add Stocks",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      wordSpacing: 1.5,
                      fontSize: screenWidth * 0.055,
                    ),
                  ),
                  Observer(
                      builder: (_) {
                        return Row(
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
                              width: screenWidth * 0.035,
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
                        );
                      }
                  ),
                ],
              ),
              actions: [
                RoundedButton(
                  onTap: () {
                    store.buy(
                        symbol,
                        stockName,
                        stockPrice
                    );
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
                    store.sell(
                        symbol,
                        stockName,
                        stockPrice
                    );
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
                  borderColor: AppColors.white,
                ),
              ],
            )
        ) : const CircularProgressIndicator();
      }
    );
  }

}