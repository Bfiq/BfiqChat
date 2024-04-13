import 'package:flutter/material.dart';
import './screens/screens.dart';

class AppRoutes {
  static const initialRoute = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (_) => const InitialScreen(),
    "/Register": (_) => const RegisterScreen(),
    "/login": (_) => const LoginScreen(),
    /* "/home" : const HomeScreen(),
    "/chat" : const ChatScreen(), */
  };

  static onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const InitialScreen());
  }
}
