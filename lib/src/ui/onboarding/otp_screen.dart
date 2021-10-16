// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;

  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late LoginStore _loginStore;
  GlobalKey<FormState> onBoardingFormKey = GlobalKey<FormState>();

  // controllers and nodes for textfield
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  // button controllers
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginStore = Provider.of<LoginStore>(context);
    _loginStore.startTimer();
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(Theme.of(context).cardColor.withOpacity(0.8), BlendMode.srcATop),
                          image: const AssetImage("assets/images/bse.jpg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                    ),
                    padding: EdgeInsets.zero,
                    child: Container()
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.35),
                  child: Container(
                    height: screenHeight * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Form(
                              key: onBoardingFormKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: screenHeight * 0.15,
                                    ),
                                    Text(
                                      "Enter OTP !",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: screenWidth * 0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.mobile,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: screenHeight* 0.02),
                                      child: CustomTextFormField(
                                        controller: otpController,
                                        focusNode: otpFocusNode,
                                        keyboardType: TextInputType.number,
                                        maxLength: 6,
                                        textInputAction: TextInputAction.next,
                                        obscureText: true,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Please enter valid otp.';
                                          }
                                        },
                                        hintText: "🔒  OTP",
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: screenWidth * 0.8,
                                        height: screenHeight * 0.15,
                                        child: RoundedLoadingButton(
                                          color: Theme.of(context).focusColor,
                                          errorColor: AppColors.error,
                                          successColor: AppColors.success,
                                          borderRadius: screenHeight * 0.15,
                                          child: Text(
                                              'OTP',
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: Theme.of(context).secondaryHeaderColor,
                                                  fontSize: screenWidth * 0.05,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          controller: btnController,
                                          onPressed: () async {
                                            _loginStore.signIn(context, otpController, btnController);
                                          },
                                          width: screenWidth * 0.5,
                                        ),
                                      ),
                                    ),
                                    Observer(
                                        builder: (BuildContext context) {
                                          return Container(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: _loginStore.currentTime != 0 ? Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "You will recieve OTP in ",
                                                      style: Theme.of(context).textTheme.subtitle1
                                                  ),
                                                  Text(
                                                      _loginStore.currentTime.toString(),
                                                      style: Theme.of(context).textTheme.subtitle2
                                                  ),
                                                ],
                                              ) : Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    _loginStore.retry(context, widget.mobile);
                                                  },
                                                  child: Text(
                                                    'Resend OTP!',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )
                                          );
                                        }
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.25),
                    child: CircleAvatar(
                      radius: screenWidth * 0.2,
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: CircleAvatar(
                        radius: screenWidth * 0.185,
                        backgroundColor: AppColors.white,
                        backgroundImage: const AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}