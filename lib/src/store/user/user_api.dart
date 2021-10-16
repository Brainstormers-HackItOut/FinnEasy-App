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
import 'package:jwt_decode/jwt_decode.dart';

class UserApi {

  static Future<User> fetchUser() async {
    SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
    String  authToken = await _sharedPreferenceHelper.authToken;
    Map<String, dynamic> payload = Jwt.parseJwt(authToken);

    var url = "http://20.198.81.29:8089/user/${payload["sub"]}";
    dynamic headers = <String, String>{
      "accept": "*/*",
      'Content-Type': "application/json",
      "Authorization": "Bearer $authToken"
    };

    Response response = await get(
        Uri.parse(url),
        headers: headers
    );
    log(response.statusCode.toString());
    if(response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    return User();
  }

}