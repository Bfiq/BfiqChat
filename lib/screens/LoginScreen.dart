import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints.tightForFinite(width: 270),
                child: Image.asset('assets/images/message.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: const Text("ChatApp"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => print("Loguear"),
                      child: Container(
                        height: 50,
                        constraints:
                            const BoxConstraints.tightForFinite(width: 130),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Ingresar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => print("Redirigir al registro"),
                      child: Container(
                        height: 50,
                        constraints:
                            const BoxConstraints.tightForFinite(width: 130),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueAccent, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
