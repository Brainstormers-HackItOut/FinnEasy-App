// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/store/theme/theme_store.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:finneasy/src/widget/settings_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ThemeStore _themeStore;
  late LoginStore _loginStore;
  bool switchVal = false;
  @override
  void initState() {
    super.initState();
    _themeStore = context.read<ThemeStore>();
    _loginStore = context.read<LoginStore>();  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      appBar: Appbar(
        title: "Setting",
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.015
            ),
            CircleAvatar(
              radius: 50,
                child: Text(
                    "AT",
                    style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 15)
                )
            ),
            SizedBox(
                height: screenHeight * 0.015
            ),
            SettingsDivider(dividerTitle: "PERSONAL"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Name",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Ajinkya Taranekar",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Phone Number",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("+91 " + "8518076044",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    )
                  ],
                )
            ),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Email",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("ajinkyataranekar@gmail.com",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    )
                  ],
                )
            ),
            SizedBox(
                height: screenHeight * 0.015
            ),
            SettingsDivider(dividerTitle: "THEME"),
            Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Dark Mode",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
                    ),
                    Switch(value: switchVal, onChanged: (bool value) {
                      setState(() {
                        switchVal = !switchVal;
                      });
                      _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
                    })
                  ],
                )),
            SizedBox(
                height: screenHeight * 0.15
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                width: 200,
                blurRadius: 0,
                borderColor: AppColors.white,
                splashColor: AppColors.white,
                onTap: () {
                  _loginStore.logout(context);
                },
                height: 50,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: AppColors.error,
                child: Text("Log Out",
                    style: TextStyle(color: AppColors.white, fontSize: 15)),
              ),
            ),

          ],
        ),
      )
    );
  }
}