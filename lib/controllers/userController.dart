import 'package:get/get.dart';
import 'package:message_app/models/models.dart';

class UserController extends GetxController {
  var user = UserModel(names: "", lastNames: "", email: "");

  void setUser(
      {required String id,
      required String names,
      required String lastNames,
      required String email}) {
    user.id = id;
    user.names = names;
    user.lastNames = lastNames;
    user.email = email;
  }
}
