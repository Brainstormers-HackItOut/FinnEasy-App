// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/widget/custom_text_form_field.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PasswordScreen extends StatefulWidget {
  final String mobile;
  final bool isNewUser;
  final String email;
  final String username;

  const PasswordScreen({Key? key, required this.mobile, required this.isNewUser, this.email = "", this.username = ""}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late LoginStore _loginStore;
  GlobalKey<FormState> onBoardingFormKey = GlobalKey<FormState>();

  // controllers and nodes for textfield
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();

  // button controllers
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocusNode.dispose();
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
                                      "Enter your Password!",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: screenWidth * 0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: passwordController,
                                        focusNode: passwordFocusNode,
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: true,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true && value![0] == '0' ) {
                                            return 'Please enter valid password.';
                                          }
                                        },
                                        hintText: "🔒  password",
                                      ),
                                    ),
                                    widget.isNewUser ? Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: confirmPasswordController,
                                        focusNode: confirmPasswordFocusNode,
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: true,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true && value == passwordController.text) {
                                            return 'Password doesnt match';
                                          }
                                        },
                                        hintText: "🔒  confirm password",
                                      ),
                                    ) : const SizedBox.shrink(),
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
                                              'Login',
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: Theme.of(context).secondaryHeaderColor,
                                                  fontSize: screenWidth * 0.05,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          controller: btnController,
                                          onPressed: () async {
                                            if (widget.isNewUser && passwordController.text != confirmPasswordController.text){
                                              btnController.error();
                                              showFlushBar(context, "Password don't match");
                                              btnController.reset();
                                            }
                                            else{
                                              if (widget.isNewUser){
                                                _loginStore.register(context, widget.mobile, passwordController, widget.username, widget.email, btnController);
                                              }
                                              else{
                                                _loginStore.login(context, widget.mobile, passwordController, btnController);
                                              }
                                            }
                                          },
                                          width: screenWidth * 0.5,
                                        ),
                                      ),
                                    ),
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