// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$currentTimeAtom = Atom(name: '_LoginStore.currentTime');

  @override
  int get currentTime {
    _$currentTimeAtom.reportRead();
    return super.currentTime;
  }

  @override
  set currentTime(int value) {
    _$currentTimeAtom.reportWrite(value, super.currentTime, () {
      super.currentTime = value;
    });
  }

  final _$getHomeScreenAsyncAction = AsyncAction('_LoginStore.getHomeScreen');

  @override
  Future<Widget> getHomeScreen(BuildContext context) {
    return _$getHomeScreenAsyncAction.run(() => super.getHomeScreen(context));
  }

  final _$checkLoginAsyncAction = AsyncAction('_LoginStore.checkLogin');

  @override
  Future<bool> checkLogin(BuildContext context) {
    return _$checkLoginAsyncAction.run(() => super.checkLogin(context));
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<void> login(
      BuildContext context,
      String mobile,
      TextEditingController passwordController,
      RoundedLoadingButtonController btnController) {
    return _$loginAsyncAction.run(
        () => super.login(context, mobile, passwordController, btnController));
  }

  final _$registerAsyncAction = AsyncAction('_LoginStore.register');

  @override
  Future<void> register(
      BuildContext context,
      String mobile,
      TextEditingController passwordController,
      String username,
      String email,
      RoundedLoadingButtonController btnController) {
    return _$registerAsyncAction.run(() => super.register(
        context, mobile, passwordController, username, email, btnController));
  }

  final _$logoutAsyncAction = AsyncAction('_LoginStore.logout');

  @override
  Future<void> logout(BuildContext context) {
    return _$logoutAsyncAction.run(() => super.logout(context));
  }

  final _$retryAsyncAction = AsyncAction('_LoginStore.retry');

  @override
  Future retry(BuildContext context, String mobile) {
    return _$retryAsyncAction.run(() => super.retry(context, mobile));
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void startTimer() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTime: ${currentTime}
    ''';
  }
}
