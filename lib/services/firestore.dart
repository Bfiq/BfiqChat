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
      final chatRef = _db.collection("chat").doc();

      final chat =
          MessageModel(user1: userController.user.id!, user2: idChatUser);

      await chatRef.set(chat.toJson());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ChatModel>> getChatsByUser(String userId) async {
    try {
      print("Entre a buscar los chats");
      //Se cambio el modelo de firestore al no poder agrupar directamente desde la query
      final queryGetChats = _db
          .collection("chat")
          .where("user1", isEqualTo: userController.user.id)
          .get();

      QuerySnapshot snapshot = await queryGetChats;

      snapshot.docs.map((chat) {
        final chatResult = chat.data();

        if (chatResult is Map<String, dynamic> &&
            chatResult.containsKey("user2")) {
          //Buscar el user2
          final userChat = getUserByUid(chatResult['user2']);
        }

        //ChatModel(idUserMessaging: , nameUser: nameUser, lastName: lastName)
      });

      return [];
    } catch (e) {
      return [];
    }
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      print("Entre a buscar el usuario del chat");
      final queryGetUserByUid = _db.collection("Usuarios").doc(uid).get();

      final result = await queryGetUserByUid;
      print(result);
    } catch (e) {
      return null;
    }
  }
}
