// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$dataAtom = Atom(name: '_HomeStore.data');

  @override
  Map<String, dynamic> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(Map<String, dynamic> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$shouldShowAtom = Atom(name: '_HomeStore.shouldShow');

  @override
  bool get shouldShow {
    _$shouldShowAtom.reportRead();
    return super.shouldShow;
  }

  @override
  set shouldShow(bool value) {
    _$shouldShowAtom.reportWrite(value, super.shouldShow, () {
      super.shouldShow = value;
    });
  }

  final _$greetingMessageAtom = Atom(name: '_HomeStore.greetingMessage');

  @override
  String get greetingMessage {
    _$greetingMessageAtom.reportRead();
    return super.greetingMessage;
  }

  @override
  set greetingMessage(String value) {
    _$greetingMessageAtom.reportWrite(value, super.greetingMessage, () {
      super.greetingMessage = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomeStore.isLoading');

  @override
  NetworkState get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(NetworkState value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$newsAtom = Atom(name: '_HomeStore.news');

  @override
  FinNews get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(FinNews value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$userAtom = Atom(name: '_HomeStore.user');

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$blogAtom = Atom(name: '_HomeStore.blog');

  @override
  List<BlogResponse> get blog {
    _$blogAtom.reportRead();
    return super.blog;
  }

  @override
  set blog(List<BlogResponse> value) {
    _$blogAtom.reportWrite(value, super.blog, () {
      super.blog = value;
    });
  }

  final _$blogLikeDislikeAtom = Atom(name: '_HomeStore.blogLikeDislike');

  @override
  List<bool> get blogLikeDislike {
    _$blogLikeDislikeAtom.reportRead();
    return super.blogLikeDislike;
  }

  @override
  set blogLikeDislike(List<bool> value) {
    _$blogLikeDislikeAtom.reportWrite(value, super.blogLikeDislike, () {
      super.blogLikeDislike = value;
    });
  }

  final _$refreshHomeAsyncAction = AsyncAction('_HomeStore.refreshHome');

  @override
  Future<void> refreshHome(bool notHome) {
    return _$refreshHomeAsyncAction.run(() => super.refreshHome(notHome));
  }

  final _$shouldShowGreetingAsyncAction =
      AsyncAction('_HomeStore.shouldShowGreeting');

  @override
  Future<void> shouldShowGreeting() {
    return _$shouldShowGreetingAsyncAction
        .run(() => super.shouldShowGreeting());
  }

  final _$blogCreateAsyncAction = AsyncAction('_HomeStore.blogCreate');

  @override
  Future<void> blogCreate(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController bodyController) {
    return _$blogCreateAsyncAction
        .run(() => super.blogCreate(context, titleController, bodyController));
  }

  final _$likeDislikeAsyncAction = AsyncAction('_HomeStore.likeDislike');

  @override
  Future<void> likeDislike(BuildContext context, int index, int blog_id) {
    return _$likeDislikeAsyncAction
        .run(() => super.likeDislike(context, index, blog_id));
  }

  @override
  String toString() {
    return '''
data: ${data},
shouldShow: ${shouldShow},
greetingMessage: ${greetingMessage},
isLoading: ${isLoading},
news: ${news},
user: ${user},
blog: ${blog},
blogLikeDislike: ${blogLikeDislike}
    ''';
  }
}
