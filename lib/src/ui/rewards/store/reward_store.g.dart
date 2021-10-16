// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RewardsStore on _RewardsStore, Store {
  final _$dataAtom = Atom(name: '_RewardsStore.data');

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

  final _$shouldShowAtom = Atom(name: '_RewardsStore.shouldShow');

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

  final _$greetingMessageAtom = Atom(name: '_RewardsStore.greetingMessage');

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

  final _$isLoadingAtom = Atom(name: '_RewardsStore.isLoading');

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

  final _$refreshRewardsAsyncAction =
      AsyncAction('_RewardsStore.refreshRewards');

  @override
  Future<void> refreshRewards() {
    return _$refreshRewardsAsyncAction.run(() => super.refreshRewards());
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
