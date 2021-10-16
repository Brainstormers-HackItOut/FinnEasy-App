// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:flutter/material.dart';


class RedeemedRewards extends StatelessWidget {
  const RedeemedRewards({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          for (int i =0; i< 10; i++)
              Container(
                width: screenWidth * 0.9,
                margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Theme.of(context).selectedRowColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 1.5,
                    color: AppColors.black
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).selectedRowColor,
                        blurRadius: 0.0,
                    ),
                  ]
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    "AT"
                  )
                ),
                trailing: Icon(
                  Icons.thumb_up_sharp,
                  color: Theme.of(context).primaryColor,
                  size: screenWidth * 0.05,
                ),
                title: Text(
                  "Ajinkya Taranekar",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Text(
                  "Today will be a good deal with Tata, buy maximum stocks.",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ),
        ]
      ),
    );
  }
}
