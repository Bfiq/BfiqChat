import 'package:flutter/material.dart';
import './screens/screens.dart';

class AppRoutes {
  static const initialRoute = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (_) => const InitialScreen(),
    "/Register": (_) => const RegisterScreen(),
    "/login": (_) => const LoginScreen(),
    "/home": (_) => const HomeScreen(),
    "/chat/add": (_) => const SearchUserChatScreen(),
    "/messagesChat": (_) => const MessagingChatScreen(),
  };

  static onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const InitialScreen());
  }
}
