import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../services/auth.dart';
import '../styles.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      appBar: AppBar(
        title: const Center(child: Text("Inicio de Sesión")),
        backgroundColor: AppStyles.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppStyles.ghostWhiteColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formLoginKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Correo Electronico",
                              style: AppStyles.textGeneralStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: (value) {
                                  if (value == "") {
                                    return "Llena el campo";
                                  }

                                  final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                  if (!emailRegex.hasMatch(value!)) {
                                    return 'Por favor ingrese un correo electrónico válido';
                                  }
                                },
                                controller: _emailController,
                                decoration: AppStyles.inputPrincipalDecoration),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Contraseña",
                              style: AppStyles.textGeneralStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Llena el campo";
                                }
                              },
                              obscureText: true,
                              controller: _passwordController,
                              decoration: AppStyles.inputPrincipalDecoration,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonsWt().buttonPrimaryColor(() async {
                              if (_formLoginKey.currentState!.validate()) {
                                // Si el formulario es válido, guarda los datos
                                final result = await AuthService()
                                    .loginWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text);

                                if (result == null) {
                                  if (mounted) {
                                    GFToast.showToast(
                                        "Ha ocurrido un error inesperado",
                                        context);
                                  }
                                  return;
                                }

                                if (result == 1) {
                                  if (mounted) {
                                    GFToast.showToast(
                                        "Email o Contraseña incorrecta",
                                        context,
                                        backgroundColor: Colors.redAccent,
                                        toastDuration: 5);
                                  }
                                  return;
                                }

                                //Navigator.pushNamed(context, "home");
                              }
                            }, "Iniciar Sesión")
                          ],
                        ),
                      ),
                    ),
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
