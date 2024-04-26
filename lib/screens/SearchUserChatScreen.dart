import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:message_app/controllers/chatController.dart';
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
  ChatsController chatsController = Get.find<ChatsController>();

  Future<void> showBottom(String? idUser, String name) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nuevo chat"),
          content: Container(
              height: 120,
              /* color: AppStyles.primaryColor, */
              child: Column(
                children: [
                  idUser != null
                      ? Column(
                          children: [
                            Text('¿Quieres crear un nuevo chat con $name?',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold, /* color: Colors.white */
                                )),
                            const SizedBox(height: 20),
                            ButtonsWt().buttonPrimaryColor(() async {
                              bool result =
                                  await FirestoreService().createChat(idUser);

                              if (!result) {
                                GFToast.showToast(
                                    'Ha ocurrido un error', context,
                                    toastPosition: GFToastPosition.TOP,
                                    backgroundColor: GFColors.DANGER,
                                    toastDuration: 5);
                              } else {
                                if (mounted) {
                                  //Refrescar los datos
                                  chatsController.getDataChats();
                                  Navigator.pop(context);
                                }
                              }
                            }, "Crear Chat")
                          ],
                        )
                      : const Text("Ha ocurrido un error!"),
                ],
              )),
        );
      },
    );
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
                          .map((user) => ChatsWt()
                                  .userChat(user.names, user.lastNames, "", () {
                                showBottom(user.id, user.names);
                              }))
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
          child: const Center(
              child: Text(
            'Deseas crear un chat con ',
            style:
                TextStyle(fontSize: 15, wordSpacing: 0.3, letterSpacing: 0.2),
          )),
        ),
      ),
    );
  }
}
