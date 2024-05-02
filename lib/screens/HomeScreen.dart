import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/controllers/chatController.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/models/models.dart';
import 'package:message_app/services/firestore.dart';
import 'package:message_app/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find<UserController>();
  final ChatsController chatsController = Get.find<ChatsController>();
  final MessagesChatController messagesChatController =
      Get.find<MessagesChatController>();

  @override
  Widget build(BuildContext context) {
    print(userController.user.id);
    print(userController.user.names);
    return Scaffold(
      backgroundColor: AppStyles.ghostWhiteColor,
      bottomNavigationBar: DefaultTabController(
          length: 3,
          child: TabBar(
              onTap: (value) {
                print(value);
              },
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Colors.grey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                ),
              ])),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 50,
                  width: 50,
                  child: const Icon(Icons.search),
                )
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Mensajes",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
            Obx(() {
              if (chatsController.chats.isNotEmpty) {
                return Expanded(
                  child: Column(
                      children: chatsController.chats
                          .map((chat) => userChat(chat.idUserMessaging,
                              chat.nameUser, chat.lastName, ""))
                          .toList()),
                );
              } else {
                if (chatsController.isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("Aún no hay chats :c");
                }
              }
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/chat/add"),
        backgroundColor: AppStyles.primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  Widget userChat(
    //Agregar fecha y hora?
    String uid,
    String nameUser,
    String lastNameUser,
    String lastMessage,
  ) {
    final textAvatar =
        "${nameUser.substring(0, 1)}${lastNameUser.substring(0, 1)}";
    return GFListTile(
      onTap: () {
        messagesChatController.setUser(id: uid);

        Navigator.pushNamed(context, "/messagesChat",
            arguments: {'idUserChat': uid});
      },
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
