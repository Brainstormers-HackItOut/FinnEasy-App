// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/widget/flushbar.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';

// Project imports:

class Cards extends StatelessWidget {
  Color color;
  String text;
  String coins;
  String description;
  bool isEnabled;
  String image;

  Cards({required this.color, required this.description, required this.text, required this.coins, required this.isEnabled, required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RoundedButton(
          blurRadius: 0.0,
          splashColor: Theme.of(context).secondaryHeaderColor,
          borderRadius:
          BorderRadius.circular(screenWidth * 0.05),
          borderColor: Theme.of(context).secondaryHeaderColor,
          height: screenHeight * 0.15,
          width: screenWidth * 0.15,
          onTap: () {
            if (isEnabled){
              showFlushBar(context, "Thank You For Redeeming the Gift ...", backgroundColor: AppColors.success, icon: Icons.check);
            } else{
              showFlushBar(context, "Invest More to level Up!");
            }
          },
          color: AppColors.lighten(color, 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: screenWidth * 0.2,
                    width: screenWidth * 0.2,
                    margin: EdgeInsets.fromLTRB(0, screenWidth * 0.04, screenWidth * 0.04,0),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            image
                          ),
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(color.withOpacity(0.6), BlendMode.dstATop),

                      ),
                      border: Border.all(color: AppColors.white),
                      borderRadius: BorderRadius.all(
                          Radius.circular(50.0)
                      ),
                    ),
                    child: Text(
                        coins + " \n coins",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: screenWidth * 0.045
                      ),
                    ),
                  )
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.04, 0, 0, screenWidth * 0.04),
                      child: Text(
                        text + '\n-' + description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.darken(color, 0.2),
                            fontSize: screenWidth * 0.040,
                            fontWeight: FontWeight.w800),
                      )
                  )
              ),
            ],
          ),
        )
    );
  }
}