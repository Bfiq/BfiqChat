import 'package:get/get.dart';
import 'package:message_app/models/models.dart';
import 'package:message_app/services/firestore.dart';

class MessagesChatController extends GetxController {
  String chatId = "";
  MessagesChatController(this.chatId);

  RxList<MessageModel> messages = RxList<MessageModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    /* FirestoreService().getMessages(chatId).then((messages) {
      this.messages = messages.obs as RxList<MessageModel>;
    }); */
  }
}
