// Flutter imports:
import 'package:finneasy/resources/app_theme.dart';
import 'package:finneasy/resources/routes.dart';
import 'package:finneasy/resources/strings.dart';
import 'package:finneasy/src/store/login/login_store.dart';
import 'package:finneasy/src/store/theme/theme_store.dart';
import 'package:finneasy/src/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// Project imports:

class FinnEasy extends StatelessWidget {
  FinnEasy({Key? key}) : super(key: key);

  final ThemeStore _themeStore = ThemeStore();
  final LoginStore _loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<LoginStore>(create: (_) => _loginStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}