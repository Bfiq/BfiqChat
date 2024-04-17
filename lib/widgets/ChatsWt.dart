import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/styles.dart';

class ChatsWt {
  Widget userChat(
    //Agregar fecha y hora?
    //Enviar uid para redirigir al chat
    String nameUser,
    String lastNameUser,
    String lastMessage,
  ) {
    final textAvatar =
        "${nameUser.substring(0, 1)}${lastNameUser.substring(0, 1)}";
    return GFListTile(
      titleText: nameUser,
      subTitleText: lastMessage,
      avatar: GFAvatar(
        backgroundColor: AppStyles.primaryColor,
        shape: GFAvatarShape.circle,
        child: Text(
          textAvatar,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
