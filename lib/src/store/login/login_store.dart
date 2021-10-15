// Dart imports:
import 'dart:async';
import 'dart:math';

// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/models/login/login_form.dart';
import 'package:finneasy/src/ui/dashboard/dashboard.dart';
import 'package:finneasy/src/ui/onboarding/login_screen.dart';
import 'package:finneasy/src/ui/onboarding/otp_screen.dart';
import 'package:finneasy/src/ui/onboarding/password_screen.dart';
import 'package:finneasy/src/ui/onboarding/register_screen.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobx/mobx.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;


abstract class _LoginStore with Store {
  // sharedPreferenceRepository instance

  final SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
  String? verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  _LoginStore(){
    init();
  }

  init() async {
    
  }
  // actions:-------------------------------------------------------------------
  @action
  Future<Widget> getHomeScreen(BuildContext context) async{
    bool login = await checkLogin(context);
    if(login){
      return DashBoardScreen();
    }
    return const LoginScreen();
  }

  @action
  Future<bool> checkLogin(BuildContext context) async {
    String authToken = await _sharedPreferenceHelper.authToken;
    Map<String, dynamic> payload;
    try{
      payload = Jwt.parseJwt(authToken);
    }catch(e){
      return false;
    }
    if (payload['exp'] < DateTime.now().millisecondsSinceEpoch / 1000){
      logout(context);
    }
    return _sharedPreferenceHelper.isLoggedIn;
  }

  @action
  Future<void> login(BuildContext context, String mobile, TextEditingController passwordController, RoundedLoadingButtonController btnController ) async{
    final password = passwordController.text;
    if (mobile.isEmpty || password.isEmpty){
      btnController.error();
      showFlushBar(context, "Add credentials");
      btnController.reset();
    }
    else{
      final form = LoginForm(mobile: mobile, password: password);
      Object response;
      try{
        response = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqYXZhaW51c2UiLCJleHAiOjE2MzQzMDg2MDYsImlhdCI6MTYzNDI5MDYwNn0.JdvV8NJFApbxGsZi0hmDI8NfdmaYz-VmTXhgsUfN7CjmuUCpg4PU9wgZUdeSzy40YO_etKuCM88JlS4e_YGbrQ";
      }
      catch(e){
        btnController.error();
        showFlushBar(context, "Something went wrong. Please try again");
        btnController.reset();
        return;
      }
      Timer(const Duration(seconds: 2), () async{
        if (response is Error){
          btnController.error();
          showFlushBar(context, response.toString());
          btnController.reset();
          return;
        }
        else if (response is String){
          _sharedPreferenceHelper.saveIsLoggedIn(true);
          _sharedPreferenceHelper.saveAuthToken(response);
          showFlushBar(
              context,
              "Login Successfully",
              backgroundColor: AppColors.success,
              icon: Icons.check
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
          btnController.success();
        }
      });
    }
  }

  @action
  Future<void> register(BuildContext context, String mobile, TextEditingController passwordController,  String username, String email, RoundedLoadingButtonController btnController ) async{
    final password = passwordController.text;
    if (password.isEmpty){
      btnController.error();
      showFlushBar(context, "Add credentials");
      btnController.reset();
    }
    else{
      final form = LoginForm(mobile: mobile, password: password);
      Object response;
      try{
        response = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqYXZhaW51c2UiLCJleHAiOjE2MzQzMDg2MDYsImlhdCI6MTYzNDI5MDYwNn0.JdvV8NJFApbxGsZi0hmDI8NfdmaYz-VmTXhgsUfN7CjmuUCpg4PU9wgZUdeSzy40YO_etKuCM88JlS4e_YGbrQ";
      }
      catch(e){
        btnController.error();
        showFlushBar(context, "Something went wrong. Please try again");
        btnController.reset();
        return;
      }
      Timer(const Duration(seconds: 2), () async{
        if (response is Error){
          btnController.error();
          showFlushBar(context, response.toString());
          btnController.reset();
          return;
        }
        else if (response is String){
          _sharedPreferenceHelper.saveIsLoggedIn(true);
          _sharedPreferenceHelper.saveAuthToken(response);
          showFlushBar(
              context,
              "Login Successfully",
              backgroundColor: AppColors.success,
              icon: Icons.check
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
          btnController.success();
        }
      });
    }
  }

  @action
  Future<void> logout(BuildContext context) async{
    _sharedPreferenceHelper.saveIsLoggedIn(false);
    _sharedPreferenceHelper.removeAuthToken();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }


  Future<void> verifyPhone(BuildContext context, TextEditingController mobileController, RoundedLoadingButtonController btnController) async {
    final mobile = mobileController.text;
    if (mobile.isEmpty){
      btnController.error();
      showFlushBar(context, "Add credentials");
      btnController.reset();
    }
    else{
      await auth.verifyPhoneNumber(
          phoneNumber: "+91" + mobile,
          verificationCompleted: (PhoneAuthCredential credential) async {
            onVerificationComplete(credential, context);
          },
          verificationFailed: (FirebaseAuthException e) {
            showFlushBar(context, e.toString());
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            showFlushBar(context, "OTP Expired");
          },
          codeSent: (String verificationId, int? resendToken) async {
            this.verificationId = verificationId;
          }
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen(mobile: mobile)));
      btnController.success();
    }
  }

  Future signIn(BuildContext context, TextEditingController otpController, RoundedLoadingButtonController btnController) async {
    final otp = otpController.text;
    if (otp.isEmpty){
      btnController.error();
      showFlushBar(context, "Add credentials");
      btnController.reset();
    }
    else{
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      onVerificationComplete(credential, context);
      btnController.reset();
    }
  }

  onVerificationComplete(PhoneAuthCredential credential, BuildContext context) async {
    try {
      final UserCredential? userCredential = await auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential!.user;
      _sharedPreferenceHelper.saveUid(firebaseUser!.uid);
      bool isNewUser = userCredential.additionalUserInfo!.isNewUser;
      if(isNewUser) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(mobile: firebaseUser.phoneNumber!)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PasswordScreen(mobile: firebaseUser.phoneNumber!, isNewUser: isNewUser)));
      }
    } catch (e) {
      showFlushBar(context, e.toString());
    }
  }
}