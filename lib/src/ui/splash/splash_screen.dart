// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splashDelay = 3;
  late LoginStore _loginStore;

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    Widget screen = await _loginStore.getHomeScreen(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    _loginStore = Provider.of<LoginStore>(context);
    _loadWidget();
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  image: const DecorationImage(
                      image: AssetImage("assets/images/bse.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: null),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.85),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight*0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5, right: 5),
                          child: CircleAvatar(
                            radius: 50,
                            child: Image(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: RichText(
                              text: TextSpan(
                                semanticsLabel: "finneasy",
                                text: 'FinnEasy! \n',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 0.05 * screenWidth,
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Investment Made Easy! \n',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 0.04 * screenWidth,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ],
                )
            ),
          ],
        ));
  }
}