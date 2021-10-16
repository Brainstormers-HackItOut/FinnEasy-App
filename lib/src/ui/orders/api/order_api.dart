import 'dart:convert';
import 'dart:developer';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/ui/orders/model/order.dart';
import 'package:finneasy/src/ui/rewards/model/reward.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_search.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:http/http.dart';

class OrderApi {

  static Future<List<Order>> fetchAllOrder() async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String authToken = await _sharedPreferenceHelper.authToken;
    int user_id = await _sharedPreferenceHelper.userId;

    var url = "http://20.198.81.29:8089/stock/$user_id";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };

    Response response = await get(
      Uri.parse(url),
      headers: headers
    );
    List<Order> temp = [];
    log(response.body.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for ( int i = 0; i < (data as List).length; i++) {
        temp.add(Order.fromJson(data[i]));
      }
      return temp;
    }
    return temp;
  }

}