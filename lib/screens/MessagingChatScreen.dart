import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/controllers/messagesChatController.dart';
import 'package:message_app/services/firestore.dart';
import 'package:message_app/styles.dart';

import '../models/models.dart';

class MessagingChatScreen extends StatefulWidget {
  const MessagingChatScreen({super.key});

  @override
  State<MessagingChatScreen> createState() => _MessagingChatScreenState();
}

class _MessagingChatScreenState extends State<MessagingChatScreen> {
  final _messageController = TextEditingController();
  MessagesChatController messagesController =
      Get.find<MessagesChatController>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    messagesController.chatId = arguments['idUserChat'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        leading: GFAvatar(
          shape: GFAvatarShape.circle,
          backgroundColor: AppStyles.ghostWhiteColor,
        ),
        title: Text("Nombre del usuario"),
      ),
      backgroundColor: AppStyles.ghostWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: FirestoreService().getMessages(messagesController.chatId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error al cargar los mensajes'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<MessageModel> messages = snapshot.data ?? [];

              return SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: messages.map((message) {
                  return messageWt(message);
                }).toList(),
              ));
            },
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: "Mensaje",
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  await FirestoreService().sendMessage(
                      messagesController.chatId,
                      _messageController.text,
                      null,
                      null);

                  _messageController.clear();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget messageWt(MessageModel message) {
    final date = message.date!.toDate();
    var colorMessage = Colors.white;
    var alingmentMessage = MainAxisAlignment.start;

    if (message.user1 == userController.user.id) {
      //poner el chat de color verde y a la izquierda
      colorMessage = AppStyles.primaryColor;
      alingmentMessage = MainAxisAlignment.end;
    }

    if (message.message != null) {
      return Row(
        mainAxisAlignment: alingmentMessage,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorMessage,
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(message.message ?? ""),
                      const SizedBox(height: 5),
                      Text(date.toString().substring(10, 16)),
                    ],
                  ),
                )),
          ),
        ],
      );
    }

    return const Text("");
  }
}
