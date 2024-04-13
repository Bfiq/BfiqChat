import 'package:flutter/material.dart';
import '../styles.dart';
import '../widgets/widgets.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 230,
            ),
            /* 
            Padding(
              padding: const EdgeInsets.all(15),
              child: const Text("ChatApp"),
            ), */
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 25),
                        constraints:
                            const BoxConstraints.tightForFinite(width: 270),
                        child: Image.asset('assets/images/bfiqMsg.png'),
                      ),
                      ButtonsWt().buttonPrimaryColor(
                          () => Navigator.pushNamed(context, "/login"),
                          "Iniciar Sesión"),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/Register"),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          /* constraints:
                              const BoxConstraints.tightForFinite(width: 130), */
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppStyles.primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "Registrarse",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 112, 65, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
