import 'package:firebase/screens/forgot_password_page.dart';
import 'package:firebase/providers/main_page.dart';
import 'package:firebase/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import '../screens/verify_email_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Hello world"));
      case '/resetPassword':
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordPage());
      case '/verifyEmail':
        return MaterialPageRoute(builder: (context) => const VerifyEmailPage());
      /* case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());*/
      case '/':
        return MaterialPageRoute(builder: (context) => const MainPage());

      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text("error"),
                    centerTitle: true,
                  ),
                  body: const Center(
                    child: Text("Page Not Found"),
                  ),
                ));
    }
  }
}
