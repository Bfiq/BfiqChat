import 'package:get/get.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/services/firestore.dart';
import '../models/models.dart';

//Controlador
class ChatsController extends GetxController {
  final RxBool _isLoading = false.obs;
  RxList<ChatModel> chats = RxList<ChatModel>([]);
  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    getDataChats();
  }

  void getDataChats() async {
    _isLoading.value = true;
    List<ChatModel> getChats =
        await FirestoreService().getChatsByUser(userController.user.id!);
    chats.value = getChats;
    _isLoading.value = false;
  }

  //getters
  bool get isLoading => _isLoading.value;
}
