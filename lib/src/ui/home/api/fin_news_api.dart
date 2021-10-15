import 'dart:convert';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:http/http.dart';

class FinNewsApi {
  static const String news_api_key = "cfcfd0cee00241fb96c286085eab7e08";

  static Future<FinNews> fetchNews() async {
    var url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=${news_api_key}";
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
      return FinNews.fromJson(data);
    }
    return FinNews();
  }
}