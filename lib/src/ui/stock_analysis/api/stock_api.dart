import 'dart:convert';
import 'dart:developer';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_search.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:http/http.dart';

class StockApi {

  static Future<List<StockSearch>> searchStock(String query) async {
    var url = "http://20.198.81.29:8000/search?query=$query";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    List<StockSearch> list = [];
    Response response = await get(
        Uri.parse(url),
        headers: headers
    );
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (int i = 0; i < (data as List).length; i++) {
        list.add(StockSearch.fromJson(data[i]));
      }
      return list;
    }
    return [];
  }

  static Future<StockTweets> stockTweetAnalysis(String symbol) async {
    var url = "http://20.198.81.29:8000/sentiment/$symbol";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    Response response = await get(
        Uri.parse(url),
        headers: headers
    );
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return StockTweets.fromJson(data);
    }
    return StockTweets();
  }

  static Future<StockTweets> cashFlowAnalysis(List<Map<String, dynamic>> messages) async {
    var url = "http://20.198.81.29:8000/transaction-info/";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    print(messages);
    // Response response = await post(
    //     Uri.parse(url),
    //     headers: headers,
    //     body: jsonEncode(messages)
    // );
    // if(response.statusCode == 200) {
    //   dynamic data = jsonDecode(response.body);
    //   return StockTweets.fromJson(data);
    // }
    return StockTweets();
  }
}