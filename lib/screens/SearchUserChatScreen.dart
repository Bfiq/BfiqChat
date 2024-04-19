import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/models/models.dart';
import 'package:message_app/styles.dart';
import 'package:message_app/widgets/widgets.dart';
import '../services/firestore.dart';

class SearchUserChatScreen extends StatefulWidget {
  const SearchUserChatScreen({super.key});

  @override
  State<SearchUserChatScreen> createState() => _SearchUserChatScreenState();
}

class _SearchUserChatScreenState extends State<SearchUserChatScreen> {
  final _searcher = TextEditingController();
  final GFBottomSheetController _controller = GFBottomSheetController();

  showBottom(/* String idUser, String name */) {
    _controller.isBottomSheetOpened
        ? _controller.hideBottomSheet()
        : _controller.showBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.ghostWhiteColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: const Text("Busqueda de usuarios"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextField(
              controller: _searcher,
              decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  iconColor: AppStyles.primaryColor,
                  hintText: "Buscar",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                //Actualizar la busqueda
                //Setsate?
                setState(() {
                  //Refrescar la vista
                });
              },
            ),
          ),
          FutureBuilder(
            future: FirestoreService().searchUsers(_searcher.text),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.hasData) {
                //Cargar listado de widgets

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!
                          .map((user) => ChatsWt().userChat(
                              user.names,
                              user.lastNames,
                              "",
                              () =>
                                  showBottom() /*createChat(user.id ?? "", user.names)*/))
                          .toList(), //asegurarse de que hallan datos
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("Cargando...");
              }
            },
          ),
        ],
      ),
      bottomSheet: GFBottomSheet(
        controller: _controller,
        contentBody: Container(
          height: 200,
          child: Center(
              child: Text(
            'Deseas crear un chat con ',
            style: const TextStyle(
                fontSize: 15, wordSpacing: 0.3, letterSpacing: 0.2),
          )),
        ),
        stickyFooter: GestureDetector(
          onTap: () => print("Crear chat"),
          child: Container(
              color: AppStyles.primaryColor,
              child: const Text('Crear Chat',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
      ),
    );
  }
}
