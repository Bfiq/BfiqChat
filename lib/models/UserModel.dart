class UserModel {
  String? id;
  String names;
  String lastNames;
  String email;
  //Agregar Foto

  UserModel(
      {this.id,
      required this.names,
      required this.lastNames,
      required this.email});

  factory UserModel.fromFirebaseJson(Map<String, dynamic> json) => UserModel(
      names: json['nombre'] ?? "",
      lastNames: json['apellidos'] ?? "",
      email: json['email'] ?? "");

  Map<String, dynamic> toFirebaseJson() => {
        'nombre': names,
        'apellidos': lastNames,
        'email': email,
      };
}
