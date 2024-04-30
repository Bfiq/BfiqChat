import 'package:get/get.dart';
import 'package:message_app/models/models.dart';
import 'package:message_app/services/firestore.dart';

class MessagesChatController extends GetxController {
  String chatId = "";
  Rx<UserModel?> user = Rx<UserModel?>(null);

  MessagesChatController(this.chatId);

  void setUser({required String id}) async {
    user.value = await FirestoreService().getUserByUid(id);

    print(user.value?.names ?? "Nombre!");
  }
}
