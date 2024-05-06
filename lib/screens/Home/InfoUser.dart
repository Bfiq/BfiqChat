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
        backgroundColor: AppStyles.primaryColor,
        title: const Text("Datos del usuario"),
      ),
      backgroundColor: AppStyles.ghostWhiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      GFAvatar(
                        backgroundColor: AppStyles.ghostWhiteColor,
                        backgroundImage: GeneralWt().getUserAvatarImage(),
                        size: 100,
                        shape: GFAvatarShape.circle,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppStyles.primaryColor,
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () async {
                                userController.changePhotoUser();
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.edit)),
                        ),
                      )
                    ],
                  )),
              Text(
                "${userController.user.names} ${userController.user.lastNames}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(userController.user.email),
              //Agregar mas tipos de datos editadles
            ],
          ),
        ),
      ),
    );
  }
}
