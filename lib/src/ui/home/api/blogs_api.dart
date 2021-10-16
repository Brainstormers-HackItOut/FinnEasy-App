import 'dart:convert';
import 'dart:developer';
import 'package:finneasy/src/models/login/login_form.dart';
import 'package:finneasy/src/models/login/login_response.dart';
import 'package:finneasy/src/models/login/register_form.dart';
import 'package:finneasy/src/models/user/user.dart';
import 'package:finneasy/src/ui/home/model/blog_response.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:http/http.dart';

class BlogApi {

  static Future<List<BlogResponse>> fetchBlogs() async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;

    var url = "http://20.198.81.29:8089/blog/all";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };
    Response response = await get(
        Uri.parse(url),
        headers: headers
    );

    log(response.body.toString());
    List<BlogResponse> temp = [];
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (int i = 0; i < (data as List).length; i++){
        temp.add(BlogResponse.fromJson(data[i]));
      }
      return temp;
    }
    return temp;
  }

  static Future<BlogResponse> createBlog(BlogResponse blog) async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;

    var url = "http://20.198.81.29:8089/blog/create";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };
    Response response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(blog),
    );
    log(response.body.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return BlogResponse.fromJson(data);
    }
    return BlogResponse();
  }

  static Future<BlogResponse> likeBlog(int blog_id) async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;

    var url = "http://20.198.81.29:8089/blog/like/$blog_id";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };

    Response response = await get(
      Uri.parse(url),
      headers: headers,
    );

    log(response.body.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return BlogResponse.fromJson(data);
    }
    return BlogResponse();
  }

  static Future<BlogResponse> disLikeBlog(int blog_id) async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;

    var url = "http://20.198.81.29:8089/blog/dislike/$blog_id";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };

    Response response = await get(
      Uri.parse(url),
      headers: headers,
    );

    log(response.body.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return BlogResponse.fromJson(data);
    }
    return BlogResponse();
  }

}