import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/styles.dart';

class MessagingChatScreen extends StatefulWidget {
  const MessagingChatScreen({super.key});

  @override
  State<MessagingChatScreen> createState() => _MessagingChatScreenState();
}

class _MessagingChatScreenState extends State<MessagingChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
          Text("Mensaje 1"),
          TextField(
            decoration: InputDecoration(hintText: "Mensaje"),
          )
        ],
      ),
    );
  }
}
