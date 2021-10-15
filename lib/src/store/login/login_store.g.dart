// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
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

  @override
  String toString() {
    return '''

    ''';
  }
}
