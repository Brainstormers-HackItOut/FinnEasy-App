// Flutter imports:
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Icon? leadingIcon;
  final Function? leadingFunction;
  final Icon? trailingIcon;
  final Function? trailingFunction;

  @override
  final Size preferredSize;

  Appbar({
    this.title,
    this.leadingFunction,
    this.leadingIcon,
    this.trailingIcon,
    this.trailingFunction,
    this.preferredSize = const Size.fromHeight(50.0),
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          (title ?? "").toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: screenWidth*0.04,
              color: Theme.of(context).secondaryHeaderColor
          ),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        leading: leadingIcon != null ? IconButton(
          icon: leadingIcon!,
          onPressed: () {leadingFunction!();},
          color: Theme.of(context).secondaryHeaderColor,
        ): null,
        actions: trailingIcon != null ? <Widget>[
          IconButton(
            icon: trailingIcon!,
            onPressed: () {trailingFunction!();},
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ] : null
    );
  }
}