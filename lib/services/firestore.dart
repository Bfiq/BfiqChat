import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  final UserController userController = Get.find<UserController>();

  Future<List<UserModel>> searchUsers(String textSearch) async {
    try {
      //Todos los usuariuos de prueba
      //final usersDB1 = _db.collection("Usuarios")
      //final usersDB = _db.collection("Usuarios").where("nombre", isEqualTo: textSearch);
      if (textSearch == null) {
        print("Dato: $textSearch");
      }
      print("Dato: $textSearch");
      final usersDB = _db
          .collection("Usuarios")
          .where("nombre", isGreaterThanOrEqualTo: textSearch)
          .where("nombre", isLessThanOrEqualTo: textSearch + '\uf8ff');

      QuerySnapshot querySnapshot = await usersDB.get();
      List<UserModel> usersModel = querySnapshot.docs.map((user) {
        print(user.data());
        print(user.id);

        final userModel =
            UserModel.fromFirebaseJson(user.data() as Map<String, dynamic>);
        userModel.id = user.id;
        return userModel;
      }).toList();

      return usersModel;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createChat(String idChatUser) async {
    try {
      print(userController.user.id);
      final chatRef = _db.collection("mensajes").doc();

      final chat =
          MessageModel(user1: userController.user.id!, user2: idChatUser);

      await chatRef.set(chat.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
