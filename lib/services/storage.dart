import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:message_app/controllers/controllers.dart';

class StorageService {
  final storage = FirebaseStorage.instance;
  UserController userModel = Get.find<UserController>();

  Future<String> sendImageToStorage(File file) async {
    try {
      final storageRef = storage.ref();
      final nameFileinStorage =
          "photoProfiles/${userModel.user.id}${DateTime.now()}.jpg";
      final mountainsRef = storageRef.child(nameFileinStorage);
      print(mountainsRef);

      /* final fileStorage =  */ await mountainsRef.putFile(file);
      /* print(fileStorage); */

      final urlImage = await mountainsRef.getDownloadURL();
      print(urlImage);

      return urlImage;
    } catch (e) {
      print(e);
      return "Error";
    }
  }
}
