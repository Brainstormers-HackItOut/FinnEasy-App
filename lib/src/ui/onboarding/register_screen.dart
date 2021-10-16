// Flutter imports:
import 'dart:developer';

import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/ui/onboarding/password_screen.dart';
import 'package:finneasy/src/widget/custom_text_form_field.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;
  const RegisterScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late LoginStore _loginStore;
  GlobalKey<FormState> onBoardingFormKey = GlobalKey<FormState>();

  // controllers and nodes for textfield
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  TextEditingController aadharController = TextEditingController();
  FocusNode aadharFocusNode = FocusNode();

  // button controllers
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  @override
  void dispose() {
    usernameController.dispose();
    usernameFocusNode.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    aadharController.dispose();
    aadharFocusNode.dispose();
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
                                      "Enter your Details!",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: screenWidth * 0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: usernameController,
                                        focusNode: usernameFocusNode,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true && value![0] == '0' ) {
                                            return 'Please enter valid username.';
                                          }
                                        },
                                        hintText: "💻  username",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: emailController,
                                        focusNode: emailFocusNode,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Please enter valid email.';
                                          }
                                        },
                                        hintText: "💻  email",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: screenHeight* 0.045),
                                      child: CustomTextFormField(
                                        controller: aadharController,
                                        focusNode: aadharFocusNode,
                                        maxLength: 12,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Please enter valid aadhar number.';
                                          }
                                        },
                                        hintText: "💻  aadhar number",
                                      ),
                                    ),
                                    Observer(
                                      builder: (context) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            RoundedButton(
                                              width: 200,
                                              blurRadius: 0,
                                              borderColor: AppColors.white,
                                              splashColor: AppColors.white,
                                              onTap: () {
                                                _loginStore.uploadAadhar(context, aadharController);
                                              },
                                              height: 50,
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              color: _loginStore.kyc ? AppColors.success : AppColors.error,
                                              child: Text("Upload Aadhar Card Image!",
                                                  style: TextStyle(color: AppColors.white, fontSize: 15)),
                                            ),
                                            Text(
                                              "KYC", style: TextStyle(color:  _loginStore.kyc ? AppColors.success : AppColors.error, fontSize: 15),
                                            ),
                                            Icon(
                                                _loginStore.kyc ? Icons.check : Icons.close,
                                              color:  _loginStore.kyc ? AppColors.success : AppColors.error,
                                            )
                                          ],
                                        );
                                      }
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
                                              'Proceed',
                                              style: TextStyle(
                                                  letterSpacing: 1,
                                                  color: Theme.of(context).secondaryHeaderColor,
                                                  fontSize: screenWidth * 0.05,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          controller: btnController,
                                          onPressed: () async {
                                            if (usernameController.text.isEmpty || emailController.text.isEmpty || aadharController.text.isEmpty || !_loginStore.kyc){
                                              btnController.error();
                                              showFlushBar(context, "Add credentials");
                                              btnController.reset();
                                            }
                                            else{
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PasswordScreen(
                                                    mobile: widget.mobile, 
                                                    isNewUser: true,
                                                    username: usernameController.text,
                                                    email: emailController.text
                                                )));
                                            }
                                          },
                                          width: screenWidth * 0.5,
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