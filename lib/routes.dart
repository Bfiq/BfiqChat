import 'package:flutter/material.dart';
import './screens/screens.dart';

class AppRoutes {
  static const initialRoute = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (_) => const InitialScreen(),
    /* "/home" : const HomeScreen(),
    "/chat" : const ChatScreen(), */
  };

  static onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const InitialScreen());
  }
}
