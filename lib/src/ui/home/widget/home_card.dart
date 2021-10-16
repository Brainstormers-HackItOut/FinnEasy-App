// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeCard extends StatefulWidget {
  final HomeStore store;

  const HomeCard({Key? key, required this.store}) : super(key: key);


  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard>{
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    
    return Container(
      height: screenHeight * 0.2,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(32.0), bottomLeft: Radius.circular(32.0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: AppColors.black,
              blurRadius: 2.0,
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, bottom: 5, right: 5),
            child: RichText(
              text: TextSpan(
                semanticsLabel: "name",
                text: "Hello, \n",
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 0.07 * screenWidth,
                    fontWeight: FontWeight.bold
                  ),
                children: <TextSpan>[
                  TextSpan(
                    text: (widget.store.user.firstName.toString()) + " " + (widget.store.user.lastName.toString()) +  ' 👋\n',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 0.06 * screenWidth,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            )
          ),
          SizedBox(
            width: screenWidth * 0.05,
          ),
          Text(
            "${500} coins",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 0.04 * screenWidth,
                fontWeight: FontWeight.w400
            ),
          ),
          Icon(
            Icons.monetization_on,
            color: AppColors.white,
          )
        ],
      )
    );
  }
}
