// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:
import 'package:finneasy/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
// Project imports:

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await Firebase.initializeApp();

  return runZonedGuarded(() async {
    runApp(FinnEasy());
  }, (error, stack) {
    log(stack.toString());
    log(error.toString());
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}