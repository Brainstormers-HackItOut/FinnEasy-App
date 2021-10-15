import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:finneasy/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showFlushBar(
    BuildContext context,
    String message, {
      IconData icon = Icons.error_outline_rounded,
      Color iconColor = AppColors.white,
      bool isDismissible = true,
      Color backgroundColor = AppColors.error,
      Duration duration = const Duration(seconds: 3),
      FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
    }) {
  return Flushbar(
    message: message,
    borderRadius: BorderRadius.circular(8),
    margin: EdgeInsets.all(8),
    backgroundColor: backgroundColor,
    flushbarPosition: flushbarPosition,
    isDismissible: isDismissible,
    icon: Icon(
      icon,
      color: iconColor,
    ),
    duration: duration,
  ).show(context);
}