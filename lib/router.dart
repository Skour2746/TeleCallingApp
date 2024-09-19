import 'package:amazon_clone/View/auth/authScreen.dart';
import 'package:amazon_clone/View/homeScreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());

    case Homescreen.routeName:
      return MaterialPageRoute(builder: (_) => Homescreen());

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Page Not Exist"),
              )));
  }
}
