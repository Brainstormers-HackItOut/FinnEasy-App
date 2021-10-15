// Flutter imports:
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  void Function() refresh;

  ErrorScreen({
    required this.refresh
  });

  late double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Align(
              child: Image(
                  image: AssetImage("assets/images/error.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter),
            ),

            Text(
              "Something went wrong",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
              ),
            ),
            RoundedButton(
                blurRadius: 0.0,
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(screenWidth * 0.15),
                borderColor: Theme.of(context).primaryColor,
                height: 60.0,
                width: 150.0,
                onTap: refresh,
                color: Theme.of(context).secondaryHeaderColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.chevron_left,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "Refresh",
                        style: TextStyle( color: Theme.of(context).primaryColor),
                      ),
                    ]
                )
            ),
          ],
        )
    );
  }
}