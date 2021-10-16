// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/store/theme/theme_store.dart';
import 'package:finneasy/src/ui/error/error_screen.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:finneasy/src/ui/more/referral.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/information_cell.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:finneasy/src/widget/settings_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  late HomeStore _homeStore;

  bool switchVal = false;
  @override
  void initState() {
    super.initState();
    initstate();
  }

  initstate(){
    _themeStore = context.read<ThemeStore>();
    _loginStore = context.read<LoginStore>();
    _homeStore = HomeStore(notHome: true);
  }

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
      body: Observer(
        builder: (context) {
          return ObserverNetworkState(
            networkState: _homeStore.isLoading,
            taskToBeDone: SingleChildScrollView(
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
                          _homeStore.user.firstName.toString()[0].toUpperCase() + _homeStore.user.lastName.toString()[0].toUpperCase()
                      )
                  ),
                  SizedBox(
                      height: screenHeight * 0.015
                  ),
                  InformationCell(
                    heading: "name",
                    content: _homeStore.user.firstName.toString() + " " + _homeStore.user.lastName.toString(),
                  ),
                  InformationCell(
                    heading: "phone number",
                    content: _homeStore.user.phoneNumber.toString(),
                  ),
                  InformationCell(
                    heading: "email",
                    content: _homeStore.user.emailId.toString(),
                  ),
                  SizedBox(
                      height: screenHeight * 0.015
                  ),
                  SettingsDivider(dividerTitle: "THEME"),
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 10),
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
                      height: screenHeight * 0.015
                  ),
                  SettingsDivider(dividerTitle: "OTHERS"),
                  GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReferralScreen(referral: _homeStore.user.referralCode.toString())))
                      , child: InformationCell(
                    heading: "Refer",
                    content: "Invite your Friends",
                  )),
                  SizedBox(
                      height: screenHeight * 0.1
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
            ),
            errorOccured: ErrorScreen(
              refresh: initstate,
            ),
          );
        }
      )
    );
  }
}