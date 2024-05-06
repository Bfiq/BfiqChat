import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:message_app/controllers/controllers.dart';

class StorageService {
  final storage = FirebaseStorage.instance;
  UserController userModel = Get.find<UserController>();

  Future<bool> sendImageToStorage(File file) async {
    try {
      //
      final storageRef = storage.ref();
      final nameFileinStorage =
          "photoProfiles/${userModel.user.id}${DateTime.now()}.jpg";
      final mountainsRef = storageRef.child(nameFileinStorage);
      print(mountainsRef);

      final fileStorage = await mountainsRef.putFile(file);
      print(fileStorage);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
