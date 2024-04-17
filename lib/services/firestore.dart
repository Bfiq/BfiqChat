import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> searchUsers(String textSearch) async {
    try {
      //Todos los usuariuos de prueba
      //final usersDB1 = _db.collection("Usuarios")
      //final usersDB = _db.collection("Usuarios").where("nombre", isEqualTo: textSearch);
      if (textSearch == null) {
        print("Dato: $textSearch");
      }
      print("Dato: $textSearch");
      final usersDB = _db
          .collection("Usuarios")
          .where("nombre", isGreaterThanOrEqualTo: textSearch)
          .where("nombre", isLessThanOrEqualTo: textSearch + '\uf8ff');

      QuerySnapshot querySnapshot = await usersDB.get();
      List<UserModel> usersModel = querySnapshot.docs.map((user) {
        print(user.data());
        return UserModel.fromFirebaseJson(user.data() as Map<String, dynamic>);
      }).toList();

      return usersModel;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
