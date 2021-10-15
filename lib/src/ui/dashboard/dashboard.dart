// Flutter imports:
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late LoginStore _loginStore;

  @override
  Widget build(BuildContext context) {
    _loginStore = Provider.of<LoginStore>(context);
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: IconButton(
            icon: Icon(
              Icons.logout
            ),
            onPressed: () {
              _loginStore.logout(context);
            },
          ),
        )
    );
  }
}