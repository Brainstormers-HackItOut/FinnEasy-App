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

  final _$refreshHomeAsyncAction = AsyncAction('_HomeStore.refreshHome');

  @override
  Future<void> refreshHome() {
    return _$refreshHomeAsyncAction.run(() => super.refreshHome());
  }

  final _$shouldShowGreetingAsyncAction =
      AsyncAction('_HomeStore.shouldShowGreeting');

  @override
  Future<void> shouldShowGreeting() {
    return _$shouldShowGreetingAsyncAction
        .run(() => super.shouldShowGreeting());
  }

  @override
  String toString() {
    return '''
data: ${data},
shouldShow: ${shouldShow},
greetingMessage: ${greetingMessage},
isLoading: ${isLoading}
    ''';
  }
}
