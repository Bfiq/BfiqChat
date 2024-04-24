import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
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

  @override
  Widget build(BuildContext context) {
    print(userController.user.id);
    print(userController.user.names);
    return Scaffold(
      backgroundColor: AppStyles.ghostWhiteColor,
      bottomNavigationBar: const DefaultTabController(
          length: 3,
          child: TabBar(
              /* onTap: (value) => print(value), */
              indicatorColor: Colors.black,
              tabs: [
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
            FutureBuilder(
              future:
                  FirestoreService().getChatsByUser(userController.user.id!),
              builder: (context, AsyncSnapshot<List<ChatModel>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Column(
                      children: snapshot.data!
                          .map((chat) =>
                              userChat(chat.nameUser, chat.lastName, ""))
                          .toList() /* [
                        userChat("Juan", "Ojeda", "Ultimo mensaje..."),
                        //GFShimmer(child: userChat("Vanessa", "Sierra", "nada")) // retornar el widget con containers vacios
                      ] */
                      ,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("Ha ocurrido un error!");
                }
              },
            ),
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
