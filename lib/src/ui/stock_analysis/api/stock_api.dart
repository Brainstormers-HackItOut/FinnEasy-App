import 'dart:convert';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:http/http.dart';

class StockApi {

  static Future<List<dynamic>> searchStock(String query) async {
    var url = "${query}";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    List<dynamic> list = [];
    Response response = await get(
        Uri.parse(url),
        headers: headers
    );
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return [];
    }
    return [];
  }
}