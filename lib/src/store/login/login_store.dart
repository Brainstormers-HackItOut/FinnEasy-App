// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

// Flutter imports:
import 'package:file_picker/file_picker.dart';
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/models/login/login_form.dart';
import 'package:finneasy/src/models/login/login_response.dart';
import 'package:finneasy/src/models/login/register_form.dart';
import 'package:finneasy/src/models/user/user.dart' as user;
import 'package:finneasy/src/ui/dashboard/dashboard.dart';
import 'package:finneasy/src/ui/onboarding/login_screen.dart';
import 'package:finneasy/src/ui/onboarding/otp_screen.dart';
import 'package:finneasy/src/ui/onboarding/password_screen.dart';
import 'package:finneasy/src/ui/onboarding/register_screen.dart';
import 'package:finneasy/src/ui/rewards/api/reward_api.dart';
import 'package:finneasy/src/utils/shared_preference_helper.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:finneasy/src/widget/reward_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobx/mobx.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_api.dart';

// Project imports:

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;


abstract class _LoginStore with Store {
  // sharedPreferenceRepository instance

  final SharedPreferenceHelper _sharedPreferenceHelper = SharedPreferenceHelper();
  String? verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;

  @observable
  int currentTime = 30;

  @observable
  bool kyc = false;

  late Timer _timer;

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
      return const DashBoardScreen(index: 0,);
    }
    return const LoginScreen();
  }

  @action
  void startTimer() {
    currentTime = 30;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (currentTime == 0) {
          timer.cancel();
        } else {
          currentTime--;
        }
      },
    );
  }

  @action
  Future<bool> checkLogin(BuildContext context) async {
    String authToken = await _sharedPreferenceHelper.authToken;
    Map<String, dynamic> payload;
    try{
      payload = Jwt.parseJwt(authToken);
      dev.log(payload.toString());
    }catch(e){
      return false;
    }
    if (payload['exp'] < DateTime.now().millisecondsSinceEpoch / 1000){
      // logout(context);
    }
    return _sharedPreferenceHelper.isLoggedIn;
  }
  @action
  uploadAadhar(BuildContext context, TextEditingController aadharController) async {
    final aadhar = aadharController.text;
    if (aadhar.isEmpty){
      showFlushBar(context, "Add aadhar number first");
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image
    );
    if (result != null) {
      PlatformFile aadharImage = result.files.single;
      bool status = false;
      try {
        status = await LoginApi.verifyAadhar(aadharImage, aadhar);
      } catch(e){
        showFlushBar(context, "Something went wrong. Please try again");
        return;
      }
        if (status){
          showFlushBar(context, "Aadhar match Successfully",
              backgroundColor: AppColors.success, icon: Icons.check);
          kyc = true;
        } else{
          showFlushBar(context, "Doesn't match. Please try again");
        }
    } else {
      showFlushBar(context, "Operation Cancelled. Please try again");
    }
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
      final form = LoginForm(phoneNumber: mobile, password: password);
      LoginResponse response;
      try{
        response = await LoginApi.login(form);
      }
      catch(e){
        btnController.error();
        showFlushBar(context, "Something went wrong. Please try again");
        btnController.reset();
        return;
      }
      Timer(const Duration(seconds: 2), () async{
        _sharedPreferenceHelper.saveIsLoggedIn(true);
        _sharedPreferenceHelper.saveAuthToken(response.token!);
        bool auth = false;
        try{
          auth = await LoginApi.authCheck();
        }
        catch(e){
          dev.log(e.toString());
          btnController.error();
          showFlushBar(context, "Something went wrong. Please try again");
          btnController.reset();
          return;
        }
        if (auth) {
          showFlushBar(context, "Login Successfully",
              backgroundColor: AppColors.success, icon: Icons.check);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const DashBoardScreen(
                    index: 0,
                  )),
                  (Route<dynamic> route) => route.isFirst);
          btnController.success();
        } else{
          btnController.error();
          showFlushBar(context, "Password Incorrect. Please try again");
          btnController.reset();
          return;
        }
      });
    }
  }

  @action
  Future<void> register(BuildContext context, String mobile, TextEditingController passwordController,  String username, String email, TextEditingController referralController,  RoundedLoadingButtonController btnController ) async{
    final password = passwordController.text;
    if (password.isEmpty){
      btnController.error();
      showFlushBar(context, "Add credentials");
      btnController.reset();
    }
    else{
      RegisterForm registerForm ;
        registerForm = RegisterForm(
          phoneNumber: mobile,
          password: password,
          emailId: email,
          firstName: username.split(" ")[0],
          lastName: username.split(" ")[1],
        );
      final loginForm = LoginForm(
          phoneNumber: mobile,
          password: password,
      );
      LoginResponse response;
      user.User userResponse;
      try{
        dev.log(registerForm.toString());
        userResponse = await LoginApi.register(registerForm);
        dev.log(userResponse.toString());
        response = await LoginApi.login(loginForm);
      }
      catch(e){
        btnController.error();
        showFlushBar(context, "Something went wrong. Please try again");
        btnController.reset();
        return;
      }
      Timer(const Duration(seconds: 2), () async{
          _sharedPreferenceHelper.saveIsLoggedIn(true);
          _sharedPreferenceHelper.saveAuthToken(response.token!);
          if (referralController.text.isNotEmpty) {
            bool referral = await RewardApi.rewardsReferral(referralController.text);
          }
            showFlushBar(context, "Register Successfully",
                backgroundColor: AppColors.success, icon: Icons.check);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen(
                          index: 0,
                        )),
                (Route<dynamic> route) => route.isFirst);
            showRewardDialog(context, userResponse.totalRewards!);
            btnController.success();
      });
    }
  }

  @action
  Future<void> logout(BuildContext context) async{
    _sharedPreferenceHelper.saveIsLoggedIn(false);
    _sharedPreferenceHelper.removeAuthToken();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @action
  Future<void> retry(BuildContext context, String mobile) async{
    startTimer();
    await auth.verifyPhoneNumber(
        phoneNumber: "+91" + mobile,
        verificationCompleted: (PhoneAuthCredential credential) async {
          onVerificationComplete(credential, context);
        },
        verificationFailed: (FirebaseAuthException e) {
          showFlushBar(context, e.toString());
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          showFlushBar(context, "OTP Expired");
        },
        codeSent: (String verificationId, int? resendToken) async {
          this.verificationId = verificationId;
        }
    );
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
          timeout: const Duration(seconds: 120),
          codeAutoRetrievalTimeout: (String verificationId) {
            showFlushBar(context, "OTP Expired");
          },
          codeSent: (String verificationId, int? resendToken) async {
            this.verificationId = verificationId;
          }
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(mobile: mobile)));
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(mobile: firebaseUser.phoneNumber!)));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordScreen(mobile: firebaseUser.phoneNumber!, isNewUser: isNewUser)));
      }
    } catch (e) {
      showFlushBar(context, e.toString());
    }
  }
}