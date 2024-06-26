import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:message_app/controllers/chatController.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/controllers/userController.dart';
import 'services/firebase_options.dart';
import './routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions =
      await DefaultFirebaseOptions.currentPlatform;

  await Firebase.initializeApp(options: firebaseOptions);

  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9009); //revisar el emulador local

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<UserController>(() => UserController());
        Get.lazyPut<ChatsController>(() => ChatsController());
        Get.lazyPut<MessagesChatController>(() => MessagesChatController(""));
        Get.lazyPut<TabBarController>(() => TabBarController());
      }),
    );
  }
}
