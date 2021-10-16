import 'dart:convert';
import 'dart:developer';
import 'package:finneasy/src/models/login/login_form.dart';
import 'package:finneasy/src/models/login/login_response.dart';
import 'package:finneasy/src/models/login/register_form.dart';
import 'package:finneasy/src/models/user/user.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/ui/stock_analysis/model/stock_tweets.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:http/http.dart';

class LoginApi {

  static Future<LoginResponse> login(LoginForm loginForm) async {
    var url = "http://20.198.81.29:8089/auth/login";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    log(loginForm.toString());
    Response response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(loginForm)
    );
    log(response.body.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    }
    return LoginResponse();
  }

  static Future<User> register(RegisterForm registerForm) async {
    var url = "http://20.198.81.29:8089/user/add";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json"
    };
    Response response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(registerForm)
    );
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    return User();
  }

  static Future<bool> authCheck() async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;

    var url = "http://20.198.81.29:8089/auth/check";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };
    Response response = await get(
        Uri.parse(url),
        headers: headers
    );

    if(response.statusCode == 200) {
      // dynamic data = jsonDecode(response.body);
      return true;
    }
    return false;
  }
}