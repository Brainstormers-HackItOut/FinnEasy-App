// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginStore _loginStore;
  GlobalKey<FormState> onBoardingFormKey = GlobalKey<FormState>();

  // controllers and nodes for textfield
  TextEditingController mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  // button controllers
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  @override
  void dispose() {
    mobileController.dispose();
    mobileFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginStore = Provider.of<LoginStore>(context);
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
                                      "Welcome !",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: screenWidth * 0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: mobileController,
                                        focusNode: mobileFocusNode,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true && value![0] == '0' ) {
                                            return 'Please enter valid mobile number.';
                                          }
                                        },
                                        hintText: "💻  Mobile Number",
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
                                              'Send OTP!',
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: Theme.of(context).secondaryHeaderColor,
                                                  fontSize: screenWidth * 0.05,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          controller: btnController,
                                          onPressed: () async {
                                            _loginStore.verifyPhone(context, mobileController, btnController);
                                          },
                                          width: screenWidth * 0.5,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                        },
                                        child: Text(
                                            'By Signing in You agree to Terms and conditions',
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: Theme.of(context).primaryColor,
                                                fontSize: screenWidth * 0.035,
                                                fontWeight: FontWeight.w400
                                            )
                                        ),
                                      ),
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