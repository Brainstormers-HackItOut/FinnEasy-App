import 'package:flutter/material.dart';

class InformationCell extends StatelessWidget {
  final String heading;
  final String content;

  InformationCell({
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold),
          ),
          Divider(color: Theme.of(context).primaryColor, thickness: 1.0),
          Text(
            content.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: screenWidth * 0.06),
          ),
        ],
      ),
    );
  }
}