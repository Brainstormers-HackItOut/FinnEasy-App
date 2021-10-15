// Flutter imports:
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  focusColor: Colors.blueAccent.shade400,
  primarySwatch: Colors.blue,
  primaryColor: Colors.blueAccent,
  secondaryHeaderColor: Colors.white,
  selectedRowColor: Colors.white,
  cardColor: Colors.blueAccent,
  bottomAppBarColor: Colors.blueAccent,
  backgroundColor: Colors.white,
  canvasColor: Colors.white
  /* light theme settings */
  );

final ThemeData themeDataDark = ThemeData(
  brightness: Brightness.dark,
  focusColor: Colors.indigoAccent.shade700,
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  cardColor: Colors.grey.shade900,
  bottomAppBarColor: Colors.black,
  selectedRowColor: Colors.grey.shade800,
  backgroundColor: Colors.grey.shade900,
  secondaryHeaderColor: Colors.grey.shade100,
  canvasColor: Colors.grey[850]
  /* dark theme settings */
  );
