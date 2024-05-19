import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/controllers/chatController.dart';
import 'package:message_app/controllers/controllers.dart';
import 'package:message_app/styles.dart';
import 'package:message_app/widgets/GeneralWt.dart';
import 'InfoUser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find<UserController>();
  final ChatsController chatsController = Get.find<ChatsController>();
  final TabBarController tabController = Get.find<TabBarController>();
  final MessagesChatController messagesChatController =
      Get.find<MessagesChatController>();

  @override
  Widget build(BuildContext context) {
    print(tabController.selectedTab);
    return Scaffold(
        backgroundColor: AppStyles.ghostWhiteColor,
        bottomNavigationBar: GeneralWt().tabBar(),
        body: SafeArea(child: Obx(() {
          print(tabController.selectedTab);

          if (tabController.selectedTab.value == 1) {
            return const InfoUserScreen();
          }

          return tabZero();
        })),
        floatingActionButton: Obx(() {
          return Visibility(
            visible: tabController.selectedTab.value != 1,
            child: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, "/chat/add"),
              backgroundColor: AppStyles.primaryColor,
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          );
        }));
  }

  //Separar?
  Widget tabZero() {
    return Column(
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
