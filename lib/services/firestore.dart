import 'dart:async';

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
    List<ChatModel> chats = [];
    try {
      print("Entre a buscar los chats");
      print(userController.user.id);
      //Se cambio el modelo de firestore al no poder agrupar directamente desde la query
      final queryGetChats = _db
          .collection("chat")
          .where("user1", isEqualTo: userController.user.id);

      QuerySnapshot snapshot = await queryGetChats.get();

      print(snapshot.docs);
      for (var doc in snapshot.docs) {
        print(doc.data());
        final chatResult = doc.data();

        if (chatResult is Map<String, dynamic> &&
            chatResult.containsKey("user2")) {
          //Buscar el user2
          UserModel? userChat = await getUserByUid(chatResult['user2']);

          if (userChat != null) {
            final chat = ChatModel(
                idUserMessaging: userChat.id!,
                nameUser: userChat.names,
                lastName: userChat.lastNames);

            chats.add(chat);
          }
        }
      }

      return chats;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      print("Entre a buscar el usuario del chat");
      final queryGetUserByUid = _db.collection("Usuarios").doc(uid).get();

      final result = await queryGetUserByUid;
      var userModel = UserModel.fromFirebaseJson(result.data()!);
      userModel.id = uid;

      //print(userModel.id);
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Stream<List<MessageModel>> getMessages(String uid) async* {
    List<MessageModel> messages = [];
    try {
      final queryGetMessages = _db
          .collection("mensajes")
          .where("user1", isEqualTo: userController.user.id)
          .where("user2", isEqualTo: uid);

      // Iniciar listener para actualizaciones en tiempo real
      queryGetMessages.snapshots().listen((snapshot) {
        for (var message in snapshot.docs) {
          print(message.data());
          MessageModel messageModel = MessageModel.fromJson(message.data());
          print("Modelo del mensaje");
          print(messageModel);
          messages.add(messageModel);
          print(messages);
        }
      });

      //controller.add(messages);
      print("Mensajes ha enviar");
      print(messages);
      yield messages;
    } catch (e) {
      print(e);
      //controller.addError("Error");
      yield [];
    }
  }

  Future<void> sendMessage(
      String uid, String? message, String? pathImage, String? pathAudio) async {
    //Si envia un audio o imagen guardar en el bucket de storage
    try {
      final messageModel = MessageModel(
          user1: userController.user.id!,
          user2: uid,
          message: message,
          imageUrl: pathImage,
          audioUrl: pathAudio,
          date: Timestamp.fromDate(DateTime.now()));

      final result = _db.collection("mensajes").doc();

      await result.set(messageModel.toJson());
    } catch (e) {
      print(e);
      return;
    }
  }
}
