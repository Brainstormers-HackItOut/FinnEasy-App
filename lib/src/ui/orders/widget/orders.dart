// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/orders/model/order.dart';
import 'package:finneasy/src/utils/url_launcher.dart';
import 'package:flutter/material.dart';


class Orders extends StatelessWidget {
  final List<Order> orders;
  const Orders({Key? key, required this.orders}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return SingleChildScrollView(
      child: orders.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          for (int i = 0; i < orders.length; i++)
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
                    orders[i].companyCode!
                  )
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).primaryColor,
                    size: screenWidth * 0.05,
                  ), onPressed: () {
                    launchURL(context, "https://in.tradingview.com/chart/?symbol=NSE%3A${orders[i].companyCode!}");
                },
                ),
                title: Text(
                  orders[i].companyName!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Text(
                  "${orders[i].type!} - ${orders[i].quantity!} @ Rs. ${orders[i].stockPrice!}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ),
        ]
      ) : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/notification.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: null)
    );
  }
}
