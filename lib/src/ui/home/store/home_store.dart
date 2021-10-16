// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/dashboard/dashboard.dart';
import 'package:intl/intl.dart';
// Flutter imports:

// Package imports:
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/store/user/user_api.dart';
import 'package:finneasy/src/ui/home/api/fin_news_api.dart';
import 'package:finneasy/src/ui/home/api/blogs_api.dart';
import 'package:finneasy/src/ui/home/model/blog_response.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/models/user/user.dart';
import 'package:finneasy/src/utils/greeting.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';


// Project imports:

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;


abstract class _HomeStore with Store {
  final String TAG = "_HomeStore";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();

  @observable
  Map<String, dynamic> data = {};

  @observable
  bool shouldShow = true;

  @observable
  String greetingMessage = "";

  @observable
  NetworkState isLoading = NetworkState.initial;

  @observable
  FinNews news = FinNews();

  @observable
  User user = User();

  @observable
  List<BlogResponse> blog = [];

  @observable
  List<bool> blogLikeDislike = [];

  _HomeStore() {
    refreshHome();
    shouldShowGreeting();
  }

  @action
  Future<void> refreshHome() async {
    isLoading = NetworkState.loading;
    try {
      news = await FinNewsApi.fetchNews();
      user = await UserApi.fetchUser();
      blog = await BlogApi.fetchBlogs();
      blogLikeDislike = List.filled(blog.length, false);
      _sharedPreferenceHelper.saveUserId(user.id!);
      greetingMessage = greeting();
      isLoading = NetworkState.completed;
    } catch (e, st) {
      isLoading = NetworkState.error;
      showFlushBar(scaffoldKey.currentContext!, e.toString());
      log(e.toString(), stackTrace: st);
    }
  }

  @action
  Future<void> shouldShowGreeting() async {
    await Future.delayed(Duration(seconds: 5));
    shouldShow = false;
  }

  @action
  Future<void> blogCreate(BuildContext context, TextEditingController titleController, TextEditingController bodyController) async {
    final title = titleController.text;
    final body = bodyController.text;
    if (title.isEmpty || body.isEmpty){
      showFlushBar(context, "Add data");
    }
    else{
      int user_id = await _sharedPreferenceHelper.userId;
      final form = BlogResponse(
        body: body,
        userId: user_id,
        title: title,
        publishedDate: DateFormat('dd/MM/yyyy').format(DateTime.now()).toString()
      );
      BlogResponse response;
      try{
        response = await BlogApi.createBlog(form);
      }
      catch(e){
        showFlushBar(context, "Something went wrong. Please try again");
        return;
      }
      showFlushBar(context, "Fweet published",
            backgroundColor: AppColors.success, icon: Icons.check);

      await Future.delayed(Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const DashBoardScreen(
                index: 0,
              )),
              (Route<dynamic> route) => route.isFirst);
    }
  }

  @action
  Future<void> likeDislike(BuildContext context, int index, int blog_id) async {
    if (!blogLikeDislike[index]){
      BlogResponse response;
      try{
        response = await BlogApi.likeBlog(blog_id);
        blogLikeDislike[index] = true;
      }
      catch(e){
        showFlushBar(context, "Something went wrong. Please try again");
        return;
      }
    } else {
        BlogResponse response;
        try{
          response = await BlogApi.disLikeBlog(blog_id);
          blogLikeDislike[index] = false;
        }
        catch(e){
          showFlushBar(context, "Something went wrong. Please try again");
          return;
        }
    }
  }


}

