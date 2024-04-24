import 'package:get/get.dart';

//Controlador
class ChatsController extends GetxController {
  final RxBool newChat = false.obs;

  @override
  void onInit() {
    super.onInit();
    //Definir Suscripciones
    ever(newChat, (_) {
      newChat.value = true;
    });
  }
}
