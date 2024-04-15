import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_app/models/UserModel.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future createAccount(
      String email, String password, String names, String lastNames) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      print('usuario: ${user!.uid}');

      //Crear el usuario en firestore
      final userModel =
          UserModel(names: names, lastNames: lastNames, email: email);

      print("CREE EL MODELO");
      print(userModel);
      await _db
          .collection("Usuarios")
          .doc(user.uid)
          .set(userModel.toFirebaseJson())
          .onError((error, stackTrace) {
        print(error);
        print(stackTrace);
      });

      print("Intente crear el usuario en firestore");

      return user.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        print("entre");
        return 1;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user;

      //Verificar que llega?
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-credential") {
        return 1;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
