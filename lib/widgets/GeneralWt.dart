import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controllers/controllers.dart';

class GeneralWt {
  UserController userController = Get.find<UserController>();

  ImageProvider<Object> getUserAvatarImage() {
    if (userController.user.photo != null && userController.user.photo != "") {
      print("Imagen del bucket (Prox.)");
      return NetworkImage(userController.user.photo!);
    } else {
      print("Imagen default");
      return const AssetImage('assets/images/defaultAvatar.png');
    }
  }
}
