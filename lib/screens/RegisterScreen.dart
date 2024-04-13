import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../styles.dart';
import '../widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formRegisterKey = GlobalKey<FormState>();
  final _namesController = TextEditingController();
  final _lastNamesController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      appBar: AppBar(
        title: const Center(child: Text("Registro")),
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
                    key: formRegisterKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Nombres",
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
                                controller: _namesController,
                                decoration: AppStyles.inputPrincipalDecoration),
                            const Text(
                              "Apellidos",
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
                                controller: _lastNamesController,
                                decoration: AppStyles.inputPrincipalDecoration),
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

                                final passwordRegex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');

                                if (!passwordRegex.hasMatch(value!)) {
                                  return 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una minúscula, un número y un carácter especial';
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
                              if (formRegisterKey.currentState!.validate()) {
                                // Si el formulario es válido, guarda los datos
                                final result = await AuthService()
                                    .createAccount(_emailController.text,
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
                                        "Este correo ya esta siendo usado en el sistema",
                                        context,
                                        backgroundColor: Colors.redAccent,
                                        toastDuration: 5);
                                  }
                                  return;
                                }

                                //Navigator.pushNamed(context, "home");
                              }
                            }, "Registrarse")
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
