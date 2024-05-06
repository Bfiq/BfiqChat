import 'package:get/get.dart';
import 'package:message_app/models/models.dart';
import 'package:message_app/services/storage.dart';
import '../widgets/widgets.dart';

class UserController extends GetxController {
  var user = UserModel(names: "", lastNames: "", email: "");

  void setUser(
      {required String id,
      required String names,
      required String lastNames,
      required String email,
      String? photo}) {
    user.id = id;
    user.names = names;
    user.lastNames = lastNames;
    user.email = email;
    user.photo = photo;
  }

  Future<void> changePhotoUser() async {
    final image = await GeneralWt().pickImageFromGallery();

    if (image != null) {
      final result = await StorageService().sendImageToStorage(image);

      //actualizar el path de la imagen en firestore/users
    }
  }
}
