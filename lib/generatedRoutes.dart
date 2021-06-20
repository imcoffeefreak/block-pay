import 'package:block_pay/main.dart';
import 'package:block_pay/view/authenticationV2.dart';
import 'package:block_pay/view/home_page.dart';
import 'package:block_pay/view/register.dart';
import 'package:flutter/material.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/auth":
        return MaterialPageRoute(builder: (_) => AuthenticationV2());
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/check":
        return MaterialPageRoute(builder: (_) => Transition());
          case "/register":
        return MaterialPageRoute(builder: (_) => RegisterUser());
      default:
        return MaterialPageRoute(builder: (_) => AuthenticationV2());
    }
  }
}
