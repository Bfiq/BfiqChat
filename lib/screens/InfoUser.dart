import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/styles.dart';
import 'package:message_app/widgets/GeneralWt.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* backgroundColor: AppStyles.primaryColor, */
        title: const Text("Datos del usuario"),
      ),
      backgroundColor: AppStyles.ghostWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GFAvatar(
              backgroundColor: AppStyles.ghostWhiteColor,
              backgroundImage: GeneralWt().getUserAvatarImage(),
              size: GFSize.LARGE,
              shape: GFAvatarShape.circle,
            ),
            Text(
                "${userController.user.names} ${userController.user.lastNames}"),
            Text(userController.user.email),
            //Agregar mas tipos de datos editadles
          ],
        ),
      ),
    );
  }
}
