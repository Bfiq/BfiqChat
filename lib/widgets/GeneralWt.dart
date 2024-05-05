import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:image_picker/image_picker.dart';

class GeneralWt {
  UserController userController = Get.find<UserController>();
  TabBarController tabBarController = Get.find<TabBarController>();

  ImageProvider<Object> getUserAvatarImage() {
    if (userController.user.photo != null && userController.user.photo != "") {
      print("Imagen del bucket (Prox.)");
      return NetworkImage(userController.user.photo!);
    } else {
      print("Imagen default");
      return const AssetImage('assets/images/defaultAvatar.png');
    }
  }

  Widget tabBar() {
    return DefaultTabController(
        length: 3,
        child: TabBar(
            onTap: (value) {
              tabBarController.selectedTab.value = value;
            },
            indicatorColor: Colors.black,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.chat_bubble,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
              ),
            ]));
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    File? imageFile;

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    }

    return imageFile;
  }
}
