import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(color: Colors.white),
                  height: 50,
                  width: 50,
                  child: Icon(Icons.search),
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
            Expanded(
              child: Column(
                children: [
                  userChat("Juan", "Ojeda", "Ultimo mensaje..."),
                  //GFShimmer(child: userChat("Vanessa", "Sierra", "nada")) // retornar el widget con containers vacios
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Buscar Usuario"),
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
