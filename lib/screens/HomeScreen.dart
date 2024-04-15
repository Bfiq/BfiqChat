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
            Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    onPressed: () => print("Buscar Usuario"))),
            Text("data")
          ],
        ),
      ),
    );
  }
}
