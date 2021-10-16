import 'package:finneasy/resources/colors.dart';
import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  final String dividerTitle;

  SettingsDivider({required this.dividerTitle});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(dividerTitle, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
          padding: EdgeInsets.all(10),
        ),
      )
    ]);
  }
}